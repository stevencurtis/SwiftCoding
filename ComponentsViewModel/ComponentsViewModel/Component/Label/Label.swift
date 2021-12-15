//
//  Label.swift
//  ComponentsViewModel
//
//  Created by Steven Curtis on 17/02/2021.
//

import UIKit

final class Label: UILabel {
    public override var intrinsicContentSize: CGSize {
        guard let text = text, !text.isEmpty else { return .zero }
        let size = super.intrinsicContentSize
        return .init(
            width: size.width,
            height: size.height
        )
    }
    
    override public var text: String? {
        get { super.text }
        set { super.text = newValue }
    }
    
    public func update(with model: Label.Model) {
        text = model.text
    }
    
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(handleLinkTapOnLabel))
    
    public var linkHandler: ((Int, NSRange) -> Void)? {
        didSet {
            if linkHandler != nil {
                isUserInteractionEnabled = true
                addGestureRecognizer(tap)
            } else {
                isUserInteractionEnabled = false
                removeGestureRecognizer(tap)
            }
        }
    }
}

private extension Label {
    @objc func handleLinkTapOnLabel(tapGesture: UITapGestureRecognizer) {
        guard let linkHandler = linkHandler,
            let attributedText = attributedText,
            let font = font else {
            return
        }

        // Configure NSTextContainer
        let textContainer = NSTextContainer(size: CGSize.zero)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = lineBreakMode
        textContainer.maximumNumberOfLines = numberOfLines
        let labelSize = bounds.size
        textContainer.size = labelSize
        
        // Configure NSLayoutManager and add the text container
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)

        // Configure NSTextStorage and apply the layout manager
        let textStorage = NSTextStorage(attributedString: attributedText)
        textStorage.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attributedText.length))
        textStorage.addLayoutManager(layoutManager)

        // get the tapped character location
        let locationOfTouchInLabel = tapGesture.location(in: self)

        let locationOfTouchInTextContainer = CGPoint(
            x: locationOfTouchInLabel.x,
            y: locationOfTouchInLabel.y
        )
        
        let characterIndex = layoutManager.characterIndex(
            for: locationOfTouchInTextContainer,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil
        )

        attributedText.enumerateAttribute(
            .link,
            in: NSRange(location: 0, length: attributedText.length),
            options: NSAttributedString.EnumerationOptions(rawValue: UInt(0)),
            using: { (attrs: Any?, range: NSRange, _) in
                if NSLocationInRange(characterIndex, range) {
                    linkHandler(characterIndex, range)
                }
            }
        )
    }
}
