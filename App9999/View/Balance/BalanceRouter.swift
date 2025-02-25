//
//  BalanceRouter.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import UIKit
import App9999ViewModel

final class BalanceRouter: BaseRouter {
    static func showTabBarController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeTabBarViewController()
        navigationController.setViewControllers([viewController], animated: true)
    }
}
