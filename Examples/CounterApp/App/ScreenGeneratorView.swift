import SwiftUI
import UIKit

struct ScreenGeneratorView: View {
    private enum Role {
        case user
        case assistant
        case status
        case error
    }

    private struct Message: Identifiable {
        let id = UUID()
        let role: Role
        var text: String
    }

    let workspace: CounterScriptWorkspace.Workspace
    let onCompiled: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var generator = OpenAIScreenGenerator()
    @State private var draft = ""
    @State private var previousResponseID: String?
    @State private var streamingAssistantMessageID: UUID?
    @State private var isWorking = false
    @State private var messages: [Message] = [
        .init(role: .status, text: "Describe the screen you want to generate.")
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 14) {
                            ForEach(messages) { message in
                                messageRow(message)
                                    .id(message.id)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 20)
                    }
                    .background(Color(.systemGroupedBackground))
                    .onChange(of: messages.count) {
                        guard let lastID = messages.last?.id else {
                            return
                        }

                        withAnimation(.easeOut(duration: 0.2)) {
                            proxy.scrollTo(lastID, anchor: .bottom)
                        }
                    }
                }

                Divider()

                HStack(alignment: .bottom, spacing: 12) {
                    TextField("Build a settings screen with...", text: $draft, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(1 ... 6)
                        .disabled(isWorking)

                    Button("Send") {
                        submitPrompt()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(isWorking || draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(16)
                .background(.bar)
            }
            .navigationTitle("Generate Screen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .disabled(isWorking)
                }
            }
        }
    }

    @ViewBuilder
    private func messageRow(_ message: Message) -> some View {
        switch message.role {
        case .user:
            HStack {
                Spacer(minLength: 36)
                Text(message.text)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .foregroundStyle(.white)
            }
            .contextMenu {
                Button("Copy") {
                    UIPasteboard.general.string = message.text
                }
            }
        case .assistant:
            Text(message.text)
                .font(.system(size: 12, design: .monospaced))
                .textSelection(.enabled)
                .padding(14)
                .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                .contextMenu {
                    Button("Copy") {
                        UIPasteboard.general.string = message.text
                    }
                }
        case .status:
            Text(message.text)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
                .contextMenu {
                    Button("Copy") {
                        UIPasteboard.general.string = message.text
                    }
                }
        case .error:
            Text(message.text)
                .font(.caption)
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity, alignment: .center)
                .contextMenu {
                    Button("Copy") {
                        UIPasteboard.general.string = message.text
                    }
                }
        }
    }

    private func submitPrompt() {
        let prompt = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !prompt.isEmpty, !isWorking else {
            return
        }

        draft = ""
        messages.append(.init(role: .user, text: prompt))
        isWorking = true

        Task {
            await generateAndCompile(from: prompt)
        }
    }

    private func generateAndCompile(from initialPrompt: String) async {
        do {
            let typesSource = try CounterScriptWorkspace.loadTypesSource(in: workspace)
            let existingContentViewSource = try CounterScriptWorkspace.loadSource(at: workspace.editableSourceURL)
            var prompt = initialPrompt
            var consecutiveCompileFailures = 0

            while true {
                await MainActor.run {
                    streamingAssistantMessageID = nil
                    appendStatus("Thinking…")
                }

                let result = try await generator.generateContentView(
                    for: prompt,
                    previousResponseID: previousResponseID,
                    typesSource: typesSource,
                    existingContentViewSource: existingContentViewSource,
                    onUpdate: { update in
                        await MainActor.run {
                            handle(update)
                        }
                    }
                )

                await MainActor.run {
                    previousResponseID = result.responseID
                    ensureAssistantMessageContains(result.code)
                    appendStatus("Compiling…")
                }

                do {
                    try CounterScriptWorkspace.saveSource(result.code, at: workspace.editableSourceURL)
                    try await CounterScriptWorkspace.transpileProject(in: workspace)
                    consecutiveCompileFailures = 0

                    await MainActor.run {
                        isWorking = false
                        onCompiled()
                        dismiss()
                    }
                    return
                } catch {
                    consecutiveCompileFailures += 1
                    let errorPrompt = "Transpiling failed with \(error.localizedDescription). Please fix and provide full code including the fix without any text or markdown backticks"

                    await MainActor.run {
                        messages.append(.init(role: .error, text: "Transpiling failed with \(error.localizedDescription)"))
                    }

                    if consecutiveCompileFailures >= 3 {
                        await MainActor.run {
                            messages.append(.init(role: .error, text: "Stopped after 3 failed compile attempts. Adjust the prompt and try again."))
                            isWorking = false
                        }
                        return
                    }

                    prompt = errorPrompt
                }
            }
        } catch {
            await MainActor.run {
                messages.append(.init(role: .error, text: error.localizedDescription))
                isWorking = false
            }
        }
    }

    private func handle(_ update: OpenAIScreenGenerator.StreamUpdate) {
        switch update {
        case let .status(text):
            appendStatus(text)
        case let .assistantDelta(delta):
            appendAssistantDelta(delta)
        }
    }

    private func appendStatus(_ text: String) {
        guard messages.last?.role != .status || messages.last?.text != text else {
            return
        }

        messages.append(.init(role: .status, text: text))
    }

    private func appendAssistantDelta(_ delta: String) {
        if let streamingAssistantMessageID,
           let index = messages.firstIndex(where: { $0.id == streamingAssistantMessageID }) {
            messages[index].text += delta
            return
        }

        let message = Message(role: .assistant, text: delta)
        streamingAssistantMessageID = message.id
        messages.append(message)
    }

    private func ensureAssistantMessageContains(_ code: String) {
        if let streamingAssistantMessageID,
           let index = messages.firstIndex(where: { $0.id == streamingAssistantMessageID }) {
            messages[index].text = code
            return
        }

        let message = Message(role: .assistant, text: code)
        streamingAssistantMessageID = message.id
        messages.append(message)
    }
}
