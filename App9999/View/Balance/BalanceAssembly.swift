//
//  BalanceAssembly.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import App9999ViewModel
import Swinject
import SwinjectAutoregistration

final class BalanceAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IBalanceViewModel.self, initializer: BalanceViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IBalanceService.self, initializer: BalanceService.init)
    }
}
