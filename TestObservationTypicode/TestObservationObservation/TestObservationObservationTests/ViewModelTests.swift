@testable import TestObservationObservation
import XCTest

final class ViewModelTests: XCTestCase {
    func testGetPostsSuccess() async {
        let mockPosts = [PostDTO(title: "test")]
        let mockPostService = MockPostService()
        mockPostService.posts = mockPosts
        let viewModel = ViewModel(service: mockPostService)
        await viewModel.getPosts()

        XCTAssertEqual(viewModel.posts, mockPosts.map { $0.toDomain() } )
    }
    
    func testGetPostsError() async {
        
    }
}


final class MockPostService: PostServiceProtocol {
    var posts: [PostDTO] = []
    func getPosts() async throws -> [PostDTO] {
        return posts
    }
}

extension Post: Equatable {
    static public func == (lhs: Post, rhs: Post) -> Bool {
        lhs.title == rhs.title
    }
}

