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
    private let today = UILabel(text: "Today",
                                textColor: UIColor(hex: "#9F9F9F")!,
                                font: UIFont(name: "Nunito-Regular", size: 16))
    private let quotesView = QuotesView(name: "Bill Gates",
                                        text: "When you have money in your hands, only you forget who you are. But when you don't have money in your hands, everyone forgets who you are. That's life.")
    private let share = UIButton(type: .system)
    private let like = UIButton(type: .system)
    private var buttonsStack: UIStackView!

    private var isLike: Bool = false {
        willSet {
            if newValue {
                self.like.setImage(UIImage(named: "like1"), for: .normal)
            } else {
                self.like.setImage(UIImage(named: "like"), for: .normal)
            }
        }
    }

    private let saved = UILabel(text: "Saved",
                                textColor: UIColor(hex: "#9F9F9F")!,
                                font: UIFont(name: "Nunito-Regular", size: 16))
    private var quoteTimer: Timer?
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
        startQuoteTimer()
    }

    deinit {
        quoteTimer?.invalidate()
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

        self.today.textAlignment = .left
        self.saved.textAlignment = .left

        self.share.setImage(UIImage(named: "share"), for: .normal)
        self.like.setImage(UIImage(named: "like"), for: .normal)

        self.buttonsStack = UIStackView(arrangedSubviews: [share, like],
                                        axis: .horizontal,
                                        spacing: 16)

        let mylayout = UICollectionViewFlowLayout()
        mylayout.scrollDirection = .vertical
        mylayout.minimumLineSpacing = 16
        mylayout.minimumInteritemSpacing = 16

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: mylayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear

        collectionView.register(QuoteCollectionViewCell.self)
        collectionView.backgroundColor = .clear

        collectionView.delegate = self
        collectionView.dataSource = self

        self.view.addSubview(topView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(today)
        self.view.addSubview(quotesView)
        self.view.addSubview(buttonsStack)
        self.view.addSubview(saved)
        self.view.addSubview(collectionView)
        setupConstraints()
        setupViewTapHandling()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadQuotes()
        self.viewModel?.loadFavoriteQuotes()
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
            view.trailing.equalToSuperview().offset(16)
            view.height.equalTo(48)
        }

        today.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(132)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(24)
        }

        quotesView.snp.makeConstraints { view in
            view.top.equalTo(today.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
        }

        buttonsStack.snp.makeConstraints { view in
            view.top.equalTo(quotesView.textHeader.snp.bottom).offset(12)
            view.trailing.equalTo(quotesView.snp.trailing)
            view.height.equalTo(24)
            view.width.equalTo(64)
        }

        saved.snp.makeConstraints { view in
            view.top.equalTo(quotesView.bottomLine.snp.bottom).offset(24)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(24)
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalTo(saved.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }
    }

}

//MARK: Make buttons actions
extension QuotesViewController {
    
    private func makeButtonsAction() {
        self.like.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        self.share.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
    }

    private func startQuoteTimer() {
        quoteTimer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(updateRandomQuote), userInfo: nil, repeats: true)
    }

    @objc private func updateRandomQuote() {
        guard let quotes = viewModel?.quotesItems, !quotes.isEmpty else { return }
        let randomQuote = quotes.randomElement()!
        quotesView.changeNameAndQuota(name: randomQuote.name, text: randomQuote.text)
        self.isLike = randomQuote.isFavorite ?? false
    }

    @objc func likeTapped() {
        if self.isLike {
            self.isLike = false
        } else {
            self.isLike = true
            let name = self.quotesView.getName()
            let text = self.quotesView.getText()
            self.viewModel?.addQuote(.init(name: name, text: text))
            self.viewModel?.loadFavoriteQuotes()
            self.collectionView.reloadData()
        }
    }

    private func deleteElement(by ID: Int) {
        self.viewModel?.deleteQuote(by: ID)
        self.viewModel?.loadFavoriteQuotes()
        self.collectionView.reloadData()
    }

    @objc func shareTapped() {
        guard let text = self.quotesView.textHeader.text else { return }
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)

        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(activityViewController, animated: true)
    }

    private func shareCollectionElement(with text: String) {
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)

        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(activityViewController, animated: true)
    }
}

extension QuotesViewController: IViewModelableController {
    typealias ViewModel = IQuotesViewModel
}

extension QuotesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.viewModel?.savedQuotes.isEmpty ?? true {
            self.saved.isHidden = true
        } else {
            self.saved.isHidden = false
        }
        return self.viewModel?.savedQuotes.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: QuoteCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.changeNameAndQuota(name: viewModel?.savedQuotes[indexPath.row].name ?? "",
                                text: viewModel?.savedQuotes[indexPath.row].text ?? "")

        cell.shareSubject.sink { [weak self] _ in
            if let model = self?.viewModel?.savedQuotes[indexPath.row] {
                self?.shareCollectionElement(with: model.text)
            }
        }.store(in: &cell.cancellables)

        cell.likeSubject.sink { [weak self] _ in
            if let model = self?.viewModel?.savedQuotes[indexPath.row] {
                self?.deleteElement(by: model.id!)
            }
        }.store(in: &cell.cancellables)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width

        let cellWidth = availableWidth
        let label = UILabel()
        label.text = viewModel?.savedQuotes[indexPath.row].text ?? ""
        label.font = UIFont(name: "Nunito-Bold", size: 14)
        label.numberOfLines = 0

        let maxSize = CGSize(width: cellWidth, height: CGFloat.greatestFiniteMagnitude)
        let size = label.sizeThatFits(maxSize)

        return CGSize(width: cellWidth, height: size.height + 48)
    }

}

//MARK: UIGesture & cell's touches
extension QuotesViewController: UITextFieldDelegate, UITextViewDelegate {

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
