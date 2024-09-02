import Foundation

protocol PostServiceProtocol {
    func getPosts() async throws -> [PostDTO]
}

final class PostService: PostServiceProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func getPosts() async throws -> [PostDTO] {
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: urlString) else { throw PostError.invalidURL }
        do {
            let (data, _) = try await urlSession.data(from: url)
            let decoder = JSONDecoder()
            let posts = try decoder.decode([PostDTO].self, from: data)
            return posts
        } catch {
            if let _ = error as? DecodingError {
                throw PostError.decodingError
            } else if let _ = error as? URLError {
                throw PostError.urlError
            } else {
                throw PostError.genericError
            }
        }
    }
}
