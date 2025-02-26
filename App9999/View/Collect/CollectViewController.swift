//
//  CollectViewController.swift
//  App9999
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import UIKit
import App9999ViewModel
import SnapKit
import StoreKit

class CollectViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?
    private let topView = UIView()
    private let backButton = UIButton(type: .system)
    private let titleLabel = UILabel(text: "Collect a briefcase",
                                     textColor: .white,
                                     font: UIFont(name: "Nunito-Bold", size: 24))
    private let homeView = HomeView()
    private let shares = UILabel(text: "Shares",
                                 textColor: UIColor(hex: "#9F9F9F")!,
                                 font: UIFont(name: "Nunito-Regular", size: 16))
    private let searchBar = UISearchBar()
    var collectionView: UICollectionView!
    private let canceleButton = UIButton(type: .system)
    private let saveButton = UIButton(type: .system)
    private var buttonsStack: UIStackView!

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

        self.backButton.setImage(UIImage(named: "backButton"), for: .normal)

        self.shares.textAlignment = .left

        self.searchBar.searchTextField.backgroundColor = UIColor(hex: "#252121")
        self.searchBar.barTintColor = UIColor(hex: "#252121")
        self.searchBar.layer.masksToBounds = true
        self.searchBar.layer.cornerRadius = 16
        self.searchBar.layer.borderWidth = 1
        self.searchBar.layer.borderColor = UIColor(hex: "#484444")?.cgColor
        self.searchBar.delegate = self
        self.searchBar.searchTextField.textColor = UIColor.white
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

        collectionView.register(ShareCollectionViewCell.self)
        collectionView.backgroundColor = .clear

        collectionView.delegate = self
        collectionView.dataSource = self

        self.canceleButton.setTitle("Cancele", for: .normal)
        self.canceleButton.setTitleColor(.white, for: .normal)
        self.canceleButton.backgroundColor = UIColor.white.withAlphaComponent(0.16)
        self.canceleButton.layer.masksToBounds = true
        self.canceleButton.layer.cornerRadius = 16

        self.saveButton.setTitle("Save", for: .normal)
        self.saveButton.setTitleColor(.black, for: .normal)
        self.saveButton.backgroundColor = UIColor.white
        self.saveButton.layer.masksToBounds = true
        self.saveButton.layer.cornerRadius = 16

        self.buttonsStack = UIStackView(arrangedSubviews: [canceleButton, saveButton],
                                        axis: .horizontal,
                                        spacing: 8)
        self.buttonsStack.distribution = .fillEqually

        self.view.addSubview(topView)
        self.view.addSubview(backButton)
        self.view.addSubview(titleLabel)
        self.view.addSubview(homeView)
        self.view.addSubview(shares)
        self.view.addSubview(searchBar)
        self.view.addSubview(collectionView)
        self.view.addSubview(buttonsStack)
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

        backButton.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(66)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(32)
            view.height.equalTo(32)
        }

        titleLabel.snp.makeConstraints { view in
            view.centerY.equalTo(backButton.snp.centerY)
            view.leading.equalTo(backButton.snp.trailing).offset(10)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(36)
        }

        homeView.snp.makeConstraints { view in
            view.top.equalTo(titleLabel.snp.bottom).offset(26)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(92)
        }

        shares.snp.makeConstraints { view in
            view.top.equalTo(homeView.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(56)
            view.height.equalTo(24)
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
            view.bottom.equalToSuperview().inset(116)
        }

        buttonsStack.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(48)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(52)
        }
    }

}

//MARK: Make buttons actions
extension CollectViewController {
    
    private func makeButtonsAction() {
        self.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        self.canceleButton.addTarget(self, action: #selector(resetSharesCount), for: .touchUpInside)
        self.saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }

    @objc func saveTapped() {
        guard let navigationController = self.navigationController else { return }

        let sharesToSave = viewModel?.filteredShareItems.filter { $0.sharesCount > 0 } ?? []

        let totalCost = sharesToSave.reduce(0) { $0 + ($1.balance * $1.sharesCount) }

        let userBalance = self.homeView.getBalance()

        if totalCost > userBalance {
            showInsufficientFundsAlert()
            return
        }

        let newBalance = userBalance - totalCost
        self.viewModel?.balance = "\(newBalance)"

        sharesToSave.forEach { viewModel?.addShare($0) }

        navigationController.popViewController(animated: true)
    }

    func showInsufficientFundsAlert() {
        let alert = UIAlertController(title: "Insufficient Funds",
                                      message: "You don’t have enough balance to complete this purchase.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @objc func resetSharesCount() {
        self.collectionView.reloadData()
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }

        navigationController.popViewController(animated: true)
    }
}

extension CollectViewController: IViewModelableController {
    typealias ViewModel = ICollectViewModel
}

//MARK: Collection view delegate
extension CollectViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.filteredShareItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ShareCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        if var model = self.viewModel?.filteredShareItems[indexPath.row] {
            cell.setup(with: model)

            cell.deleteSubject.sink { _ in
                model.sharesCount = cell.minusSharesCount()
            }.store(in: &cell.cancellables)

            cell.sumSubject.sink { _ in
                model.sharesCount =  cell.plusSharesCount()
            }.store(in: &cell.cancellables)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 58)
    }
}

//MARK: UISearchBarDelegate
extension CollectViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterShares(with: searchText)
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.filterShares(with: "")
        collectionView.reloadData()
    }
}

//MARK: UIGesture & cell's touches
extension CollectViewController: UITextFieldDelegate, UITextViewDelegate {

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

struct CollectViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let collectViewController = CollectViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<CollectViewControllerProvider.ContainerView>) -> CollectViewController {
            return collectViewController
        }

        func updateUIViewController(_ uiViewController: CollectViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<CollectViewControllerProvider.ContainerView>) {
        }
    }
}
