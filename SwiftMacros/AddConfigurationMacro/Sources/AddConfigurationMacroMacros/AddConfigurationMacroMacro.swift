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
        
        guard let classDecl = declaration.as(ClassDeclSyntax.self) else {
            throw StructInitError.applicableToStruct
        }
        
        let members = classDecl.memberBlock.members
        let variableDecl = members.compactMap { $0.decl.as(VariableDeclSyntax.self) }
        let variablesName = variableDecl.compactMap { $0.bindings.first?.pattern }
        let variablesType = variableDecl.compactMap { $0.bindings.first?.typeAnnotation?.type }
        let initializer = try InitializerDeclSyntax(
            Self.generateInitizerCode(
                variablesName: variablesName,
                variablesType: variablesType
            )) {
            for name in variablesName {
                ExprSyntax("self.\(name) = \(name)")
            }
        }
        let printFunc = try StructDeclSyntax("public struct Configuration"){
            for name in variablesName.enumerated() {
                "let \(variablesName[name.offset]) : \(variablesType[name.offset])\n"
                        }
            "let navigationController: UINavigationController"
            initializer
        }
        return [DeclSyntax(printFunc)]
    }
    
    public static func generateInitizerCode(
        variablesName: [PatternSyntax],
        variablesType: [TypeSyntax]
    ) -> SyntaxNodeString {
        var initialCode: String = "public init(\n"
        for (name, type) in zip(variablesName, variablesType) {
            initialCode += "\(name): \(type), \n"
        }
        initialCode = String(initialCode.dropLast(2))
        initialCode += "navigationController: UINavigationController"
        initialCode += ")"
        return SyntaxNodeString(stringLiteral: initialCode)
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
