//
//  CartViewController.swift
//  MyProject
//
//  Created by shengnan liu on 17/7/20.
//  Copyright © 2020 Liusn. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

private let reuseIdentifier = R.reuseIdentifier.cartItemTableViewCell.identifier

class CartViewController: TableViewController {
    lazy var button: Button = {
        let view = Button()
        view.titleForNormal = R.string.localizable.checkoutTitle.key.localized()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func makeUI() {
        super.makeUI()

        languageChanged.subscribe(onNext: { [weak self] () in
            self?.title = R.string.localizable.cartTitle.key.localized()
        }).disposed(by: rx.disposeBag)

        tableView.register(R.nib.cartItemTableViewCell)
        tableView.footRefreshControl = nil

        contentView.addSubview(button)
        button.snp.makeConstraints({ (make) in
            make.height.equalTo(44)
            make.width.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        })
    }

    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? CartViewModel else { return }

        let refresh = Observable.of(Observable.just(()), headerRefreshTrigger).merge()
        let input = CartViewModel.Input(selection: tableView.rx.modelSelected(CartItemCellViewModel.self).asDriver(),
                                        headerRefresh: refresh)
        let output = viewModel.transform(input: input)

        viewModel.loading.asObservable().bind(to: isLoading).disposed(by: rx.disposeBag)
        viewModel.headerLoading.asObservable().bind(to: isHeaderLoading).disposed(by: rx.disposeBag)
        viewModel.footerLoading.asObservable().bind(to: isFooterLoading).disposed(by: rx.disposeBag)

        output.items.asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: CartItemTableViewCell.self)) { _, viewModel, cell in
                cell.bind(to: viewModel)
        }.disposed(by: rx.disposeBag)
    }
}
