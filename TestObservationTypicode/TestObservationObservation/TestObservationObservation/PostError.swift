import Foundation

enum PostError: Error {
    case decodingError
    case genericError
    case invalidURL
    case urlError
}
