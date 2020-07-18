//
//  RestApi.swift
//  MyProject
//
//  Created by Sygnoos9 on 3/9/19.
//  Copyright © 2019 Khoren Markosyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper
import Moya
import Moya_ObjectMapper
import Alamofire

typealias MoyaError = Moya.MoyaError

class RestApi: NetAPI {
    let provider: MyNetworking
    init(provider: MyNetworking) {
        self.provider = provider
    }
}

extension RestApi {
    private func myRequestObject<T: BaseMappable>(_ target: MyApi, type: T.Type) -> Single<T> {
        return provider.request(target)
            .mapObject(T.self)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
}

extension RestApi: MyApiProtocol {
    func productList(store: String, limit: Int?) -> Single<Products> {
        return myRequestObject(.productList(store: store, limit: limit), type: Products.self)
    }

    func cart() -> Single<Cart> {
        return myRequestObject(.cart, type: Cart.self)
    }
}
