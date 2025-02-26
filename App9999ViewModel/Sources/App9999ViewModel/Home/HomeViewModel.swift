//
//  HomeViewModel.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import App9999Model

public protocol IHomeViewModel {
    var balance: String { get }
}

public class HomeViewModel: IHomeViewModel {

    private let homeService: IHomeService
    public var appStorageService: IAppStorageService

    public var balance: String {
        get {
            return appStorageService.getData(key: .balanceCount) ?? ""
        }
    }

    public init(homeService: IHomeService, appStorageService: IAppStorageService) {
        self.homeService = homeService
        self.appStorageService = appStorageService
    }
}
