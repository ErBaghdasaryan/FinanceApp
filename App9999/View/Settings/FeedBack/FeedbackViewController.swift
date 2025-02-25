//
//  FeedbackViewController.swift
//  App9999
//
//  Created by Er Baghdasaryan on 26.02.25.
//

import UIKit
import WebKit
import SnapKit

final class FeedbackViewController: BaseViewController {

    private let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        view.backgroundColor = .white
        self.title = "Feedback"
        self.navigationController?.navigationBar.tintColor = .black
        self.webView.backgroundColor = .clear
        if let url = URL(string: "https://www.termsfeed.com/live/87a1ed10-b693-4c21-b95f-caaf3e3f7966") {
            webView.load(URLRequest(url: url))
        }

        setupConstraints()
    }

    private func setupConstraints() {
        self.view.addSubview(webView)

        webView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
        }
    }

    override func setupViewModel() {

    }

}

import SwiftUI

struct FeedbackViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let feedbackViewController = FeedbackViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<FeedbackViewControllerProvider.ContainerView>) -> FeedbackViewController {
            return feedbackViewController
        }

        func updateUIViewController(_ uiViewController: FeedbackViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<FeedbackViewControllerProvider.ContainerView>) {
        }
    }
}
