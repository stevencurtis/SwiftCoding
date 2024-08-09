import Foundation

enum History {
    case initial(String)
    indirect case change(String, previous: History)
}

struct TextEditor {
    var text: String
    var history: History

    init(text: String) {
        self.text = text
        self.history = .initial(text)
    }

    mutating func append(_ newText: String) {
        text += newText
        history = .change(text, previous: history)
    }

    mutating func undo() {
        switch history {
        case .initial(let initialText):
            text = initialText
        case .change(_, let previousHistory):
            switch previousHistory {
            case .initial(let previousText):
                text = previousText
            case let .change(previousText, _):
                text = previousText
            }
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
