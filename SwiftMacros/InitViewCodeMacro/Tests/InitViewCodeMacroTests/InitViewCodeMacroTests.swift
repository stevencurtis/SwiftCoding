import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(InitViewCodeMacroMacros)
import InitViewCodeMacroMacros

let testMacros: [String: Macro.Type] = [
    "AddConfiguration": AddConfigurationMacro.self,
]
#endif

final class InitViewCodeMacroTests: XCTestCase {
    func testMacro() throws {
        #if canImport(InitViewCodeMacroMacros)
        assertMacroExpansion(
            """
            @AddConfiguration
            struct OverdraftReferralScreen: View {
            
            var body: some View {
                EmptyView()
            }
            }
            """,
            expandedSource: """
            struct OverdraftReferralScreen: View {

            var body: some View {
                EmptyView()
            }

                @ObservedObject private var viewModel: OverdraftReferralViewModel

                public init(
                    viewModel: OverdraftReferralViewModel
                ) {
                    self.viewModel = viewModel
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
