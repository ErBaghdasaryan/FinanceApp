//
//  ReplenishmentView.swift
//  App9999
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import UIKit

class ReplenishmentView: UIView {

    private let leftText = UILabel(text: "",
                                   textColor: UIColor.white,
                                   font: UIFont(name: "Nunito-Rugular", size: 14))
    private let rightText = UILabel(text: "",
                                    textColor: UIColor.white,
                                    font: UIFont(name: "Nunito-Bold", size: 14))
    private var type: Replenishment = .first

    init(type: Replenishment, isFirst: Bool = false, isSecond: Bool = false) {
        super.init(frame: .zero)
        setupUI(type: type, isFirst: isFirst, isSecond: isSecond)
        self.type = type
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI(type: .first)
    }

    private func setupUI(type: Replenishment, isFirst: Bool = false, isSecond: Bool = false) {

        if isFirst {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 16
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if isSecond {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 16
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }

        switch type {
        case .first:
            self.backgroundColor = UIColor(hex: "#484444")
        case .second:
            self.backgroundColor = UIColor.clear
        case .total:
            self.backgroundColor = UIColor(hex: "#4A702D")
            self.leftText.font = UIFont(name: "Nunito-Bold", size: 14)
        }

        self.leftText.textAlignment = .left
        self.rightText.textAlignment = .right

        self.addSubview(leftText)
        self.addSubview(rightText)
        setupConstraints()
    }

    private func setupConstraints() {
        leftText.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(70)
            view.height.equalTo(20)
        }

        rightText.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(8)
            view.leading.equalToSuperview().offset(70)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(20)
        }
    }

    func setDate(date: String) {
        self.leftText.text = date
    }

    func setBalance(count: String) {
        if self.type == .total {
            self.rightText.text = "\(count) $"
        } else {
            self.rightText.text = "+ \(count) $"
        }
    }
}

enum Replenishment {
    case first
    case second
    case total
}
