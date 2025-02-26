//
//  CollectService.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import UIKit
import App9999Model
import SQLite

public protocol ICollectService {
    func getShareItems() -> [SharePresentationModel]
    func addShare(_ model: SharePresentationModel) throws -> SharePresentationModel
}

public class CollectService: ICollectService {

    public init() { }

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    typealias Expression = SQLite.Expression

    public func getShareItems() -> [SharePresentationModel] {
        [
            SharePresentationModel(imageName: "apple",
                                   name: "Apple",
                                   balance: 2850,
                                   procient: 11.2,
                                   sharesCount: 0),
            SharePresentationModel(imageName: "amazon",
                                   name: "Amazon",
                                   balance: 2100,
                                   procient: 8.6,
                                   sharesCount: 0),
            SharePresentationModel(imageName: "bmw",
                                   name: "BMW",
                                   balance: 3400,
                                   procient: 21.5,
                                   sharesCount: 0),
            SharePresentationModel(imageName: "google",
                                   name: "Google",
                                   balance: 996,
                                   procient: 6.6,
                                   sharesCount: 0),
            SharePresentationModel(imageName: "kfc",
                                   name: "KFC",
                                   balance: 3400,
                                   procient: 21.5,
                                   sharesCount: 0),
            SharePresentationModel(imageName: "lays",
                                   name: "Lays",
                                   balance: 544,
                                   procient: 4.5,
                                   sharesCount: 0),
            SharePresentationModel(imageName: "netflix",
                                   name: "Netflix",
                                   balance: 2100,
                                   procient: 8.6,
                                   sharesCount: 0),
            SharePresentationModel(imageName: "raiffeisen",
                                   name: "Raiffeisen",
                                   balance: 3120,
                                   procient: 15.3,
                                   sharesCount: 0),
            SharePresentationModel(imageName: "samsung",
                                   name: "Samsung",
                                   balance: 544,
                                   procient: 4.5,
                                   sharesCount: 0),
            SharePresentationModel(imageName: "tiktok",
                                   name: "Tik Tok",
                                   balance: 2850,
                                   procient: 11.2,
                                   sharesCount: 0),
            SharePresentationModel(imageName: "VK",
                                   name: "Vkontakte",
                                   balance: 3120,
                                   procient: 15.3,
                                   sharesCount: 0),
            SharePresentationModel(imageName: "xiaomi",
                                   name: "Xiaomi",
                                   balance: 996,
                                   procient: 6.6,
                                   sharesCount: 0),
        ]
    }

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
}
