//
//  HomeService.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import UIKit
import App9999Model
import SQLite

public protocol IHomeService {
    func addShare(_ model: SharePresentationModel) throws -> SharePresentationModel
    func getShares() throws -> [SharePresentationModel]
}

public class HomeService: IHomeService {

    public init() { }

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    typealias Expression = SQLite.Expression

    public func addShare(_ model: SharePresentationModel) throws -> SharePresentationModel {
        let db = try Connection("\(path)/db.sqlite3")
        let shares = Table("Shares")
        let idColumn = Expression<Int>("id")
        let nameColumn = Expression<String>("name")
        let imageNameColumn = Expression<String>("imageName")
        let balanceColumn = Expression<Int>("balance")
        let procientColumn = Expression<Double>("procient")
        let sharesCountColumn = Expression<Int>("sharesCount")

        try db.run(shares.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(nameColumn)
            t.column(imageNameColumn)
            t.column(balanceColumn)
            t.column(procientColumn)
            t.column(sharesCountColumn)
        })

        let rowId = try db.run(shares.insert(
            nameColumn <- model.name,
            imageNameColumn <- model.imageName,
            balanceColumn <- model.balance,
            procientColumn <- model.procient,
            sharesCountColumn <- model.sharesCount
        ))

        return SharePresentationModel(id: Int(rowId),
                                      imageName: model.imageName,
                                      name: model.name,
                                      balance: model.balance,
                                      procient: model.procient,
                                      sharesCount: model.sharesCount)
    }

    public func getShares() throws -> [SharePresentationModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let shares = Table("Shares")
        let idColumn = Expression<Int>("id")
        let nameColumn = Expression<String>("name")
        let imageNameColumn = Expression<String>("imageName")
        let balanceColumn = Expression<Int>("balance")
        let procientColumn = Expression<Double>("procient")
        let sharesCountColumn = Expression<Int>("sharesCount")

        var result: [SharePresentationModel] = []

        for share in try db.prepare(shares) {
            let fetchedShare = SharePresentationModel(id: share[idColumn],
                                                      imageName: share[imageNameColumn],
                                                      name: share[nameColumn],
                                                      balance: share[balanceColumn],
                                                      procient: share[procientColumn],
                                                      sharesCount: share[sharesCountColumn])

            result.append(fetchedShare)
        }

        return result
    }
}
