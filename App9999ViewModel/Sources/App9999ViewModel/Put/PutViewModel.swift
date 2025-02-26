//
//  PutViewModel.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import Foundation
import App9999Model
import Combine

public protocol IPutViewModel {
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
    var count: Int { get }
}

public class PutViewModel: IPutViewModel {

    private let putService: IPutService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()
    public var count: Int

    public init(putService: IPutService, navigationModel: PutNavigationModel) {
        self.putService = putService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.count = navigationModel.count
    }
}
