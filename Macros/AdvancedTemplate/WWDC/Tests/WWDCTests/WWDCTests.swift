import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import WWDCMacros

let testMacros: [String: Macro.Type] = [
    "SlopeSubset" : SlopeSubsetMacro.self,
]

final class WWDCTests: XCTestCase {
    func testSlopeSubset() {
        assertMacroExpansion(
            """
            @SlopeSubset<Slope>
            enum EasySlope {
                case beginnersParadise
                case practiceRun
            }
            """,
            expandedSource: """

            enum EasySlope {
                case beginnersParadise
                case practiceRun
                init?(_ slope: Slope) {
                    switch slope {
                    case .beginnersParadise:
                        self = .beginnersParadise
                    case .practiceRun:
                        self = .practiceRun
                    default:
                        return nil
                    }
                }
            }
            """,
            macros: testMacros
        )
    }
    
    func testSlopeSubsetOnStruct() throws {
        assertMacroExpansion(
            """
            @SlopeSubset<Slope>
            struct Skier {
            }
            """,
            expandedSource: """

            struct Skier {
            }
            """,
            diagnostics: [
                DiagnosticSpec(message: "@SlopeSubset can only be applied to an enum", line: 1, column: 1)
            ],
            macros: testMacros
        )
    }
}
