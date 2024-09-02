import Observation

@Observable
final class ViewModel {
    var error: PostError?
    private(set) var posts: [Post] = []
    private let service: PostServiceProtocol
    init(service: PostServiceProtocol = PostService()) {
        self.service = service
    }
    
    @MainActor
    func getPosts() {
        Task {
            do {
                let posts = try await service.getPosts().map {
                    $0.toDomain()
                }
                self.posts = posts
            } catch {
                self.error = error as? PostError
            }
        }
    }
}
