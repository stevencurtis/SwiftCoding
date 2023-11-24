import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import PublicStructInitMacroMacros

let testMacros: [String: Macro.Type] = [
    "PublicInit": PublicInitMacro.self,
]

final class struct_initial_macroTests: XCTestCase {
    func testMacro() {
        assertMacroExpansion(
            """
            @PublicInit
            struct SeedDigit {
                public let digit: Int
                public let value: Int
            }

            """,
            expandedSource:
            """

            struct SeedDigit {
                public let digit: Int
                public let value: Int

                public init(digit: Int, value: Int) {
                    self.digit = digit
                    self.value = value
                }
            }
            """,
            macros: testMacros
        )
    }
}
