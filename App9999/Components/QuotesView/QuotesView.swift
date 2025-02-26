//
//  QuotesView.swift
//  App9999
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import UIKit

class QuotesView: UIView {

    let textHeader = UILabel(text: "",
                                    textColor: UIColor(hex: "#E2E2E2")!,
                                    font: UIFont(name: "Nunito-Bold", size: 14))

    private let name = UILabel(text: "",
                               textColor: UIColor(hex: "#E2E2E2")!,
                               font: UIFont(name: "NunitoItalic-Regular", size: 14))

    let bottomLine = UIView()

    init(name: String, text: String) {
        super.init(frame: .zero)
        textHeader.text = text
        self.name.text = name
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {

        self.backgroundColor = UIColor.clear

        self.textHeader.textAlignment = .left
        self.textHeader.numberOfLines = 0
        self.textHeader.lineBreakMode = .byWordWrapping
        self.name.textAlignment = .left

        self.bottomLine.backgroundColor = UIColor(hex: "#484444")

        self.addSubview(textHeader)
        self.addSubview(name)
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
            view.height.equalTo(21)
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

    func getName() -> String {
        return self.name.text ?? ""
    }

    func getText() -> String {
        return self.textHeader.text ?? ""
    }
}
