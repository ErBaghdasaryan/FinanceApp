//
//  UITabBar.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import UIKit

extension UITabBar {
    private struct AssociatedKeys {
        static var customHeight: CGFloat = 90.0
    }

    var customHeight: CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.customHeight) as? CGFloat ?? 90.0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.customHeight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            invalidateIntrinsicContentSize()
            layoutIfNeeded()
        }
    }

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = customHeight
        return sizeThatFits
    }
}
