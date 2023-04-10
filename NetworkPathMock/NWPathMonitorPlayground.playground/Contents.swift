import Network

let pathMonitor = NWPathMonitor()

pathMonitor.pathUpdateHandler = { path in
    if path.status == .satisfied {
        print("Connected")
    } else {
        print("Not connected")
    }
}
pathMonitor.start(queue: .main)

protocol NetworkPathMonitorProtocol {
    func start(queue: DispatchQueue)
    var currentPath: NWPath { get }
    var pathUpdateHandler: ((_ newPath: NWPath) -> Void)? { get }
}

extension NWPathMonitor: NetworkPathMonitorProtocol {}

 // NWPath() // 'NWPath' cannot be constructed because it has no accessible initializers`
