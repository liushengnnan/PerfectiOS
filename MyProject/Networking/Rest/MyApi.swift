//
//  MyApi.swift
//  MyProject
//
//  Created by shengnan liu on 17/7/20.
//  Copyright © 2020 Liusn. All rights reserved.
//

import Foundation
import Moya

public enum MyApi {
    case productList(store: String, limit: Int?)
    case cart
}

extension MyApi: TargetType {
    public var baseURL: URL {
        return URL(string: "https://my.project.sg")!
    }
    public var path: String {
        switch self {
        case .productList: return "/api/1/action/product_list"
        case .cart: return "/api/1/action/cart"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .productList: return .get
        case .cart:  return .get
        }
    }
    public var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        return .requestPlain
    }
    public var headers: [String: String]? {
        return nil
    }

    public var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .productList(let store, let limit):
            params["store"] = store
            params["limit"] = limit
        case .cart: break
        }
        return params
    }

    public var sampleData: Data {
        var dataUrl: URL?
        switch self {
        case .productList: dataUrl = R.file.productListJson()
        case .cart: dataUrl = R.file.cartJson()
        }
        if let url = dataUrl, let data = try? Data(contentsOf: url) {
            return data
        }
        return Data()
    }
}
