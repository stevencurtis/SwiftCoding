import Combine
import Foundation
import Observation

@Observable
final class ContentViewModel {
    var people: [Person] = []
    var isLoading = true
    private let loadMoreSubject = PassthroughSubject<Void, Never>()
    private let service: PeopleServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1

    init(service: PeopleServiceProtocol = PeopleService()) {
        self.service = service
        setupDebounce()
    }
    
    @MainActor
    func fetchPeople() {
        Task { @MainActor in
            try await loadPeople()
        }
    }
  
    func loadMoreContentIfNeeded(person: Person) {
        if let index = people.firstIndex(where: {
            $0 == person
        }) {
            let thresholdIndex = people.index(people.endIndex, offsetBy: -1)
            if index == thresholdIndex {
                loadMoreSubject.send()
            }
        }
    }
    
    private func loadMorePeople() {
        Task { @MainActor in
            currentPage += 1
            try await loadPeople()
        }
    }
    
    private func setupDebounce() {
        loadMoreSubject
            .debounce(for: .seconds(0.25), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.loadMorePeople()
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    private func loadPeople() async throws {
        Task {
            isLoading = false
            let peopleDTO = try await service.getPeople(page: "\(currentPage)")
            people += peopleDTO?.results.map { $0.toDomain() } ?? []
        }
    }
}
