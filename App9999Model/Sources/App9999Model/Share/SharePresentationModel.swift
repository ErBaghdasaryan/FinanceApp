//
//  SharePresentationModel.swift
//  App9999Model
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import Foundation

public struct SharePresentationModel {
    public let id: Int?
    public let imageName: String
    public let name: String
    public let balance: Int
    public let procient: Float
    public let sharesCount: Int

    public init(id: Int? = nil, imageName: String, name: String, balance: Int, procient: Float, sharesCount: Int) {
        self.id = id
        self.imageName = imageName
        self.name = name
        self.balance = balance
        self.procient = procient
        self.sharesCount = sharesCount
    }
}
