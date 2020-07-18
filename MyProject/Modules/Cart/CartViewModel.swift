//
//  CartViewModel.swift
//  MyProject
//
//  Created by shengnan liu on 17/7/20.
//  Copyright © 2020 Liusn. All rights reserved.
//

import RxCocoa
import RxSwift
import RxDataSources

class CartViewModel: ViewModel, ViewModelType  {
    struct Input {
        let selection: Driver<CartItemCellViewModel>
        let headerRefresh: Observable<Void>
    }
    struct Output {
        let items: BehaviorRelay<[CartItemCellViewModel]>
    }
    func transform(input: Input) -> Output {
        let elements = BehaviorRelay<[CartItemCellViewModel]>(value: [])

        input.headerRefresh.flatMapLatest({ [weak self] () -> Observable<[CartItemCellViewModel]> in
            guard let self = self else { return Observable.just([]) }
            self.page = 1
            return self.request().trackActivity(self.headerLoading)
        })
            .subscribe(onNext: { (items) in
                elements.accept(items)
            }).disposed(by: rx.disposeBag)

        return Output(items: elements)
    }

    func request() -> Observable<[CartItemCellViewModel]> {
        return provider.cart()
            .trackActivity(loading)
            .map {
                let cartItems = $0.cartItems!
                return cartItems.map({ (item) -> CartItemCellViewModel in
                    let viewModel = CartItemCellViewModel(with: item)
                    return viewModel
                })}
    }
}
