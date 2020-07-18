//
//  Application.swift
//  MyProject
//
//  Created by Liusn on 1/5/18.
//  Copyright © 2020 Liusn. All rights reserved..
//

import UIKit

final class Application: NSObject {
    static let shared = Application()

    var window: UIWindow?

    var provider: NetAPI?
    let navigator: Navigator

    private override init() {
        navigator = Navigator.default
        super.init()
        updateProvider()
    }

    private func updateProvider() {
        let myProvider = MyNetworking.stubbingNetworking()
        let restApi = RestApi(provider: myProvider)
        provider = restApi
    }

    func presentInitialScreen(in window: UIWindow?) {
        updateProvider()
        guard let window = window else { return }
        self.window = window
        presentMainScreen(in: window)
    }

    func presentMainScreen(in window: UIWindow?) {
        guard let window = window, let provider = provider else { return }
        let id = "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
        let viewModel = HomeViewModel(id: id, provider: provider)
        navigator.show(segue: .home(viewModel: viewModel), sender: nil, transition: .root(in: window))
    }
}
