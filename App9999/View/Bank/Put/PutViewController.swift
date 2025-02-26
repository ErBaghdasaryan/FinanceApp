//
//  PutViewController.swift
//  App9999
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import UIKit
import App9999ViewModel
import SnapKit
import StoreKit

class PutViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let background = UIImageView(image: UIImage(named: "firstBackground"))
    private let middleView = UIView()
    private let balance = UILabel(text: "",
                                  textColor: UIColor(hex: "#8DDF3C")!,
                                  font: UIFont(name: "Nunito-Regular", size: 36))
    private let askLabel = UILabel(text: "Put in a piggy bank?",
                                   textColor: UIColor.white,
                                   font: UIFont(name: "Nunito-Regular", size: 20))
    private let cancel = UIButton(type: .system)
    private let start = UIButton(type: .system)
    private var buttonsStack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let count = self.viewModel?.count else { return }

        self.balance.text = "\(count) $"
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func setupUI() {
        super.setupUI()

        self.background.frame = self.view.bounds

        self.middleView.layer.masksToBounds = true
        self.middleView.layer.cornerRadius = 16
        self.middleView.backgroundColor = UIColor.black.withAlphaComponent(0.46)

        self.cancel.backgroundColor = UIColor.white.withAlphaComponent(0.16)
        self.cancel.layer.masksToBounds = true
        self.cancel.layer.cornerRadius = 16
        self.cancel.setTitle("Cancel", for: .normal)
        self.cancel.setTitleColor(.white, for: .normal)

        self.start.backgroundColor = UIColor.white
        self.start.layer.masksToBounds = true
        self.start.layer.cornerRadius = 16
        self.start.setTitle("Yes", for: .normal)
        self.start.setTitleColor(.black, for: .normal)

        self.buttonsStack = UIStackView(arrangedSubviews: [cancel, start],
                                        axis: .horizontal,
                                        spacing: 8)
        self.buttonsStack.distribution = .fillEqually


        self.view.addSubview(background)
        self.view.addSubview(middleView)
        self.view.addSubview(balance)
        self.view.addSubview(askLabel)
        self.view.addSubview(buttonsStack)
        setupConstraints()
        setupViewTapHandling()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {
        middleView.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(306)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(200)
        }

        balance.snp.makeConstraints { view in
            view.top.equalTo(middleView.snp.top).offset(16)
            view.leading.equalTo(middleView.snp.leading).offset(16)
            view.trailing.equalTo(middleView.snp.trailing).inset(16)
            view.height.equalTo(50)
        }

        askLabel.snp.makeConstraints { view in
            view.top.equalTo(balance.snp.bottom).offset(16)
            view.leading.equalTo(middleView.snp.leading).offset(16)
            view.trailing.equalTo(middleView.snp.trailing).inset(16)
            view.height.equalTo(27)
        }

        buttonsStack.snp.makeConstraints { view in
            view.bottom.equalTo(middleView.snp.bottom).inset(16)
            view.leading.equalTo(middleView.snp.leading).offset(16)
            view.trailing.equalTo(middleView.snp.trailing).inset(16)
            view.height.equalTo(52)
        }
    }

}

//MARK: Make buttons actions
extension PutViewController {
    
    private func makeButtonsAction() {
        cancel.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        start.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
    }

    @objc func cancelTapped() {
        guard let navigationController = self.navigationController else { return }

        self.viewModel?.activateSuccessSubject.send(false)
        BankRouter.popViewController(in: navigationController)
    }

    @objc func startTapped() {
        guard let navigationController = self.navigationController else { return }

        self.viewModel?.activateSuccessSubject.send(true)
        BankRouter.popViewController(in: navigationController)
    }
}

//MARK: UIGesture & cell's touches
extension PutViewController: UITextFieldDelegate, UITextViewDelegate {

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    private func setupViewTapHandling() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
}

extension PutViewController: IViewModelableController {
    typealias ViewModel = IPutViewModel
}

//MARK: Preview
import SwiftUI

struct PutViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let putViewController = PutViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<PutViewControllerProvider.ContainerView>) -> PutViewController {
            return putViewController
        }

        func updateUIViewController(_ uiViewController: PutViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PutViewControllerProvider.ContainerView>) {
        }
    }
}
