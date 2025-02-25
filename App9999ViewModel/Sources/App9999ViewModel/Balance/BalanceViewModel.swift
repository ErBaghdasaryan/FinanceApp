//
//  BalanceViewModel.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import App9999Model

public protocol IBalanceViewModel {
    var balance: String { get set }
}

public class BalanceViewModel: IBalanceViewModel {

    private let balanceService: IBalanceService
    public var appStorageService: IAppStorageService

    public var balance: String {
        get {
            return appStorageService.getData(key: .balanceCount) ?? ""
        }
        set {
            appStorageService.saveData(key: .balanceCount, value: newValue)
        }
    }

    public init(balanceService: IBalanceService, appStorageService: IAppStorageService) {
        self.balanceService = balanceService
        self.appStorageService = appStorageService
    }
}
