//
//  ProfitViewController.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import UIKit
import App9999ViewModel
import SnapKit
import StoreKit

class ProfitViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?
    private let topView = UIView()
    private let titleLabel = UILabel(text: "Profitability",
                                     textColor: .white,
                                     font: UIFont(name: "Nunito-Bold", size: 32))

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

        self.view.addSubview(topView)
        self.view.addSubview(titleLabel)
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
            view.trailing.equalToSuperview().offset(16)
            view.height.equalTo(48)
        }
    }

}

//MARK: Make buttons actions
extension ProfitViewController {
    
    private func makeButtonsAction() {

    }
}

extension ProfitViewController: IViewModelableController {
    typealias ViewModel = IProfitViewModel
}

//MARK: UIGesture & cell's touches
extension ProfitViewController: UITextFieldDelegate, UITextViewDelegate {

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

struct ProfitViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let profitViewController = ProfitViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<ProfitViewControllerProvider.ContainerView>) -> ProfitViewController {
            return profitViewController
        }

        func updateUIViewController(_ uiViewController: ProfitViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProfitViewControllerProvider.ContainerView>) {
        }
    }
}
