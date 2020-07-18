//
//  Banner.swift
//  MyProject
//
//  Created by shengnan liu on 18/7/20.
//  Copyright © 2020 sph. All rights reserved.
//

import UIKit
import ObjectMapper

struct Banner: Mappable {
    var imageUrl: String?
    var link: String?

    init?(map: Map) {}
    init() {}

    mutating func mapping(map: Map) {
        imageUrl <- map["imageUrl"]
        link <- map["link"]
    }
}
