import Foundation

struct NetworkClientSelector {
    static func select() -> NetworkClientConfiguration {
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("-UITests") {
            return DebugNetworkClientConfiguration()
        }
        #endif
        return ReleaseNetworkClientConfiguration()
    }
}
