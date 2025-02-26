//
//  QuotePresentationModel.swift
//  App9999Model
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import Foundation

public struct QuotePresentationModel {
    public let id: Int?
    public let name: String
    public let text: String
    public let isFavorite: Bool?

    public init(id: Int? = nil, name: String, text: String, isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.text = text
        self.isFavorite = isFavorite
    }
}
