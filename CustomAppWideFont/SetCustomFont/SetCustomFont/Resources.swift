//
//  Resources.swift
//  SetCustomFont
//
//  Created by Steven Curtis on 21/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

struct Resources {
    
    struct Fonts {}
}

extension Resources.Fonts {
    enum Weight: String {
        case light = "Telugu Sangam MN"
        case regular = "MonotypeSabonW04-Italic"
        case semibold = "Typo-Semibold"
        case italic = "Zapfino"
    }
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    
    @objc class func mySystemFont(ofSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        switch weight {
        case .semibold, .bold, .heavy, .black:
            return UIFont(name: Resources.Fonts.Weight.semibold.rawValue, size: ofSize)!
            
        case .medium, .regular:
            return UIFont(name: Resources.Fonts.Weight.regular.rawValue, size: ofSize)!
            
        default:
            return UIFont(name: Resources.Fonts.Weight.light.rawValue, size: ofSize)!
        }
    }
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.light.rawValue, size: size)!
    }
    
    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.semibold.rawValue, size: size)!
    }
    
    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.italic.rawValue, size: size)!
    }
    
    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage", "CTFontMediumUsage":
            fontName = Resources.Fonts.Weight.regular.rawValue
        case "CTFontEmphasizedUsage", "CTFontBoldUsage", "CTFontSemiboldUsage","CTFontHeavyUsage", "CTFontBlackUsage":
            fontName = Resources.Fonts.Weight.semibold.rawValue
        case "CTFontObliqueUsage":
            fontName = Resources.Fonts.Weight.italic.rawValue
        default:
            fontName = Resources.Fonts.Weight.light.rawValue
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }
    
    class func overrideDefaultTypography() {
        guard self == UIFont.self else { return }
        
        if let systemFontMethodWithWeight = class_getClassMethod(self, #selector(systemFont(ofSize: weight:))),
            let mySystemFontMethodWithWeight = class_getClassMethod(self, #selector(mySystemFont(ofSize: weight:))) {
            method_exchangeImplementations(systemFontMethodWithWeight, mySystemFontMethodWithWeight)
        }
        
        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }
        
        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }
        
        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }
        
        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))),
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
