//
//  CheckoutViewController.swift
//  MyProject
//
//  Created by shengnan liu on 19/7/20.
//  Copyright © 2020 sph. All rights reserved.
//

import UIKit

class CheckoutViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func makeUI() {
        super.makeUI()

        languageChanged.subscribe(onNext: { [weak self] () in
            self?.title = R.string.localizable.checkoutTitle.key.localized()
        }).disposed(by: rx.disposeBag)
    }
}
