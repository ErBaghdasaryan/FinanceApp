//
//  BalanceViewController.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import UIKit
import App9999ViewModel
import SnapKit
import StoreKit

class BalanceViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let background = UIImageView(image: UIImage(named: "firstBackground"))
    private let header = UILabel(text: "Enter Your Account Balance",
                                 textColor: .white,
                                 font: UIFont(name: "Nunito-Bold", size: 36))
    private let balance = CustomTextField(placeholder: "Wallet", rightText: "15 000 $")
    private let errorLabel = UILabel(text: "You must have an initial balance before you switch to another page.",
                                     textColor: .red,
                                     font: UIFont(name: "Nunito-Rugular", size: 10))
    private let letsStartButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func setupUI() {
        super.setupUI()

        self.letsStartButton.setTitle("Let's start", for: .normal)
        self.letsStartButton.setTitleColor(.black, for: .normal)
        self.letsStartButton.layer.cornerRadius = 16
        self.letsStartButton.layer.masksToBounds = true
        self.letsStartButton.titleLabel?.font = UIFont(name: "Nunito-Bold", size: 16)
        self.letsStartButton.backgroundColor = .white

        self.header.textAlignment = .left
        self.header.numberOfLines = 2
        self.header.lineBreakMode = .byWordWrapping

        self.errorLabel.textAlignment = .left
        self.errorLabel.numberOfLines = 0
        self.errorLabel.lineBreakMode = .byWordWrapping
        self.errorLabel.isHidden = true

        self.background.frame = self.view.bounds

        self.view.addSubview(background)
        self.view.addSubview(header)
        self.view.addSubview(balance)
        self.view.addSubview(errorLabel)
        self.view.addSubview(letsStartButton)
        setupConstraints()
        setupViewTapHandling()
        setupTextFieldDelegates()
        setupKeyboardObservers()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(73)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(82)
            view.height.equalTo(100)
        }

        balance.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(24)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(56)
        }

        errorLabel.snp.makeConstraints { view in
            view.top.equalTo(balance.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
        }

        letsStartButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(71)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(52)
        }
    }

}

//MARK: Make buttons actions
extension BalanceViewController {
    
    private func makeButtonsAction() {
        letsStartButton.addTarget(self, action: #selector(letsStartTaped), for: .touchUpInside)
    }

    @objc func letsStartTaped() {
        guard let balance = balance.text else { return }

        if balance.isEmpty {
            errorLabel.isHidden = false
            return
        } else {
            guard let navigationController = self.navigationController else { return }

            self.errorLabel.isHidden = true
            self.viewModel?.balance = balance
            let viewControllers = navigationController.viewControllers

            if let homeVC = viewControllers.first(where: { $0 is HomeViewController }) {
                HomeRouter.popViewController(in: navigationController)
            } else {
                BalanceRouter.showTabBarController(in: navigationController)
            }
            
        }
    }
}

//MARK: UIGesture & cell's touches
extension BalanceViewController: UITextFieldDelegate, UITextViewDelegate {

    private func setupTextFieldDelegates() {
        self.balance.delegate = self

        self.balance.keyboardType = .numberPad
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.errorLabel.isHidden = true
        return true
    }

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    private func setupViewTapHandling() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
}

//MARK: Keyboard Notifications
extension BalanceViewController {

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.3

            UIView.animate(withDuration: duration) {
                self.letsStartButton.snp.updateConstraints { make in
                    make.bottom.equalToSuperview().inset(keyboardHeight + 31)
                }
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.3

        UIView.animate(withDuration: duration) {
            self.letsStartButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(71)
            }
            self.view.layoutIfNeeded()
        }

        guard let balance = balance.text else { return }

        if balance.isEmpty {
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
        }
    }
}

extension BalanceViewController: IViewModelableController {
    typealias ViewModel = IBalanceViewModel
}

//MARK: Preview
import SwiftUI

struct BalanceViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let balanceViewController = BalanceViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<BalanceViewControllerProvider.ContainerView>) -> BalanceViewController {
            return balanceViewController
        }

        func updateUIViewController(_ uiViewController: BalanceViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<BalanceViewControllerProvider.ContainerView>) {
        }
    }
}
