//
//  ShareCollectionViewCell.swift
//  App9999
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import UIKit
import Combine
import App9999Model

class ShareCollectionViewCell: UICollectionViewCell, IReusableView {

    private let image = UIImageView()
    private let name = UILabel(text: "",
                               textColor: UIColor.white,
                               font: UIFont(name: "Nunito-Regular", size: 14))

    private let balance = UILabel(text: "",
                                  textColor: UIColor.white,
                                  font: UIFont(name: "Nunito-Bold", size: 16))
    private let procient = UILabel(text: "",
                                   textColor: UIColor(hex: "#8AF835")!,
                                   font: UIFont(name: "Nunito-Bold", size: 12))

    private let sum = UIButton(type: .system)
    private let delete = UIButton(type: .system)
    private let shareCount = UILabel(text: "0",
                                     textColor: UIColor.white,
                                     font: UIFont(name: "Nunito-Regular", size: 14))
    private var buttonsStack: UIStackView!
    let bottomLine = UIView()

    private var shareCountInt: Int = 0 {
        willSet {
            self.shareCount.text = "\(newValue)"
        }
    }

    public var sumSubject = PassthroughSubject<Bool, Never>()
    public var deleteSubject = PassthroughSubject<Bool, Never>()
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

        self.name.textAlignment = .left
        self.balance.textAlignment = .right
        self.procient.textAlignment = .right

        self.image.layer.masksToBounds = true
        self.image.layer.cornerRadius = 20
        self.image.contentMode = .scaleAspectFill

        self.bottomLine.backgroundColor = UIColor(hex: "#484444")

        self.sum.setImage(UIImage(named: "plus"), for: .normal)
        self.delete.setImage(UIImage(named: "minus"), for: .normal)

        self.buttonsStack = UIStackView(arrangedSubviews: [delete, shareCount, sum],
                                        axis: .horizontal,
                                        spacing: 0)
        buttonsStack.distribution = .fillEqually

        self.addSubview(image)
        self.addSubview(name)
        self.addSubview(balance)
        self.addSubview(procient)
        self.addSubview(buttonsStack)
        self.addSubview(bottomLine)
        setupConstraints()
    }

    private func setupConstraints() {
        image.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(9)
            view.leading.equalToSuperview()
            view.height.equalTo(40)
            view.width.equalTo(40)
        }

        name.snp.makeConstraints { view in
            view.centerY.equalTo(image.snp.centerY)
            view.leading.equalTo(image.snp.trailing).offset(8)
            view.trailing.equalToSuperview().inset(200)
            view.height.equalTo(20)
        }

        balance.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(8)
            view.leading.equalToSuperview().offset(50)
            view.trailing.equalToSuperview().inset(105)
            view.height.equalTo(22)
        }

        procient.snp.makeConstraints { view in
            view.top.equalTo(balance.snp.bottom).offset(4)
            view.leading.equalToSuperview().offset(50)
            view.trailing.equalToSuperview().inset(105)
            view.height.equalTo(16)
        }

        buttonsStack.snp.makeConstraints { view in
            view.centerY.equalTo(image.snp.centerY)
            view.leading.equalTo(balance.snp.trailing).offset(24)
            view.trailing.equalToSuperview()
            view.height.equalTo(24)
        }

        bottomLine.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(1)
        }
    }

    func setup(with model: SharePresentationModel) {
        self.image.image = UIImage(named: model.imageName)
        self.name.text = model.name
        self.balance.text = "\(model.balance)$"
        self.procient.text = "+\(model.procient)%"
        self.shareCountInt = model.sharesCount
    }

    func plusSharesCount() {
        if shareCountInt == 99 {
            self.shareCountInt = 0
        } else {
            self.shareCountInt += 1
        }
    }

    func minusSharesCount() {
        if shareCountInt > 0 {
            self.shareCountInt -= 1
        } else if shareCountInt == 0 {
            self.shareCountInt = 99
        }
    }

    func resetCount() {
        self.shareCountInt = 0
    }
}

extension ShareCollectionViewCell {
    private func makeButtonActions() {
        self.sum.addTarget(self, action: #selector(sumTapped), for: .touchUpInside)
        self.delete.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }

    @objc func sumTapped() {
        self.sumSubject.send(true)
    }

    @objc func deleteTapped() {
        self.deleteSubject.send(true)
    }
}
