//
//  Setupable.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import Foundation

protocol ISetupable {
    associatedtype SetupModel
    func setup(with model: SetupModel)
}
