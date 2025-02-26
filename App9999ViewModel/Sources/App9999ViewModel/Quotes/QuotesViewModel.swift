//
//  QuotesViewModel.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation
import App9999Model

public protocol IQuotesViewModel {
    var quotesItems: [QuotePresentationModel] { get set }
    var savedQuotes: [QuotePresentationModel] { get set }
    func loadQuotes()
    func loadFavoriteQuotes()
    func addQuote(_ model: QuotePresentationModel)
    func deleteQuote(by id: Int)
}

public class QuotesViewModel: IQuotesViewModel {

    private let quotesService: IQuotesService

    public var quotesItems: [QuotePresentationModel] = []
    public var savedQuotes: [QuotePresentationModel] = []

    public init(quotesService: IQuotesService) {
        self.quotesService = quotesService
    }

    public func loadQuotes() {
        self.quotesItems = quotesService.getQuoteItems()
    }

    public func loadFavoriteQuotes() {
        do {
            self.savedQuotes = try self.quotesService.getQuotes()
        } catch {
            print(error)
        }
    }

    public func addQuote(_ model: QuotePresentationModel) {
        do {
            _ = try self.quotesService.addQuote(model)
        } catch {
            print(error)
        }
    }

    public func deleteQuote(by id: Int) {
        do {
            try self.quotesService.deleteQuote(by: id)
        } catch {
            print(error)
        }
    }
}
