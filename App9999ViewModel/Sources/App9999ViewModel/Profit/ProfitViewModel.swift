//
//  ProfitViewModel.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import App9999Model

public protocol IProfitViewModel {
    func loadShares()
    var savedShares: [SharePresentationModel] { get set }
}

public class ProfitViewModel: IProfitViewModel {

    private let profitService: IProfitService
    public var savedShares: [SharePresentationModel] = []

    public init(profitService: IProfitService) {
        self.profitService = profitService
    }

    public func loadShares() {
        do {
            self.savedShares = try self.profitService.getShares()
        } catch {
            print(error)
        }
    }
}
