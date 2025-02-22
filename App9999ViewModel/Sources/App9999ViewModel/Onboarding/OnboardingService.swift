//
//  OnboardingService.swift
//  App9999ViewModel
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import UIKit
import App9999Model

public protocol IOnboardingService {
    func getOnboardingItems() -> [OnboardingPresentationModel]
}

public class OnboardingService: IOnboardingService {
    public init() { }

    public func getOnboardingItems() -> [OnboardingPresentationModel] {
        [
            OnboardingPresentationModel(image: "Unknown",
                                        header: "Start Building Your Financial Future Today"),
            OnboardingPresentationModel(image: "onboarding2",
                                        header: "Take Control of Your Financial Journey")
        ]
    }
}
