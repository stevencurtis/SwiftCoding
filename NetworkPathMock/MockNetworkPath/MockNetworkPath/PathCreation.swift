//
//  PathCreationProtocol.swift
//  MockNetworkPath
//
//  Created by Steven Curtis on 09/04/2023.
//

import Combine
import Network

protocol PathCreationProtocol {
    var networkPathPublisher: AnyPublisher<NetworkPath, Never>? { get }
    func start()
}

final class PathCreation: PathCreationProtocol {
    public var networkPathPublisher: AnyPublisher<NetworkPath, Never>?
    private let subject = PassthroughSubject<NWPath, Never>()
    private let monitor = NWPathMonitor()
    
    func start() {
        monitor.pathUpdateHandler = subject.send
        networkPathPublisher = subject
            .handleEvents(
                receiveSubscription: { _ in self.monitor.start(queue: .main) },
                receiveCancel: monitor.cancel
            )
            .map(NetworkPath.init(rawValue:))
            .eraseToAnyPublisher()
    }
}
