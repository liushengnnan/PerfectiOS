//
//  Api.swift
//  MyProject
//
//  Created by Liusn on 1/5/18.
//  Copyright © 2020 Liusn. All rights reserved..
//

import Foundation
import RxSwift
import RxCocoa

protocol MyApiProtocol {
    func productList(store: String, limit: Int?) -> Single<Products>
    func cart() -> Single<Cart>
}

protocol NetAPI: MyApiProtocol {
    // Add More ApiProtocol
}
