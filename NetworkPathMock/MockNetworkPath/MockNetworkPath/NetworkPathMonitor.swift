//
//  NetworkPathMonitor.swift
//  MockNetworkPath
//
//  Created by Steven Curtis on 09/04/2023.
//

import Combine

final class NetworkPathMonitor: ObservableObject {
    @Published var isConnected = true
    
    private var pathUpdateCancellable: AnyCancellable?
    let paths: PathCreationProtocol
    init(
        paths: PathCreationProtocol = PathCreation()
    ) {
        self.paths = paths
        paths.start()
        self.pathUpdateCancellable = paths.networkPathPublisher?
            .sink(receiveValue: { [weak self] isConnected in
                self?.isConnected = isConnected == NetworkPath(status: .satisfied)
            })
    }
}
