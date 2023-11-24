import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct AddConfigurationMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        guard let structDecl = declaration.as(StructDeclSyntax.self) else {
            throw StructInitError.applicableToStruct
        }
        
        let members = structDecl.memberBlock.members
        let variableDecl = members.compactMap { $0.decl.as(VariableDeclSyntax.self) }

        let name = structDecl.name
        let displayName = name.description.dropLast(6) + "ViewModel"
        let property = try VariableDeclSyntax("@ObservedObject private var viewModel: \(raw: displayName)")
        
        var initialCode: String = "public init(\n"
        initialCode += "viewModel: \(displayName)"
        initialCode += "\n)"
        let initializer = try InitializerDeclSyntax(
            SyntaxNodeString(stringLiteral: initialCode)
        ) {
            ExprSyntax("self.viewModel = viewModel")
        }
        
        return [DeclSyntax(property), DeclSyntax(initializer)]
    }
}

enum StructInitError: CustomStringConvertible, Error {
    case applicableToStruct
    
    var description: String {
        switch self {
        case .applicableToStruct: return "Only applicable to a struct"
        }
    }
}

@main
struct AddConfigurationMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        AddConfigurationMacro.self,
    ]
}
