//
//  ViewControllerFactory.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import Swinject
import App9999Model
import App9999ViewModel

final class ViewControllerFactory {
    private static let commonAssemblies: [Assembly] = [ServiceAssembly()]

    //MARK: Onboarding
    static func makeOnboardingViewController() -> OnboardingViewController {
        let assembler = Assembler(commonAssemblies + [OnboardingAssembly()])
        let viewController = OnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IOnboardingViewModel.self)
        return viewController
    }

    //MARK: Balance
    static func makeBalanceViewController() -> BalanceViewController {
        let assembler = Assembler(commonAssemblies + [BalanceAssembly()])
        let viewController = BalanceViewController()
        viewController.viewModel = assembler.resolver.resolve(IBalanceViewModel.self)
        return viewController
    }

    //MARK: - TabBar
    static func makeTabBarViewController() -> TabBarViewController {
        let viewController = TabBarViewController()
        return viewController
    }

    //MARK: Home
    static func makeHomeViewController() -> HomeViewController {
        let assembler = Assembler(commonAssemblies + [HomeAssembly()])
        let viewController = HomeViewController()
        viewController.viewModel = assembler.resolver.resolve(IHomeViewModel.self)
        return viewController
    }

    //MARK: Collect
    static func makeCollectViewController() -> CollectViewController {
        let assembler = Assembler(commonAssemblies + [CollectAssembly()])
        let viewController = CollectViewController()
        viewController.viewModel = assembler.resolver.resolve(ICollectViewModel.self)
        return viewController
    }

    //MARK: Profit
    static func makeProfitViewController() -> ProfitViewController {
        let assembler = Assembler(commonAssemblies + [ProfitAssembly()])
        let viewController = ProfitViewController()
        viewController.viewModel = assembler.resolver.resolve(IProfitViewModel.self)
        return viewController
    }

    //MARK: Quotes
    static func makeQuotesViewController() -> QuotesViewController {
        let assembler = Assembler(commonAssemblies + [QuotesAssembly()])
        let viewController = QuotesViewController()
        viewController.viewModel = assembler.resolver.resolve(IQuotesViewModel.self)
        return viewController
    }

    //MARK: Bank
    static func makeBankViewController() -> BankViewController {
        let assembler = Assembler(commonAssemblies + [BankAssembly()])
        let viewController = BankViewController()
        viewController.viewModel = assembler.resolver.resolve(IBankViewModel.self)
        return viewController
    }

    //MARK: Settings
    static func makeSettingsViewController() -> SettingsViewController {
        let assembler = Assembler(commonAssemblies + [SettingsAssembly()])
        let viewController = SettingsViewController()
        viewController.viewModel = assembler.resolver.resolve(ISettingsViewModel.self)
        return viewController
    }

    //MARK: PrivacyPolicy
    static func makePrivacyViewController() -> PrivacyViewController {
        let viewController = PrivacyViewController()
        return viewController
    }

    //MARK: Terms
    static func makeTermsViewController() -> TermsViewController {
        let viewController = TermsViewController()
        return viewController
    }

    //MARK: Feedback
    static func makeFeedbackViewController() -> FeedbackViewController {
        let viewController = FeedbackViewController()
        return viewController
    }
}
