//
//  Product.swift
//  MyProject
//
//  Created by shengnan liu on 17/7/20.
//  Copyright © 2020 Liusn. All rights reserved.
//

import Foundation
import ObjectMapper

struct Product: Mappable {
    var imageUrl: String?
    var title: String?
    var detail: String?
    var secondDetail: String?
    var price: String?

    init?(map: Map) {}
    init() {}

    mutating func mapping(map: Map) {
        imageUrl <- map["imageUrl"]
        title <- map["title"]
        detail <- map["detail"]
        secondDetail <- map["secondDetail"]
        price <- map["price"]
    }
}

struct Products: Mappable {
    var count: Int?
    var productList: [Product]?

    init?(map: Map) {}
    init() {}

    mutating func mapping(map: Map) {
        count <- map["count"]
        productList <- map["productList"]
    }
}
