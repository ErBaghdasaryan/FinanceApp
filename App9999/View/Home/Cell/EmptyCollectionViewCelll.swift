//
//  EmptyCollectionViewCelll.swift
//  App9999
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import UIKit
import Combine
import App9999Model

class EmptyCollectionViewCelll: UICollectionViewCell, IReusableView {

    private let empty = UILabel(text: "Add shares",
                               textColor: UIColor.white,
                               font: UIFont(name: "Nunito-Regular", size: 16))
    private let addButton = UIButton(type: .system)
    public var addSubject = PassthroughSubject<Bool, Never>()
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

        self.addButton.setImage(UIImage(named: "addShare"), for: .normal)

        self.addSubview(empty)
        self.addSubview(addButton)
        setupConstraints()
    }

    private func setupConstraints() {
        empty.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(22)
        }

        addButton.snp.makeConstraints { view in
            view.top.equalTo(empty.snp.bottom).offset(16)
            view.centerX.equalToSuperview()
            view.width.equalTo(60)
            view.height.equalTo(60)
        }
    }
}

extension EmptyCollectionViewCelll {
    private func makeButtonActions() {
        self.addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }

    @objc func addTapped() {
        self.addSubject.send(true)
    }
}
