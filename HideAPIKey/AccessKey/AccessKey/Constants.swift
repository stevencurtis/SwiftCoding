import Foundation

enum Constants {
    static let apiKey: String = {
        guard let key = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("API_KEY not set.")
        }
        return key
    }()
}
