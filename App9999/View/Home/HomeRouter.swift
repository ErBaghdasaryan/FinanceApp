//
//  HomeRouter.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import UIKit
import App9999ViewModel

final class HomeRouter: BaseRouter {
    static func showBalanceController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeBalanceViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showCollectController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeCollectViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
