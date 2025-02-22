//
//  ReusableView.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import UIKit

protocol IReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

extension IReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
