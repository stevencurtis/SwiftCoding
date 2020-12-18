import UIKit

protocol TestProtocol {
    func testFunction(a:Int, b:Int?) -> String
}

extension TestProtocol
{
    func testFunction(a:Int, b:Int? = nil) -> String {
        return testFunction(a:a, b:b)
    }
}

class TestClass: TestProtocol
{
    func testFunction(a:Int, b:Int?) -> String {
        return "a:\(a), b:\(b)"
    }
}

func testit(testProtocol: TestProtocol) {
    print(testProtocol.testFunction(a:10)) // will print a:10, b:nil
    print(testProtocol.testFunction(a:10, b:20)) // will print a:10, b:Optional(20)
}

let t = TestClass()
testit(testProtocol: t)
