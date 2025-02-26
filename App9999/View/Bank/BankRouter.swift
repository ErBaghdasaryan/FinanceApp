//
//  BankRouter.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import UIKit
import App9999ViewModel
import App9999Model

final class BankRouter: BaseRouter {

    static func showPutViewController(in navigationController: UINavigationController, navigationModel: PutNavigationModel) {
        let viewController = ViewControllerFactory.makePutViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
