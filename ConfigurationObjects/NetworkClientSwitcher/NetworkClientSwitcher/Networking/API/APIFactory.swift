import Foundation
import NetworkClient

struct APIFactory {
    static func makeDefault(
        with configuration:
        NetworkClientConfiguration = NetworkClientSelector.select()
    ) -> NetworkClient {
        configuration.networkClient
    }
}
