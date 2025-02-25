//
//  ProfitViewModel.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import App9999Model

public protocol IProfitViewModel {

}

public class ProfitViewModel: IProfitViewModel {

    private let profitService: IProfitService

    public init(profitService: IProfitService) {
        self.profitService = profitService
    }
}
