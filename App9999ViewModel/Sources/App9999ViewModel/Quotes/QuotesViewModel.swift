//
//  QuotesViewModel.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import App9999Model

public protocol IQuotesViewModel {

}

public class QuotesViewModel: IQuotesViewModel {

    private let quotesService: IQuotesService

    public init(quotesService: IQuotesService) {
        self.quotesService = quotesService
    }
}
