//
//  HomeViewModel.swift
//  MyProject
//
//  Created by shengnan liu on 16/7/20.
//  Copyright © 2020 Liusn. All rights reserved.
//

import RxCocoa
import RxSwift
import RxDataSources

class HomeViewModel: ViewModel, ViewModelType {
    init(id: String, provider: NetAPI) {
        super.init(provider: provider)
    }
    struct Input {
        let selection: Driver<ProductCellViewModel>
        let headerRefresh: Observable<Void>
        let cartTrigger: Driver<Void>
    }
    struct Output {
        let items: BehaviorRelay<[ProductCellViewModel]>
        let cartTapped: Driver<CartViewModel>
    }

    func transform(input: Input) -> Output {
        let elements = BehaviorRelay<[ProductCellViewModel]>(value: [])
        input.headerRefresh.flatMapLatest({ [weak self] () -> Observable<[ProductCellViewModel]> in
            guard let self = self else { return Observable.just([]) }
            self.page = 1
            return self.request()
                .trackActivity(self.headerLoading)
        })
            .subscribe(onNext: { (items) in
                elements.accept(items)
            }).disposed(by: rx.disposeBag)

        let cartTapped = input.cartTrigger.map({ () -> CartViewModel in
                let viewModel = CartViewModel(provider: self.provider)
                return viewModel
            })
        return Output(items: elements, cartTapped: cartTapped)
    }

    func request() -> Observable<[ProductCellViewModel]> {
        return provider.productList(store: "String", limit: 5)
            .trackActivity(loading)
            .map {
                let productList = $0.productList!
                return productList.map({ (product) -> ProductCellViewModel in
                    let viewModel = ProductCellViewModel(with: product)
                    return viewModel
                })}
    }
}

