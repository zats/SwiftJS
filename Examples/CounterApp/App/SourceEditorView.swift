import SwiftUI

struct SourceEditorView: View {
    @Binding var text: String
    let bundledText: String
    let isBusy: Bool
    let onCancel: () -> Void
    let onSave: () -> Void
    let onReset: () -> Void

    var body: some View {
        NavigationStack {
            TextEditor(text: $text)
                .font(.system(size: 10, design: .monospaced))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(12)
                .navigationTitle("ContentView.tsx")
                .navigationBarTitleDisplayMode(.inline)
                .overlay {
                    if isBusy {
                        ZStack {
                            Color.black.opacity(0.18)
                                .ignoresSafeArea()

                            ProgressView("Transpiling…")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", action: onCancel)
                            .disabled(isBusy)
                    }

                    if text != bundledText {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Reset", action: onReset)
                                .disabled(isBusy)
                        }
                    }

                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save", action: onSave)
                            .disabled(isBusy)
                    }
                }
        }
    }
}
