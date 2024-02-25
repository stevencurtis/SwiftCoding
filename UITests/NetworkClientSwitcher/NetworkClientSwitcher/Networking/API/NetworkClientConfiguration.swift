import Foundation
import NetworkClient

protocol NetworkClientConfiguration {
    var networkClient: NetworkClient { get }
}

struct DebugNetworkClientConfiguration: NetworkClientConfiguration {
    var networkClient: NetworkClient {
        MockNetworkClient()
    }
}

struct ReleaseNetworkClientConfiguration: NetworkClientConfiguration {
    var networkClient: NetworkClient {
        MainNetworkClient()
    }
}
