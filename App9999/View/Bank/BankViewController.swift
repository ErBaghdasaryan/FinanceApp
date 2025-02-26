//
//  BankViewController.swift
//  App9999
//
//  Created by Er Baghdasaryan on 22.02.25.
//

import UIKit
import App9999ViewModel
import SnapKit

class BankViewController: BaseViewController {

    var viewModel: ViewModel?
    private let topView = UIView()
    private let titleLabel = UILabel(text: "My piggy bank",
                                     textColor: .white,
                                     font: UIFont(name: "Nunito-Bold", size: 32))
    private let replenishment = UILabel(text: "Replenishment history",
                                        textColor: UIColor(hex: "#9F9F9F")!,
                                        font: UIFont(name: "Nunito-Regular", size: 16))
    private let piggy = UILabel(text: "Piggy bank settings",
                                textColor: UIColor(hex: "#9F9F9F")!,
                                font: UIFont(name: "Nunito-Regular", size: 16))
    private let minimum = CustomTextField(placeholder: "Min", rightText: "10 $")
    private let maximum = CustomTextField(placeholder: "Max", rightText: "45 $")
    private var balanceStack: UIStackView!
    private let randomize = UIButton(type: .system)
    private let firstReplenishment = ReplenishmentView(type: .first, isFirst: true)
    private let secondReplenishment = ReplenishmentView(type: .second)
    private let thirdReplenishment = ReplenishmentView(type: .first)
    private let fourthReplenishment = ReplenishmentView(type: .second)
    private let totalReplenishment = ReplenishmentView(type: .total, isSecond: true)
    private var replenishmentStack: UIStackView!

    private var randomValue: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#252121")

        self.titleLabel.textAlignment = .left
        self.topView.backgroundColor = UIColor(hex: "#171416")

        self.topView.layer.masksToBounds = true
        self.topView.layer.cornerRadius = 16
        self.topView.layer.maskedCorners = [.layerMinXMaxYCorner,
            .layerMaxXMaxYCorner]

        self.replenishment.textAlignment = .left
        self.piggy.textAlignment = .left

        self.balanceStack = UIStackView(arrangedSubviews: [minimum, maximum],
                                        axis: .horizontal,
                                        spacing: 8)
        self.balanceStack.distribution = .fillEqually

        self.randomize.setTitle("Randomize", for: .normal)
        self.randomize.setTitleColor(.black, for: .normal)
        self.randomize.layer.masksToBounds = true
        self.randomize.layer.cornerRadius = 16
        self.randomize.backgroundColor = .white

        let lastFourDays = generateLastFourDays()
        self.firstReplenishment.setDate(date: lastFourDays[0])
        self.secondReplenishment.setDate(date: lastFourDays[1])
        self.thirdReplenishment.setDate(date: lastFourDays[2])
        self.fourthReplenishment.setDate(date: lastFourDays[3])
        self.totalReplenishment.setDate(date: "Total")
        self.firstReplenishment.setBalance(count: "0")
        self.secondReplenishment.setBalance(count: "0")
        self.thirdReplenishment.setBalance(count: "0")
        self.fourthReplenishment.setBalance(count: "0")
        self.totalReplenishment.setBalance(count: "0")

        self.replenishmentStack = UIStackView(arrangedSubviews: [firstReplenishment,
                                                                 secondReplenishment,
                                                                 thirdReplenishment,
                                                                 fourthReplenishment,
                                                                 totalReplenishment],
                                              axis: .vertical,
                                              spacing: 0)
        self.replenishmentStack.distribution = .fillEqually

        self.view.addSubview(topView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(replenishment)
        self.view.addSubview(piggy)
        self.view.addSubview(balanceStack)
        self.view.addSubview(randomize)
        self.view.addSubview(replenishmentStack)
        setupConstraints()
        setupViewTapHandling()
        setupTextFieldDelegates()
    }

    override func setupViewModel() {
        super.setupViewModel()

        viewModel?.activateSuccessSubject.sink { [weak self] boolValue in
            guard let self = self else { return }
            if boolValue {
                self.fourthReplenishment.setBalance(count: "\(self.randomValue)")
                self.totalReplenishment.setBalance(count: "\(self.randomValue)")
            }
        }.store(in: &cancellables)
    }

    func setupConstraints() {
        topView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(116)
        }

        titleLabel.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(58)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(48)
        }

        replenishment.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(132)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(24)
        }

        piggy.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(371)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(24)
        }

        balanceStack.snp.makeConstraints { view in
            view.top.equalTo(piggy.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(56)
        }

        randomize.snp.makeConstraints { view in
            view.top.equalTo(balanceStack.snp.bottom).offset(24)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(52)
        }

        replenishmentStack.snp.makeConstraints { view in
            view.top.equalTo(replenishment.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(175)
        }
    }

}

//MARK: Make buttons actions
extension BankViewController {
    
    private func makeButtonsAction() {
        randomize.addTarget(self, action: #selector(randomizeTapped), for: .touchUpInside)
    }

    @objc func randomizeTapped() {
        guard let navigationController = navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }
        guard let minText = self.minimum.text, let minValue = Int(minText) else { return }
        guard let maxText = self.maximum.text, let maxValue = Int(maxText) else { return }

        guard minValue <= maxValue else {
            self.showAlert()
            return
        }

        let randomValue = Int.random(in: minValue...maxValue)
        self.randomValue = randomValue

        BankRouter.showPutViewController(in: navigationController,
                                         navigationModel: .init(activateSuccessSubject: subject,
                                                                count: randomValue))
    }

    private func showAlert() {
        let alert = UIAlertController(title: "The minimum number is greater than the maximum",
                                      message: "Please enter the numbers correctly so that we can perform the correct calculation..",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func generateLastFourDays() -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"

        let calendar = Calendar.current
        var dates: [String] = []

        for i in (0...4).reversed() {
            if let date = calendar.date(byAdding: .day, value: -i, to: Date()) {
                dates.append(dateFormatter.string(from: date))
            }
        }

        return dates
    }
}

extension BankViewController: IViewModelableController {
    typealias ViewModel = IBankViewModel
}

//MARK: UIGesture & cell's touches
extension BankViewController: UITextFieldDelegate, UITextViewDelegate {

    private func setupTextFieldDelegates() {
        self.minimum.delegate = self
        self.maximum.delegate = self

        self.minimum.keyboardType = .numberPad
        self.maximum.keyboardType = .numberPad
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.minimum:
            self.maximum.becomeFirstResponder()
        case self.maximum:
            self.maximum.resignFirstResponder()
        default:
            break
        }
        return true
    }

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    private func setupViewTapHandling() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
}

//MARK: Preview
import SwiftUI

struct BankViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let bankViewController = BankViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<BankViewControllerProvider.ContainerView>) -> BankViewController {
            return bankViewController
        }

        func updateUIViewController(_ uiViewController: BankViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<BankViewControllerProvider.ContainerView>) {
        }
    }
}
