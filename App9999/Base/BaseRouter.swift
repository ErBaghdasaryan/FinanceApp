//
//  BaseRouter.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import UIKit
import Combine
import App9999ViewModel

class BaseRouter {

    class func popViewController(in navigationController: UINavigationController, completion: (() -> Void)? = nil) {
        completion?()
        navigationController.popViewController(animated: true)
    }
}
