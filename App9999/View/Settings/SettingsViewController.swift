//
//  SettingsViewController.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import UIKit
import App9999ViewModel
import SnapKit
import StoreKit

class SettingsViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?
    private let topView = UIView()
    private let titleLabel = UILabel(text: "Settings",
                                     textColor: .white,
                                     font: UIFont(name: "Nunito-Bold", size: 32))
    private let terms = SettingsButton()
    private let policy = SettingsButton()
    private let feedback = SettingsButton()
    private let rateApp = SettingsButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#252121")

        self.titleLabel.textAlignment = .left
        self.topView.backgroundColor = UIColor(hex: "#171416")

        self.topView.layer.masksToBounds = true
        self.topView.layer.cornerRadius = 16
        self.topView.layer.maskedCorners = [.layerMinXMaxYCorner,
            .layerMaxXMaxYCorner]

        self.terms.setTitle("Terms and conditions", for: .normal)
        self.policy.setTitle("Policy privacy", for: .normal)
        self.feedback.setTitle("Feedback", for: .normal)
        self.rateApp.setTitle("Rate app", for: .normal)

        self.view.addSubview(topView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(terms)
        self.view.addSubview(policy)
        self.view.addSubview(feedback)
        self.view.addSubview(rateApp)
        setupConstraints()
        setupViewTapHandling()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {
        topView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(116)
        }

        titleLabel.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(58)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(48)
        }

        terms.snp.makeConstraints { view in
            view.top.equalTo(topView.snp.bottom).offset(12)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(48)
        }

        policy.snp.makeConstraints { view in
            view.top.equalTo(terms.snp.bottom)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(48)
        }

        feedback.snp.makeConstraints { view in
            view.top.equalTo(policy.snp.bottom)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(48)
        }

        rateApp.snp.makeConstraints { view in
            view.top.equalTo(feedback.snp.bottom)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(48)
        }
    }

}

//MARK: Make buttons actions
extension SettingsViewController {
    
    private func makeButtonsAction() {
        self.feedback.addTarget(self, action: #selector(feedbackTapped), for: .touchUpInside)
        self.terms.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)
        self.policy.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
        self.rateApp.addTarget(self, action: #selector(rateTapped), for: .touchUpInside)
    }

    @objc func feedbackTapped() {
        guard let navigationController = self.navigationController else { return }

        SettingsRouter.showFeedbackViewController(in: navigationController)
    }

    @objc func termsTapped() {
        guard let navigationController = self.navigationController else { return }

        SettingsRouter.showTermsViewController(in: navigationController)
    }

    @objc func privacyTapped() {
        guard let navigationController = self.navigationController else { return }

        SettingsRouter.showPrivacyViewController(in: navigationController)
    }

    @objc func rateTapped() {
        if #available(iOS 14.0, *) {
            SKStoreReviewController.requestReview()
        } else {
            let alertController = UIAlertController(
                title: "Enjoying the app?",
                message: "Please consider leaving us a review in the App Store!",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Go to App Store", style: .default) { _ in
                if let appStoreURL = URL(string: "https://apps.apple.com/us/app/id6738487971") {
                    UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                }
            })
            present(alertController, animated: true, completion: nil)
        }
    }
}

extension SettingsViewController: IViewModelableController {
    typealias ViewModel = ISettingsViewModel
}

//MARK: UIGesture & cell's touches
extension SettingsViewController: UITextFieldDelegate, UITextViewDelegate {

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    private func setupViewTapHandling() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
}

//MARK: Preview
import SwiftUI

struct SettingsViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let settingsViewController = SettingsViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) -> SettingsViewController {
            return settingsViewController
        }

        func updateUIViewController(_ uiViewController: SettingsViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) {
        }
    }
}
