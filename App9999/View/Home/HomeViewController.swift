//
//  HomeViewController.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import UIKit
import App9999ViewModel
import SnapKit
import StoreKit

class HomeViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?
    private let topView = UIView()
    private let titleLabel = UILabel(text: "Home",
                                     textColor: .white,
                                     font: UIFont(name: "Nunito-Bold", size: 32))
    private let homeView = HomeView()
    private let editWallet = UIButton(type: .system)
    private let shares = UILabel(text: "Shares",
                                 textColor: UIColor(hex: "#9F9F9F")!,
                                 font: UIFont(name: "Nunito-Regular", size: 16))
    private let editShares = UIButton(type: .system)
    private let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let balance = self.viewModel?.balance else { return }
        self.homeView.changeBalance(balance: "\(balance)$")
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

        self.editWallet.setImage(UIImage(named: "editButton"), for: .normal)
        self.editShares.setImage(UIImage(named: "editButton"), for: .normal)

        self.shares.textAlignment = .left

        self.searchBar.searchTextField.backgroundColor = UIColor(hex: "#252121")
        self.searchBar.barTintColor = UIColor(hex: "#252121")
        self.searchBar.layer.masksToBounds = true
        self.searchBar.layer.cornerRadius = 16
        self.searchBar.layer.borderWidth = 1
        self.searchBar.layer.borderColor = UIColor(hex: "#484444")?.cgColor
        self.searchBar.searchTextField.textColor = UIColor.white
        if let searchField = searchBar.value(forKey: "searchField") as? UITextField {
            if let leftView = searchField.leftView as? UIImageView {
                leftView.tintColor = UIColor.white
            }
        }

        self.view.addSubview(topView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(homeView)
        self.view.addSubview(editWallet)
        self.view.addSubview(shares)
        self.view.addSubview(editShares)
        self.view.addSubview(searchBar)
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

        homeView.snp.makeConstraints { view in
            view.top.equalTo(titleLabel.snp.bottom).offset(26)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(92)
        }

        editWallet.snp.makeConstraints { view in
            view.top.equalTo(homeView.snp.top)
            view.trailing.equalTo(homeView.snp.trailing)
            view.height.equalTo(24)
            view.width.equalTo(24)
        }

        shares.snp.makeConstraints { view in
            view.top.equalTo(homeView.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(56)
            view.height.equalTo(24)
        }

        editShares.snp.makeConstraints { view in
            view.centerY.equalTo(shares.snp.centerY)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(24)
            view.width.equalTo(24)
        }

        searchBar.snp.makeConstraints { view in
            view.top.equalTo(shares.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(52)
        }
    }

}

//MARK: Make buttons actions
extension HomeViewController {
    
    private func makeButtonsAction() {
        self.editWallet.addTarget(self, action: #selector(editWalletTapped), for: .touchUpInside)
        self.editShares.addTarget(self, action: #selector(editSharesTapped), for: .touchUpInside)
    }

    @objc func editWalletTapped() {
        guard let navigationController = self.navigationController else { return }

        HomeRouter.showBalanceController(in: navigationController)
    }

    @objc func editSharesTapped() {
        guard let navigationController = self.navigationController else { return }

        HomeRouter.showCollectController(in: navigationController)
    }
}

extension HomeViewController: IViewModelableController {
    typealias ViewModel = IHomeViewModel
}

//MARK: UIGesture & cell's touches
extension HomeViewController: UITextFieldDelegate, UITextViewDelegate {

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

struct HomeViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let homeViewController = HomeViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<HomeViewControllerProvider.ContainerView>) -> HomeViewController {
            return homeViewController
        }

        func updateUIViewController(_ uiViewController: HomeViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<HomeViewControllerProvider.ContainerView>) {
        }
    }
}
