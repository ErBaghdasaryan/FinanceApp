//
//  OnboardingRouter.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import UIKit
import App9999ViewModel

final class OnboardingRouter: BaseRouter {
    static func showBalanceController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeBalanceViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
