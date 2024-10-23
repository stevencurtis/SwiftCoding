import UIKit

final class ViewController: UIViewController {
    
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchToDos()
    }

    override func loadView() {
        super.loadView()
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }

}

import NetworkClient

final class ViewModel {
    let networkClient: NetworkClient
    init(networkClient: NetworkClient = MainNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchToDos() {
        Task {
            let request = BasicRequest<[TodoDTO]>()
            let todos = try? await networkClient.fetch(api: API.todo, request: request)
            print(todos)
        }
    }
}

// https://jsonplaceholder.typicode.com/todos

import NetworkClient

enum API: URLGenerator {
    case todo
    var method: HTTPMethod { .get }
    var url: URL? { URL(string: "https://jsonplaceholder.typicode.com/todos") }
}

struct TodoDTO: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
