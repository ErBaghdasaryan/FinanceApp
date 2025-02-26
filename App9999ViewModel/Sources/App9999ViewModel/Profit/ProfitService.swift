//
//  ProfitService.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import UIKit
import App9999Model
import SQLite

public protocol IProfitService {
    func getShares() throws -> [SharePresentationModel]
}

public class ProfitService: IProfitService {

    public init() { }

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    typealias Expression = SQLite.Expression

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
