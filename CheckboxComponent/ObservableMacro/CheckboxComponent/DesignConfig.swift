import UIKit

final public class DesignConfig {
    struct StateConfig {
        var title: String
        var backgroundColor: UIColor
        var titleColor: UIColor
    }
    
    static let shared = DesignConfig()
        
    var secondaryColor: UIColor = .systemRed
    var cornerRadius: CGFloat = 15
    var backgroundColour: UIColor = .systemBackground

    
    var loadingConfig = StateConfig(
        title: "Loading",
        backgroundColor: .systemGray,
        titleColor: .blue
    )
    
    var enabledConfig = StateConfig(
        title: "Enabled",
        backgroundColor: .systemBlue,
        titleColor: .systemBackground
    )

    var selectedConfig = StateConfig(
        title: "Selected",
        backgroundColor: .systemRed,
        titleColor: .blue
    )

    var disabledConfig = StateConfig(
        title: "Disabled",
        backgroundColor: .systemGray,
        titleColor: .systemGray2
    )

    private init() {}
}
