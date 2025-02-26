//
//  QuotesService.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import UIKit
import App9999Model
import SQLite

public protocol IQuotesService {
    func getQuoteItems() -> [QuotePresentationModel]
    func addQuote(_ model: QuotePresentationModel) throws -> QuotePresentationModel
    func getQuotes() throws -> [QuotePresentationModel]
    func deleteQuote(by id: Int) throws
}

public class QuotesService: IQuotesService {

    public init() { }

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    typealias Expression = SQLite.Expression

    public func getQuoteItems() -> [QuotePresentationModel] {
        [
            QuotePresentationModel(name: "Bill Gates",
                                   text: "When you have money in your hands, only you forget who you are. But when you don't have money in your hands, everyone forgets who you are. That's life."),
            QuotePresentationModel(name: "Bill Gates",
                                   text: "The key to success in business is to determine where the world is going and get there first"),
            QuotePresentationModel(name: "Bill Gates",
                                   text: "You will not earn 5,000 euros per month immediately after graduation and will not become a vice president until you have earned both achievements through your efforts"),
            QuotePresentationModel(name: "Bill Gates",
                                   text: "Yes, you can learn anything")
        ]
    }

    public func addQuote(_ model: QuotePresentationModel) throws -> QuotePresentationModel {
        let db = try Connection("\(path)/db.sqlite3")
        let quotes = Table("Quotes")
        let idColumn = Expression<Int>("id")
        let nameColumn = Expression<String>("name")
        let textColumn = Expression<String>("text")

        try db.run(quotes.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(nameColumn)
            t.column(textColumn)
        })

        let rowId = try db.run(quotes.insert(
            nameColumn <- model.name,
            textColumn <- model.text
        ))

        return QuotePresentationModel(id: Int(rowId),
                                      name: model.name,
                                      text: model.text,
                                      isFavorite: true)
    }

    public func getQuotes() throws -> [QuotePresentationModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let quotes = Table("Quotes")
        let idColumn = Expression<Int>("id")
        let nameColumn = Expression<String>("name")
        let textColumn = Expression<String>("text")

        var result: [QuotePresentationModel] = []

        for quote in try db.prepare(quotes) {
            let fetchedQuote = QuotePresentationModel(id: quote[idColumn],
                                                      name: quote[nameColumn],
                                                      text: quote[textColumn],
                                                      isFavorite: true)

            result.append(fetchedQuote)
        }

        return result
    }

    public func deleteQuote(by id: Int) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let quotes = Table("Quotes")
        let idColumn = Expression<Int>("id")

        let quoteToDelete = quotes.filter(idColumn == id)
        
        if try db.run(quoteToDelete.delete()) > 0 {
            print("Quote deleted successfully.")
        } else {
            print("Quote not found.")
        }
    }
}
