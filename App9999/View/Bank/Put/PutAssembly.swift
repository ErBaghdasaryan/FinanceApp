//
//  PutAssembly.swift
//  App9999
//
//  Created by Er Baghdasaryan on 26.02.25.
//
import Foundation
import Swinject
import SwinjectAutoregistration
import App9999ViewModel
import App9999Model

final class PutAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IPutViewModel.self, argument: PutNavigationModel.self, initializer: PutViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IPutService.self, initializer: PutService.init)
    }
}
