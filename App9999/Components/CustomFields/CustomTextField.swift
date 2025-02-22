//
//  CustomTextField.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import UIKit

public class CustomTextField: UITextField {

    private let rightLabel = UILabel(text: "Unknown",
                                     textColor: UIColor(hex: "#989898")!,
                                     font: UIFont(name: "Nunito-Regular", size: 17))

    public convenience init(placeholder: String, rightText: String? = nil) {
        self.init()
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecureTextEntry
        self.layer.cornerRadius = 16
        self.backgroundColor = .clear
        self.textColor = .white
        self.font = UIFont(name: "Nunito-Regular", size: 17)
        self.rightViewMode = .always
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor

        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

        self.autocorrectionType = .no
        self.autocapitalizationType = .none

        rightLabel.text = rightText
        rightLabel.sizeToFit()
        self.rightView = rightLabel

        self.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }

    override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        
        if rect.origin.x.isNaN || rect.origin.x.isInfinite {
            rect.origin.x = bounds.width - rect.width
        } else {
            rect.origin.x -= 16
        }
    
        return rect
    }

    @objc private func textDidChange() {
        rightView?.isHidden = !(text?.isEmpty ?? true)
    }
}
