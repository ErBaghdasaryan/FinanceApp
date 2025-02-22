//
//  BalanceViewModel.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import App9999Model

public protocol IBalanceViewModel {

}

public class BalanceViewModel: IBalanceViewModel {

    private let balanceService: IBalanceService

    public init(balanceService: IBalanceService) {
        self.balanceService = balanceService
    }
}
