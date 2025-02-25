//
//  SettingsRouter.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import UIKit
import App9999ViewModel

final class SettingsRouter: BaseRouter {
    static func showPrivacyViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makePrivacyViewController()
        viewController.navigationItem.hidesBackButton = false
        navigationController.navigationBar.isHidden = false
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showTermsViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeTermsViewController()
        viewController.navigationItem.hidesBackButton = false
        navigationController.navigationBar.isHidden = false
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showFeedbackViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeFeedbackViewController()
        viewController.navigationItem.hidesBackButton = false
        navigationController.navigationBar.isHidden = false
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
