//
//  HomeView.swift
//  App9999
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import UIKit

class HomeView: UIView {

    private let balance = UILabel(text: "",
                                  textColor: UIColor.white,
                                  font: UIFont(name: "Nunito-Bold", size: 32))

    private let name = UILabel(text: "Wallet",
                               textColor: UIColor(hex: "#9F9F9F")!,
                               font: UIFont(name: "Nunito-Regular", size: 16))

    let bottomLine = UIView()

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {

        self.backgroundColor = UIColor.clear

        self.balance.textAlignment = .left
        self.name.textAlignment = .left

        self.bottomLine.backgroundColor = UIColor(hex: "#484444")

        self.addSubview(name)
        self.addSubview(balance)
        self.addSubview(bottomLine)
        setupConstraints()
    }

    private func setupConstraints() {
        name.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview().inset(64)
            view.height.equalTo(24)
        }

        balance.snp.makeConstraints { view in
            view.top.equalTo(name.snp.bottom).offset(8)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview().inset(64)
            view.height.equalTo(44)
        }

        bottomLine.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(1)
        }
    }

    func changeBalance(balance: String) {
        self.balance.text = balance
    }
}
