//
//  BankViewModel.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import App9999Model

public protocol IBankViewModel {

}

public class BankViewModel: IBankViewModel {

    private let bankService: IBankService

    public init(bankService: IBankService) {
        self.bankService = bankService
    }
}
