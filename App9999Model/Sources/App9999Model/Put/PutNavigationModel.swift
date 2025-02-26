//
//  PutNavigationModel.swift
//  App9999Model
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import Foundation
import Combine

public final class PutNavigationModel {
    public var activateSuccessSubject: PassthroughSubject<Bool, Never>
    public var count: Int

    public init(activateSuccessSubject: PassthroughSubject<Bool, Never>, count: Int) {
        self.activateSuccessSubject = activateSuccessSubject
        self.count = count
    }
}
