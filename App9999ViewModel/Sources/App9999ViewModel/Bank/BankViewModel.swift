//
//  BankViewModel.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import App9999Model
import Combine

public protocol IBankViewModel {
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
}

public class BankViewModel: IBankViewModel {

    private let bankService: IBankService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(bankService: IBankService) {
        self.bankService = bankService
    }
}
