//
//  PortfolioCollectionViewCell.swift
//  App9999
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import UIKit
import Combine
import App9999Model

class PortfolioCollectionViewCell: UICollectionViewCell, IReusableView {

    private let nameLabel = UILabel(text: "",
                                    textColor: .white,
                                    font: UIFont(name: "Nunito-Regular", size: 14)!)

    private let percentageLabel = UILabel(text: "",
                                          textColor: .white,
                                          font: UIFont(name: "Nunito-Bold", size: 14)!)

    private let progressView = UIProgressView(progressViewStyle: .default)

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

        progressView.trackTintColor = UIColor.white.withAlphaComponent(0.08)
        progressView.progressTintColor = UIColor(hex: "#5BA314")
        progressView.layer.masksToBounds = true
        progressView.layer.cornerRadius = 4

        self.nameLabel.textAlignment = .left
        self.percentageLabel.textAlignment = .right

        self.addSubview(nameLabel)
        self.addSubview(percentageLabel)
        self.addSubview(progressView)
        setupConstraints()
    }

    private func setupConstraints() {
        nameLabel.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview().inset(60)
            view.height.equalTo(20)
        }

        percentageLabel.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview().offset(60)
            view.trailing.equalToSuperview()
            view.height.equalTo(20)
        }

        progressView.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(8)
        }
    }

    func configure(with name: String, percentage: Float) {
        nameLabel.text = name
        percentageLabel.text = "\(Int(percentage))%"
        progressView.progress = percentage / 100
    }
}
