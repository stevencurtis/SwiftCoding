//
//  SearchResultsViewModel.swift
//  PostcodeLookup
//
//  Created by Steven Curtis on 23/04/2021.
//

import Combine
import Foundation
import NetworkLibrary

final class SearchResultsViewModel {
    private var anyNetworkManager: AnyNetworkManager<URLSession>
    var autocompleteResults = CurrentValueSubject<[String], Never>([])
    private var cancellable = Set<AnyCancellable>()
    @Published var keyWordSearch: String = ""
    
    init() {
        self.anyNetworkManager = AnyNetworkManager()
        bind()
    }

    init<T: NetworkManagerProtocol> (
        networkManager: T
    ) {
        self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
        bind()
    }
    
    private func bind() {
        $keyWordSearch.receive(on: RunLoop.main).debounce(for: .seconds(0.2), scheduler: RunLoop.main)
            .sink { keyword in
                guard !keyword.isEmpty else {
                    return
                }
                self.search(with: keyword)
            }.store(in: &cancellable)
    }
    
    func search(with text: String) {
        guard let url = URL(string: "https://api.postcodes.io/postcodes/\(text)/autocomplete") else {return}
        anyNetworkManager.fetch(url: url, method: .get(), completionBlock: { [weak self] result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                let decoded = try? decoder.decode(Autocomplete.self, from: data)
                self?.autocompleteResults.send(decoded?.result ?? [])
            case .failure:
                break
            }
        }
        )
    }
}

