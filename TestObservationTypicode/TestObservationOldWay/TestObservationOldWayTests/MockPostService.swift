import Foundation
@testable import TestObservationOldWay

final class MockPostService: PostServiceProtocol {
    enum PostsResponse {
        case posts([PostDTO])
        case error(PostError)
    }
    var posts: PostsResponse = .posts([])
    func getPosts() async throws -> [PostDTO] {
        switch posts {
        case .error(let error):
            throw error
        case .posts(let posts):
            return posts
        }
    }
}
