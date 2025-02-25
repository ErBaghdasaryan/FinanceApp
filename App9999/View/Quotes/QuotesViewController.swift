//
//  QuotesViewController.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import UIKit
import App9999ViewModel
import SnapKit
import StoreKit

class QuotesViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?
    private let topView = UIView()
    private let titleLabel = UILabel(text: "Quotes",
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
extension QuotesViewController {
    
    private func makeButtonsAction() {

    }
}

extension QuotesViewController: IViewModelableController {
    typealias ViewModel = IQuotesViewModel
}

//MARK: Preview
import SwiftUI

struct QuotesViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let quotesViewController = QuotesViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<QuotesViewControllerProvider.ContainerView>) -> QuotesViewController {
            return quotesViewController
        }

        func updateUIViewController(_ uiViewController: QuotesViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<QuotesViewControllerProvider.ContainerView>) {
        }
    }
}
