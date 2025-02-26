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
import App9999Model

class ProfitViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?
    private let topView = UIView()
    private let titleLabel = UILabel(text: "Profitability",
                                     textColor: .white,
                                     font: UIFont(name: "Nunito-Bold", size: 32))
    private let portfolio = UILabel(text: "Portfolio",
                                    textColor: UIColor(hex: "#9F9F9F")!,
                                    font: UIFont(name: "Nunito-Regular", size: 16))
    private let editShares = UIButton(type: .system)
    var dateCollectionView: UICollectionView!
    private let collectionData = ["1 M", "1 Y", "2 Y", "3 Y", "4 Y", "5 Y"]
    var sharesCollectionView: UICollectionView!
    private let firstLine = UIView()
    private let secondLine = UIView()
    private let wasSpent = UILabel(text: "Was spent",
                                   textColor: UIColor.white,
                                   font: UIFont(name: "Nunito-Regular", size: 14))
    private let amountAfterFive = UILabel(text: "Amount after 5 years",
                                          textColor: UIColor.white,
                                          font: UIFont(name: "Nunito-Regular", size: 14))
    private let myProfit = UILabel(text: "My profit",
                                   textColor: UIColor.white,
                                   font: UIFont(name: "Nunito-Regular", size: 14))
    private let wasSpentCount = UILabel(text: "0 $",
                                        textColor: UIColor.white,
                                        font: UIFont(name: "Nunito-Bold", size: 14))
    private let amountAfterFiveCount = UILabel(text: "0 $",
                                               textColor: UIColor.white,
                                               font: UIFont(name: "Nunito-Bold", size: 14))
    private let myProfitCount = UILabel(text: "0$ ",
                                        textColor: UIColor(hex: "#8AF835")!,
                                        font: UIFont(name: "Nunito-Bold", size: 14))
    private var selectedIndex: IndexPath = IndexPath(item: 0, section: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.loadShares()
        self.sharesCollectionView.reloadData()
        guard let shares = self.viewModel?.savedShares else { return }
        let result = self.calculateShareStatistics(shares: shares)
        self.wasSpentCount.text = "\(Int(result.totalBalance)) $"
        self.amountAfterFiveCount.text = "\(Int(result.futureBalance)) $"
        self.myProfitCount.text = "\(Int(result.profit)) $"
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

        self.portfolio.textAlignment = .left
        self.editShares.setImage(UIImage(named: "editButton"), for: .normal)

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 37)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8

        dateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        dateCollectionView.showsHorizontalScrollIndicator = false
        dateCollectionView.backgroundColor = .clear

        dateCollectionView.register(DateCollectionViewCell.self)
        dateCollectionView.backgroundColor = .clear
        dateCollectionView.isScrollEnabled = true

        dateCollectionView.delegate = self
        dateCollectionView.dataSource = self

        let mylayout = UICollectionViewFlowLayout()
        mylayout.scrollDirection = .vertical

        sharesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: mylayout)
        sharesCollectionView.showsVerticalScrollIndicator = false
        sharesCollectionView.backgroundColor = .clear
        sharesCollectionView.isScrollEnabled = true

        sharesCollectionView.register(PortfolioCollectionViewCell.self)
        sharesCollectionView.register(EmptyCollectionViewCelll.self)
        sharesCollectionView.backgroundColor = .clear

        sharesCollectionView.delegate = self
        sharesCollectionView.dataSource = self

        self.firstLine.backgroundColor = UIColor(hex: "#484444")
        self.secondLine.backgroundColor = UIColor(hex: "#484444")

        self.wasSpent.textAlignment = .left
        self.amountAfterFive.textAlignment = .left
        self.myProfit.textAlignment = .left

        self.wasSpentCount.textAlignment = .right
        self.amountAfterFiveCount.textAlignment = .right
        self.myProfitCount.textAlignment = .right

        self.view.addSubview(topView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(portfolio)
        self.view.addSubview(editShares)
        self.view.addSubview(dateCollectionView)
        self.view.addSubview(sharesCollectionView)
        self.view.addSubview(firstLine)
        self.view.addSubview(wasSpent)
        self.view.addSubview(amountAfterFive)
        self.view.addSubview(myProfit)
        self.view.addSubview(wasSpentCount)
        self.view.addSubview(amountAfterFiveCount)
        self.view.addSubview(myProfitCount)
        self.view.addSubview(secondLine)
        setupConstraints()
        setupViewTapHandling()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadShares()
        self.sharesCollectionView.reloadData()
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

        portfolio.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(132)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(24)
        }

        editShares.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(132)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(24)
            view.width.equalTo(24)
        }

        dateCollectionView.snp.makeConstraints { view in
            view.top.equalTo(portfolio.snp.bottom).offset(24)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(37)
        }

        sharesCollectionView.snp.makeConstraints { view in
            view.top.equalTo(dateCollectionView.snp.bottom).offset(24)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview().inset(384)
        }

        firstLine.snp.makeConstraints { view in
            view.top.equalTo(sharesCollectionView.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(1)
        }

        wasSpent.snp.makeConstraints { view in
            view.top.equalTo(firstLine.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(19)
        }

        amountAfterFive.snp.makeConstraints { view in
            view.top.equalTo(wasSpent.snp.bottom).offset(9)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(19)
        }

        myProfit.snp.makeConstraints { view in
            view.top.equalTo(amountAfterFive.snp.bottom).offset(9)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(19)
        }

        wasSpentCount.snp.makeConstraints { view in
            view.centerY.equalTo(wasSpent.snp.centerY)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(19)
        }

        amountAfterFiveCount.snp.makeConstraints { view in
            view.centerY.equalTo(amountAfterFive.snp.centerY)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(19)
        }

        myProfitCount.snp.makeConstraints { view in
            view.centerY.equalTo(myProfit.snp.centerY)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(19)
        }

        secondLine.snp.makeConstraints { view in
            view.top.equalTo(myProfitCount.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(1)
        }
    }

}

//MARK: Make buttons actions
extension ProfitViewController {
    
    private func makeButtonsAction() {
        self.editShares.addTarget(self, action: #selector(editSharesTapped), for: .touchUpInside)
    }

    @objc func editSharesTapped() {
        guard let navigationController = self.navigationController else { return }

        ProfitRouter.showCollectController(in: navigationController)
    }

    func calculateShareStatistics(shares: [SharePresentationModel]) -> (totalBalance: Double, totalPercentage: Double, futureBalance: Double, profit: Double) {
        let totalBalance = shares.reduce(0) { $0 + Double($1.balance) }
        let totalPercentage = shares.reduce(0) { $0 + $1.procient }

        let years = 5
        let monthsPerYear = 12

        var futureBalance = 0.0

        for share in shares {
            let P = Double(share.balance)
            let r = share.procient / 100.0
            let A = P * pow((1 + r / Double(monthsPerYear)), Double(monthsPerYear * years))
            futureBalance += A
        }

        let profit = futureBalance - totalBalance

        return (totalBalance, totalPercentage, futureBalance, profit)
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

//MARK: CollectionView delegate
extension ProfitViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dateCollectionView {
            return self.collectionData.count
        } else {
            return self.viewModel?.savedShares.isEmpty ?? true ? 1 : self.viewModel!.savedShares.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dateCollectionView {
            let cell: DateCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

            cell.layer.borderWidth = indexPath == selectedIndex ? 2 : 1
            cell.layer.borderColor = indexPath == selectedIndex ? UIColor.white.cgColor : UIColor(hex: "#484444")?.cgColor
            cell.layer.cornerRadius = 8

            cell.setup(with: self.collectionData[indexPath.row])

            return cell
        } else {
            if self.viewModel?.savedShares.isEmpty ?? true {

                self.dateCollectionView.isHidden = true
                self.editShares.isHidden = true

                let cell: EmptyCollectionViewCelll = collectionView.dequeueReusableCell(for: indexPath)

                cell.addSubject.sink { [weak self] _ in
                    self?.editSharesTapped()
                }.store(in: &cell.cancellables)

                return cell
            } else {
                self.dateCollectionView.isHidden = false
                self.editShares.isHidden = false

                let cell: PortfolioCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                if let model = self.viewModel?.savedShares[indexPath.row] {
                    let yearMultipliers = [1, 12, 24, 36, 48, 60]
                    let selectedMultiplier = yearMultipliers[selectedIndex.row]

                    let adjustedPercentage = Float(model.procient) * Float(selectedMultiplier)

                    cell.configure(with: model.name, percentage: adjustedPercentage)
                }
                return cell
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == dateCollectionView {
            return CGSize(width: 50, height: 37)
        } else {
            if self.viewModel?.savedShares.isEmpty ?? true {
                return CGSize(width: collectionView.frame.width / 2, height: 100)
            } else {
                return CGSize(width: collectionView.frame.width, height: 31)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == dateCollectionView {
            selectedIndex = indexPath
            dateCollectionView.reloadData()
            sharesCollectionView.reloadData()
        }
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
