//
//  SavedShareCollectionViewCell.swift
//  App9999
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import UIKit
import Combine
import App9999Model

class SavedShareCollectionViewCell: UICollectionViewCell, IReusableView {

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

    let bottomLine = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
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

        self.addSubview(image)
        self.addSubview(name)
        self.addSubview(balance)
        self.addSubview(procient)
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
            view.trailing.equalToSuperview()
            view.height.equalTo(22)
        }

        procient.snp.makeConstraints { view in
            view.top.equalTo(balance.snp.bottom).offset(4)
            view.leading.equalToSuperview().offset(50)
            view.trailing.equalToSuperview()
            view.height.equalTo(16)
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
        let newBalance = model.balance * model.sharesCount
        self.balance.text = "\(newBalance)$"
        self.procient.text = "+\(model.procient)%"
    }
}

