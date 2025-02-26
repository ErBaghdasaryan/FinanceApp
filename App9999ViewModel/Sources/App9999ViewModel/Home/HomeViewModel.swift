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
    var savedShares: [SharePresentationModel] { get set }
    var filteredSavedShareItems: [SharePresentationModel] { get set }
    func loadShares()
    func filterShares(with query: String)
}

public class HomeViewModel: IHomeViewModel {

    private let homeService: IHomeService
    public var appStorageService: IAppStorageService

    public var savedShares: [SharePresentationModel] = []
    public var filteredSavedShareItems: [SharePresentationModel] = []

    public var balance: String {
        get {
            return appStorageService.getData(key: .balanceCount) ?? ""
        }
    }

    public init(homeService: IHomeService, appStorageService: IAppStorageService) {
        self.homeService = homeService
        self.appStorageService = appStorageService
    }

    public func loadShares() {
        do {
            self.savedShares = try self.homeService.getShares()
            self.filteredSavedShareItems = savedShares
        } catch {
            print(error)
        }
    }

    public func filterShares(with query: String) {
        if query.isEmpty {
            filteredSavedShareItems = savedShares
        } else {
            filteredSavedShareItems = savedShares.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
    }
}
