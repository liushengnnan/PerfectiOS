//
//  AddToCartApi.swift
//  MyProject
//
//  Created by shengnan liu on 19/7/20.
//  Copyright © 2020 sph. All rights reserved.
//

import Foundation
import Moya

class AddToCartApi: TargetType {
    var productId: String?

    public var baseURL: URL {
        return URL(string: "https://my.project.sg")!
    }
    public var path: String {
        return "/api/1/action/product_list"
    }
    public var method: Moya.Method {
        return .get
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
        params["id"] = productId
        return params
    }

    public var sampleData: Data {
        let dataUrl: URL? = R.file.cartJson()
        if let url = dataUrl, let data = try? Data(contentsOf: url) {
            return data
        }
        return Data()
    }
}
