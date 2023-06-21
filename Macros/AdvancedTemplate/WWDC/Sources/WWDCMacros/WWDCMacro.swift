import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

enum SlopeSubsetError: CustomStringConvertible, Error {
    case onlyApplicableToEnum
    
    var description: String {
        switch self {
        case .onlyApplicableToEnum: return "@SlopeSubset can only be applied to an enum"
        }
    }
}

/// Implementation of the `SlopeSubset` macro.
public struct SlopeSubsetMacro: MemberMacro {
    public static func expansion(
        of attribute: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let enumDecl = declaration.as(EnumDeclSyntax.self) else {
            throw SlopeSubsetError.onlyApplicableToEnum
        }
        let members = enumDecl.memberBlock.members
        let caseDecls = members.compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
        let elements = caseDecls.flatMap { $0.elements }
        guard let supersetType = attribute
            .attributeName.as(SimpleTypeIdentifierSyntax.self)?
            .genericArgumentClause?
            .arguments.first?
            .argumentType else {
            // TODO: Handle error
            return []
        }
        
        let initializer = try InitializerDeclSyntax("init?(_ slope: \(supersetType))") {
            
            try SwitchExprSyntax("switch slope") {
                for element in elements {
                    SwitchCaseSyntax(
                        """
                        case .\(element.identifier):
                            self = .\(element.identifier)
                        """
                    )
                }
                SwitchCaseSyntax("default: return nil")
            }
        }
        return [DeclSyntax(initializer)]
    }
}

@main
struct WWDCPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        SlopeSubsetMacro.self
    ]
}
