//
//  ProductCellViewModel.swift
//  MyProject
//
//  Created by shengnan liu on 17/7/20.
//  Copyright © 2020 Liusn. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProductCellViewModel: TableViewCellViewModel {
    let title = BehaviorRelay<String?>(value: nil)
    let detail = BehaviorRelay<String?>(value: nil)
    let secondDetail = BehaviorRelay<String?>(value: nil)
    let attributedDetail = BehaviorRelay<NSAttributedString?>(value: nil)
    let image = BehaviorRelay<UIImage?>(value: nil)
    let imageUrl = BehaviorRelay<String?>(value: nil)

    var product: Product
    init(with product: Product) {
        self.product = product
        super.init()
        imageUrl.accept(product.imageUrl)
        title.accept(product.title)
        detail.accept(product.detail)
        secondDetail.accept(product.secondDetail)
    }

    func requset() {
        print("send add cart request")
    }
}
