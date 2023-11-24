import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(AddConfigurationMacroMacros)
import AddConfigurationMacroMacros

let testMacros: [String: Macro.Type] = [
    "AddConfiguration": AddConfigurationMacro.self,
]
#endif

final class AddConfigurationMacroTests: XCTestCase {
    func testMacro() throws {
        #if canImport(AddConfigurationMacroMacros)
        assertMacroExpansion(
            """
            @AddConfiguration
            final class MyViewModel {
                public let digit: Int
                public let value: Int
                
                init(digit: Int, value: Int) {
                    self.digit = digit
                    self.value = value
                }
            }
            """,
            expandedSource: """
            
            final class MyViewModel {
                public let digit: Int
                public let value: Int
                
                init(digit: Int, value: Int) {
                    self.digit = digit
                    self.value = value
                }

                public struct Configuration {
                    let digit : Int
                    let value : Int
                    let navigationController: UINavigationController
                    public init(
                        digit: Int,
                        value: Int, navigationController: UINavigationController) {
                        self.digit = digit
                        self.value = value
                    }
                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

}
