//
//  CollectService.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import UIKit
import App9999Model

public protocol ICollectService {
    func getShareItems() -> [SharePresentationModel]
}

public class CollectService: ICollectService {

    public init() { }

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
}
