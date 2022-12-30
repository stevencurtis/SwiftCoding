import UIKit

class URLBuilder {
    var component: URLComponents!
    
    init() {
        var endpoint = URLComponents()
        endpoint.scheme = "https"
        endpoint.host = "reqres.in"
        component = endpoint
    }
    
    func set(path: String) -> URLBuilder {
        component.path = path
        return self
    }
    
    func addPageQuery(page: Int) -> URLBuilder {
        component.queryItems = [URLQueryItem(name: "page", value: page.description)]
        return self
    }
    
    func build() -> URL? {
        return self.component.url
    }
}


let url = URLBuilder()
    .set(path: "/api/users")
    .addPageQuery(page: 2)
    .build()





protocol ContentBuilderProtocol{
    func build() -> String
    func set(title: String) -> ContentBuilderProtocol
    func set(body: String) -> ContentBuilderProtocol
}

class PlainPageBuilder: ContentBuilderProtocol {
    var page: String!
    
    init() {
        page = String()
    }
    
    func set(title: String) -> ContentBuilderProtocol {
        page += title
        return self
    }
    
    func set(body: String) -> ContentBuilderProtocol {
        page += body
        return self
    }
    
    func build() -> String {
        return page
    }
}

class PageBuilder: ContentBuilderProtocol {
    var page: String!
    init() {
        page = String()
    }
    func set(title: String) -> ContentBuilderProtocol {
        page += "#\(title)"
        return self
    }
    
    func set(body: String) -> ContentBuilderProtocol {
        page += body
        return self
    }
    
    func build() -> String {
        return page
    }
}

// without a director
let page = PageBuilder()
    .set(title: "MyTitle")
    .set(body: "This is a great article!")
    .build()

class PageDirector {
    let builder: ContentBuilderProtocol!
    init(builder: ContentBuilderProtocol) {
        self.builder = builder
    }
    
    func build() -> String {
        self.builder.set(title: "Hello")
        self.builder.set(body: "Text Body")
        return self.builder.build()
    }
}
let builder = PageBuilder()
let director = PageDirector(builder: builder)
director.build()

let plainBuilder = PlainPageBuilder()
let plainDirector = PageDirector(builder: plainBuilder)
plainDirector.build()

