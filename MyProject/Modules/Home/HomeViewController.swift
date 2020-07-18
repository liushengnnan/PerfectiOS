//
//  HomeViewController.swift
//  MyProject
//
//  Created by shengnan liu on 16/7/20.
//  Copyright © 2020 Liusn. All rights reserved.
//
import RxSwift
import RxCocoa
import RxDataSources

private let reuseIdentifier = R.reuseIdentifier.productTableViewCell.identifier
class HomeViewController: TableViewController {

    lazy var cartButton: Button = {
        let view = Button()
        view.imageForNormal = R.image.icon_cart()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        cartButton.rx.tap.asObservable().subscribe(onNext: { [weak self] () in
//            let viewModel = CartViewModel(provider: self?.provider as! NetAPI)
//            self?.navigator.show(segue: .cart(viewModel: viewModel), sender: self, transition: .navigation(type: .fade))
//        }).disposed(by: rx.disposeBag)
    }

    override func makeUI() {
        super.makeUI()

        languageChanged.subscribe(onNext: { [weak self] () in
            self?.title = R.string.localizable.homeTitle.key.localized()
        }).disposed(by: rx.disposeBag)

        tableView.register(R.nib.productTableViewCell)
        tableView.footRefreshControl = nil

        contentView.addSubview(cartButton)
        cartButton.snp.makeConstraints({ (make) in
            make.size.equalTo(44)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        })
    }

    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? HomeViewModel else { return }

        let refresh = Observable.of(Observable.just(()), headerRefreshTrigger).merge()
        let input = HomeViewModel.Input(selection: tableView.rx.modelSelected(ProductCellViewModel.self).asDriver(),
                                        headerRefresh: refresh,
                                        cartTrigger: cartButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)

        viewModel.loading.asObservable().bind(to: isLoading).disposed(by: rx.disposeBag)
        viewModel.headerLoading.asObservable().bind(to: isHeaderLoading).disposed(by: rx.disposeBag)
        viewModel.footerLoading.asObservable().bind(to: isFooterLoading).disposed(by: rx.disposeBag)

        output.items.asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: ProductTableViewCell.self)) { _, viewModel, cell in
                cell.bind(to: viewModel)
        }.disposed(by: rx.disposeBag)

        output.cartTapped.drive(onNext: { [weak self] (viewModel) in
            self?.navigator.show(segue: .cart(viewModel: viewModel), sender: self, transition: .navigation(type: .fade))
        }).disposed(by: rx.disposeBag)
    }
}
