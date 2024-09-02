import Combine
@testable import TestObservationOldWay
import XCTest

final class ViewModelTests: XCTestCase {
    private var cancellables: [AnyCancellable] = []

    func testGetPostsSuccess() async {
        let expectation = XCTestExpectation()
        let mockPost = [PostDTO(title: "test")]
        let mockPostService = MockPostService()
        mockPostService.posts = .posts(mockPost)
        let viewModel = ViewModel(service: mockPostService)

        viewModel.$posts
            .dropFirst()
            .sink { post in
                XCTAssertEqual(post, mockPost.map { $0.toDomain() })
                expectation.fulfill()
            }
            .store(in: &cancellables)
        await viewModel.getPosts()

        await fulfillment(of: [expectation])
    }
    
    func testGetPostsError() async {
        let expectation = XCTestExpectation()
        let mockError = PostError.invalidURL
        let mockPostService = MockPostService()
        mockPostService.posts = .error(mockError)
        let viewModel = ViewModel(service: mockPostService)

        viewModel.$error
            .dropFirst()
            .sink { error in
                XCTAssertEqual(error, mockError)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        await viewModel.getPosts()

        await fulfillment(of: [expectation])
    }
}
