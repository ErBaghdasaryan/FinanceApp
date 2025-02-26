//
//  DateCollectionViewCell.swift
//  App9999
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import UIKit
import Combine
import App9999Model

class DateCollectionViewCell: UICollectionViewCell, IReusableView {

    private let date = UILabel(text: "",
                               textColor: UIColor.white,
                               font: UIFont(name: "Nunito-Regular", size: 14))

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

        self.date.layer.masksToBounds = true
        self.date.layer.cornerRadius = 8
        self.date.layer.borderColor = UIColor(hex: "#484444")?.cgColor
        self.date.layer.borderWidth = 1

        self.addSubview(date)
        setupConstraints()
    }

    private func setupConstraints() {
        date.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }
    }

    func setup(with text: String) {
        self.date.text = text
    }
}
