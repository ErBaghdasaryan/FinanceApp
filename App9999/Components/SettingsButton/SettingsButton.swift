//
//  SettingsButton.swift
//  App9999
//
//  Created by Er Baghdasaryan on 25.02.25.
//

import UIKit
import SnapKit

class SettingsButton: UIButton {

    private let bottomView = UIView()

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
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont(name: "Nunito-Regular", size: 16)
        self.contentHorizontalAlignment = .left
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true

        self.bottomView.backgroundColor = UIColor(hex: "#484444")

        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let arrowImage = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowImage.tintColor = .white
        self.addSubview(arrowImage)
        self.addSubview(bottomView)

        arrowImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(18.75)
            make.centerY.equalToSuperview()
            make.width.equalTo(10)
            make.height.equalTo(18)
        }

        bottomView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
