//
//  QuoteCollectionViewCell.swift
//  App9999
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import UIKit
import Combine

class QuoteCollectionViewCell: UICollectionViewCell, IReusableView {

    let textHeader = UILabel(text: "",
                                    textColor: UIColor(hex: "#E2E2E2")!,
                                    font: UIFont(name: "Nunito-Bold", size: 14))

    private let name = UILabel(text: "",
                               textColor: UIColor(hex: "#E2E2E2")!,
                               font: UIFont(name: "NunitoItalic-Regular", size: 14))
    private let share = UIButton(type: .system)
    private let like = UIButton(type: .system)
    private var buttonsStack: UIStackView!
    let bottomLine = UIView()

    public var shareSubject = PassthroughSubject<Bool, Never>()
    public var likeSubject = PassthroughSubject<Bool, Never>()
    var cancellables = Set<AnyCancellable>()

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        makeButtonActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        makeButtonActions()
    }

    private func setupUI() {

        self.backgroundColor = UIColor.clear

        self.textHeader.textAlignment = .left
        self.textHeader.numberOfLines = 0
        self.textHeader.lineBreakMode = .byWordWrapping
        textHeader.setContentHuggingPriority(.required, for: .vertical)
        textHeader.setContentCompressionResistancePriority(.required, for: .vertical)
        self.name.textAlignment = .left
        name.setContentHuggingPriority(.defaultHigh, for: .vertical)
        name.setContentCompressionResistancePriority(.required, for: .vertical)

        self.bottomLine.backgroundColor = UIColor(hex: "#484444")

        self.share.setImage(UIImage(named: "share"), for: .normal)
        self.like.setImage(UIImage(named: "like1"), for: .normal)

        self.buttonsStack = UIStackView(arrangedSubviews: [share, like],
                                        axis: .horizontal,
                                        spacing: 16)
        buttonsStack.setContentHuggingPriority(.defaultLow, for: .vertical)

        self.addSubview(textHeader)
        self.addSubview(name)
        self.addSubview(buttonsStack)
        self.addSubview(bottomLine)
        setupConstraints()
    }

    private func setupConstraints() {
        textHeader.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
        }

        name.snp.makeConstraints { view in
            view.top.equalTo(textHeader.snp.bottom).offset(12)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview().inset(64)
        }

        buttonsStack.snp.makeConstraints { view in
            view.top.equalTo(textHeader.snp.bottom).offset(12)
            view.trailing.equalToSuperview()
            view.width.equalTo(64)
            view.height.equalTo(24)
        }

        bottomLine.snp.makeConstraints { view in
            view.top.equalTo(name.snp.bottom).offset(19)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(1)
        }
    }

    func changeNameAndQuota(name: String, text: String) {
        self.name.text = name
        self.textHeader.text = text
    }
}

extension QuoteCollectionViewCell {
    private func makeButtonActions() {
        self.like.addTarget(self, action: #selector(likButtonTapped), for: .touchUpInside)
        self.share.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }

    @objc func likButtonTapped() {
        self.likeSubject.send(true)
    }

    @objc func shareButtonTapped() {
        self.shareSubject.send(true)
    }
}
