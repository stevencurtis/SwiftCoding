import Foundation

final class ViewModel: ObservableObject {
    @Published var error: PostError?
    @Published private(set) var posts: [Post] = []
    private let service: PostServiceProtocol
    init(service: PostServiceProtocol) {
        self.service = service
    }
    
    @MainActor
    func getPosts() {
        Task {
            do {
                let posts = try await service.getPosts().map { $0.toDomain() }
                self.posts = posts
            } catch {
                self.error = error as? PostError
            }
        }
    }
}
