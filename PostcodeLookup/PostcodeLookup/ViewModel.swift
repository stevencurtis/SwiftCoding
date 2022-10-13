//
//  ViewModel.swift
//  PostcodeLookup
//
//  Created by Steven Curtis on 22/04/2021.
//

import Foundation
import Combine

final class ViewModel {
    private(set) var postCodes = CurrentValueSubject<Result<[String], Error>, Never>(.success([]))
    private var cancellable: Set<AnyCancellable> = []

    init() { }

    func processPostCodes(selectedPostCodes: String) {
        if let existingPostCodes = try? postCodes.value.get() {
            postCodes.send(.success([selectedPostCodes] + existingPostCodes))
        } else {
            postCodes.send(.success([selectedPostCodes]))
        }
    }
}
