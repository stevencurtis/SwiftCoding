import Foundation

// A TextEditor that does too much
//struct TextEditor {
//    private(set) var text: String
//    private var history: [String]
//
//    init(text: String) {
//        self.text = text
//        self.history = []
//    }
//
//    mutating func append(_ newText: String) {
//        history.append(text)
//        text += newText
//    }
//
//    mutating func undo() {
//        if let previousHistory = history.popLast() {
//            text = previousHistory
//        }
//    }
//}

// You cannot have a stored property that recursively contains it
//struct History {
//    let state: String
//    let previous: History?
//
//    init(state: String, previous: History? = nil) {
//        self.state = state
//        self.previous = previous
//    }
//}

//**Manage the state separately**
//struct History {
//    let state: String
//    private (set) var previous: [String]
//
//    init(state: String, previous: [String] = []) {
//        self.state = state
//        self.previous = previous
//    }
//    
//    mutating func undoLastChange() -> String {
//        previous.removeFirst()
//    }
//}
//
//struct TextEditor {
//    private(set) var text: String
//    private var history: History
//
//    init(text: String) {
//        self.text = text
//        self.history = History(state: text)
//    }
//
//    mutating func append(_ newText: String) {
//        text += newText
//        history = History(state: text, previous: [history.state] + history.previous)
//    }
//
//    mutating func undo() {
//        let previousText = history.undoLastChange()
//        text = previousText
//    }
//}

final class History {
    let state: String
    let previous: History?

    init(state: String, previous: History? = nil) {
        self.state = state
        self.previous = previous
    }
}

struct TextEditor {
    var text: String
    var history: History

    init(text: String) {
        self.text = text
        self.history = History(state: text)
    }

    mutating func append(_ newText: String) {
        text += newText
        history = History(state: text, previous: history)
    }

    mutating func undo() {
        if let previousHistory = history.previous {
            text = previousHistory.state
            history = previousHistory
        }
    }
}
var editor = TextEditor(text: "Hello")

editor.append(", world!")
print(editor.text)
editor.append(" typo")
print(editor.text)
editor.undo()
print(editor.text)
