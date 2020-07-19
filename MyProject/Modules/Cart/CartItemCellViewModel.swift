//
//  CartItemCellViewModel.swift
//  MyProject
//
//  Created by shengnan liu on 17/7/20.
//  Copyright © 2020 Liusn. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CartItemCellViewModel: TableViewCellViewModel {
    let title = BehaviorRelay<String?>(value: nil)
    let detail = BehaviorRelay<String?>(value: nil)
    let secondDetail = BehaviorRelay<String?>(value: nil)
    let attributedDetail = BehaviorRelay<NSAttributedString?>(value: nil)
    let image = BehaviorRelay<UIImage?>(value: nil)
    let imageUrl = BehaviorRelay<String?>(value: nil)

    let item: CartItem
    init(with item: CartItem) {
        self.item = item
        super.init()
        imageUrl.accept(item.imageUrl)
        title.accept(item.title)
//        detail.accept(item.detail)
//        secondDetail.accept(item.secondDetail)
    }
}
