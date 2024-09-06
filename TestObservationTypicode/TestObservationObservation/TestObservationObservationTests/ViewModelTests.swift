@testable import TestObservationObservation
import XCTest

final class ViewModelTests: XCTestCase {
    func testGetPostsSuccess() async {
        let expectation = XCTestExpectation(description: "Posts updated")

        let mockPost = [PostDTO(title: "test")]
        let mockPostService = MockPostService()
        mockPostService.posts = .posts(mockPost)
        let viewModel = ViewModel(service: mockPostService)
        
        withObservationTracking {
            _ = viewModel.posts
        } onChange: {
            expectation.fulfill()
        }

        await viewModel.getPosts()
        await fulfillment(of: [expectation], timeout: 0.1)
        XCTAssertEqual(viewModel.posts, mockPost.map { $0.toDomain() } )
    }
    
    func testGetPostsError() async {
        let expectation = XCTestExpectation(description: "Posts updated")

        let mockError = PostError.invalidURL
        let mockPostService = MockPostService()
        mockPostService.posts = .error(mockError)
        let viewModel = ViewModel(service: mockPostService)
        
        withObservationTracking {
            _ = viewModel.error
        } onChange: {
            expectation.fulfill()
        }
        
        await viewModel.getPosts()
        await fulfillment(of: [expectation], timeout: 0.1)

        XCTAssertEqual(viewModel.error, mockError)
    }
}
