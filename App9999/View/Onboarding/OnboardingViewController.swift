//
//  OnboardingViewController.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import UIKit
import App9999ViewModel
import SnapKit
import StoreKit

class OnboardingViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let background = UIImageView(image: UIImage(named: "firstBackground"))
    private let header = UILabel(text: "Unknown",
                                 textColor: .white,
                                 font: UIFont(name: "Nunito-Bold", size: 36))
    private let text = UILabel(text: "Unknown",
                               textColor: .white,
                               font: UIFont(name: "Nunito-Bold", size: 16))
    private let midImage = UIImageView(image: UIImage(named: "midImage"))
    var collectionView: UICollectionView!
    private let nextButton = UIButton(type: .system)
    private var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.nextButton.setTitle("Continue", for: .normal)
        self.nextButton.setTitleColor(.black, for: .normal)
        self.nextButton.layer.cornerRadius = 16
        self.nextButton.layer.masksToBounds = true
        self.nextButton.titleLabel?.font = UIFont(name: "Nunito-Bold", size: 16)
        self.nextButton.backgroundColor = .white

        self.header.textAlignment = .left
        self.header.numberOfLines = 3
        self.header.lineBreakMode = .byWordWrapping

        self.text.textAlignment = .left
        self.text.numberOfLines = 0

        let mylayout = UICollectionViewFlowLayout()
        mylayout.itemSize = sizeForItem()
        mylayout.scrollDirection = .horizontal
        mylayout.minimumLineSpacing = 0
        mylayout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: mylayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear

        collectionView.register(OnboardingCell.self)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false

        self.text.text = """
        Our app is designed to empower you with the tools you need to succeed in the trading world. Begin your journey by exploring the key features we offer.
        """

        self.background.frame = self.view.bounds

        self.view.addSubview(background)
        self.view.addSubview(header)
        self.view.addSubview(midImage)
        self.view.addSubview(text)
        self.view.addSubview(collectionView)
        self.view.addSubview(nextButton)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel?.loadData()
        collectionView.reloadData()
    }

    func sizeForItem() -> CGSize {
        let deviceType = UIDevice.currentDeviceType

        switch deviceType {
        case .iPhone:
            let width = self.view.frame.size.width - 32
            let heightt = self.view.frame.size.height - 440
            return CGSize(width: width, height: heightt)
        case .iPad:
            let scaleFactor: CGFloat = 1.5
            let width = 550 * scaleFactor
            let height = 1100 * scaleFactor
            return CGSize(width: width, height: height)
        }
    }

    func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(73)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(82)
            view.height.equalTo(150)
        }

        midImage.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(28)
        }

        text.snp.makeConstraints { view in
            view.top.equalTo(midImage.snp.bottom).offset(35)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalTo(midImage.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview().inset(236)
        }

        nextButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(71)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(52)
        }
    }

}

//MARK: Make buttons actions
extension OnboardingViewController {
    
    private func makeButtonsAction() {
        nextButton.addTarget(self, action: #selector(nextButtonTaped), for: .touchUpInside)
    }

    @objc func nextButtonTaped() {
        guard let navigationController = self.navigationController else { return }

        let numberOfItems = self.collectionView.numberOfItems(inSection: 0)
        let nextRow = self.currentIndex + 1

        if nextRow < numberOfItems {
            let nextIndexPath = IndexPath(item: nextRow, section: 0)
            self.collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            self.currentIndex = nextRow
            self.text.isHidden = true
        } else {
            OnboardingRouter.showBalanceController(in: navigationController)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleItems = collectionView.indexPathsForVisibleItems.sorted()
        if let visibleItem = visibleItems.first {
            currentIndex = visibleItem.item
        }
    }
}

extension OnboardingViewController: IViewModelableController {
    typealias ViewModel = IOnboardingViewModel
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel?.onboardingItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OnboardingCell = collectionView.dequeueReusableCell(for: indexPath)
        self.header.text = viewModel?.onboardingItems[indexPath.row].header
        cell.setup(image: viewModel?.onboardingItems[indexPath.row].image ?? "")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

//MARK: Preview
import SwiftUI

struct OnboardingViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let onboardingViewController = OnboardingViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) -> OnboardingViewController {
            return onboardingViewController
        }

        func updateUIViewController(_ uiViewController: OnboardingViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) {
        }
    }
}
