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
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let balance = self.viewModel?.balance else { return }
        self.homeView.changeBalance(balance: "\(balance)$")
        self.viewModel?.loadShares()
        self.collectionView.reloadData()
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
        self.searchBar.delegate = self
        if let searchField = searchBar.value(forKey: "searchField") as? UITextField {
            if let leftView = searchField.leftView as? UIImageView {
                leftView.tintColor = UIColor.white
            }
        }

        let mylayout = UICollectionViewFlowLayout()
        mylayout.scrollDirection = .vertical

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: mylayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true

        collectionView.register(SavedShareCollectionViewCell.self)
        collectionView.register(EmptyCollectionViewCelll.self)
        collectionView.backgroundColor = .clear

        collectionView.delegate = self
        collectionView.dataSource = self

        self.view.addSubview(topView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(homeView)
        self.view.addSubview(editWallet)
        self.view.addSubview(shares)
        self.view.addSubview(editShares)
        self.view.addSubview(searchBar)
        self.view.addSubview(collectionView)
        setupConstraints()
        setupViewTapHandling()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadShares()
        self.collectionView.reloadData()
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

        collectionView.snp.makeConstraints { view in
            view.top.equalTo(searchBar.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
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

//MARK: Collection view delegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.filteredSavedShareItems.isEmpty ?? true ? 1 : self.viewModel!.filteredSavedShareItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.viewModel?.filteredSavedShareItems.isEmpty ?? true {

            self.shares.isHidden = true
            self.searchBar.isHidden = true
            self.editShares.isHidden = true

            let cell: EmptyCollectionViewCelll = collectionView.dequeueReusableCell(for: indexPath)

            cell.addSubject.sink { [weak self] _ in
                self?.editSharesTapped()
            }.store(in: &cell.cancellables)

            return cell
        } else {
            self.shares.isHidden = false
            self.searchBar.isHidden = false
            self.editShares.isHidden = false

            let cell: SavedShareCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            if let model = self.viewModel?.filteredSavedShareItems[indexPath.row] {
                cell.setup(with: model)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.viewModel?.filteredSavedShareItems.isEmpty ?? true {
            return CGSize(width: collectionView.frame.width / 2, height: 100)
        } else {
            return CGSize(width: collectionView.frame.width, height: 58)
        }
    }
}
//MARK: UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterShares(with: searchText)
        collectionView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.filterShares(with: "")
        collectionView.reloadData()
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
