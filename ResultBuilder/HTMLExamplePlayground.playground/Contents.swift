import UIKit

protocol HTMLElement {
    var render: String { get }
}

struct Div: HTMLElement {
    let content: String
    var render: String {
        "<div>\(content)</div>"
    }
}

struct P: HTMLElement {
    let content: String
    var render: String {
        "<p>\(content)</p>"
    }
}

struct A: HTMLElement {
    let href: String
    let content: String
    var render: String {
        "<a href=\"\(href)\">\(content)</a>"
    }
}

// String concatenation

let div = Div(content: "This is enclosed in div tags.")
let p = P(content: "This is enclosed in paragraph tags.")
let a = A(href: "https://www.example.com", content: "This is a link")

let htmlContentConcat = div.render + p.render + a.render
print(htmlContentConcat)

// Using functions and static methods
struct HTMLBasicBuilder {
    static func buildBlock(_ elements: HTMLElement...) -> String {
        return elements.map { $0.render }.joined()
    }
}

let htmlBuilder = HTMLBasicBuilder.buildBlock(
        Div(content: "This is enclosed in div tags."),
        P(content: "This is enclosed in paragraph tags."),
        A(href: "https://www.example.com", content: "This is a link")
)


@resultBuilder
struct HTMLBuilder {
    static func buildBlock(_ elements: HTMLElement...) -> String {
        return elements.map { $0.render }.joined()
    }
}

// Accessing directly violates separation of concerns
//let htmlContent = HTMLBuilder.buildBlock(
//    Div(content: "This is enclosed in div tags."),
//    P(content: "This is enclosed in paragraph tags."),
//    A(href: "https://www.example.com", content: "This is a link")
//)

func createHTML(@HTMLBuilder _ content: () -> String) -> String {
    return content()
}

let htmlContent = createHTML {
    Div(content: "This is enclosed in div tags.")
    P(content: "This is enclosed in paragraph tags.")
    A(href: "https://www.example.com", content: "This is a link")
}

print(htmlContent)
