//
//  CollectAssembly.swift
//  App9999
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import Foundation
import App9999ViewModel
import Swinject
import SwinjectAutoregistration

final class CollectAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(ICollectViewModel.self, initializer: CollectViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(ICollectService.self, initializer: CollectService.init)
    }
}
