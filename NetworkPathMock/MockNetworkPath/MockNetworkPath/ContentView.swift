//
//  ContentView.swift
//  MockNetworkPath
//
//  Created by Steven Curtis on 09/04/2023.
//

import Combine
import SwiftUI

struct ContentView: View {
    @ObservedObject var networkPathMonitor: NetworkPathMonitor
    var body: some View {
        VStack {
            if !networkPathMonitor.isConnected {
                ErrorView()
            }
            VStack {
                
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
            if !networkPathMonitor.isConnected {
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(
                networkPathMonitor: NetworkPathMonitor(
                    paths: MockPathCreation(status: .init(status: .requiresConnection))
                )
            )
            
            ContentView(
                networkPathMonitor: NetworkPathMonitor(
                    paths: MockPathCreation(status: .init(status: .satisfied))
                )
            )
            
            ContentView(
                networkPathMonitor: NetworkPathMonitor(
                    paths: MockPathCreation(status: .init(status: .unsatisfied))
                )
            )
        }
    }
}

#if DEBUG
final class MockPathCreation: PathCreationProtocol {
    var status: NetworkPath
    var networkPathPublisher: AnyPublisher<NetworkPath, Never>?
    func start() {
        networkPathPublisher = .init(Just(status))
    }
    
    init(status: NetworkPath = NetworkPath(status: .requiresConnection)) {
        self.status = status
    }
}
#endif
