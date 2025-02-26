//
//  CollectViewModel.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import Foundation
import App9999Model

public protocol ICollectViewModel {
    var balance: String { get set }
    func loadShares()
    var shareItems: [SharePresentationModel] { get set }
    func filterShares(with query: String)
    var filteredShareItems: [SharePresentationModel] { get set }
    func addShare(_ model: SharePresentationModel)
}

public class CollectViewModel: ICollectViewModel {

    private let collectService: ICollectService
    public var appStorageService: IAppStorageService

    public var shareItems: [SharePresentationModel] = []
    public var filteredShareItems: [SharePresentationModel] = []

    public var balance: String {
        get {
            return appStorageService.getData(key: .balanceCount) ?? ""
        } set {
            appStorageService.saveData(key: .balanceCount, value: newValue)
        }
    }

    public init(collectService: ICollectService, appStorageService: IAppStorageService) {
        self.collectService = collectService
        self.appStorageService = appStorageService
    }

    public func loadShares() {
        self.shareItems = self.collectService.getShareItems()
        self.filteredShareItems = shareItems
    }

    public func filterShares(with query: String) {
        if query.isEmpty {
            filteredShareItems = shareItems
        } else {
            filteredShareItems = shareItems.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
    }

    public func addShare(_ model: SharePresentationModel) {
        do {
            _ = try self.collectService.addShare(model)
        } catch {
            print(error)
        }
    }
}
