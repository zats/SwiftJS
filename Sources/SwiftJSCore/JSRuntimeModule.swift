public protocol JSRuntimeModule {
    var name: String { get }

    @MainActor
    func invoke(
        method: String,
        payloadJSON: String?,
        completion: @escaping (Result<String?, Error>) -> Void
    )
}
