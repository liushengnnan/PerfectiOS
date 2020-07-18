//
//  ViewModelType.swift
//  MyProject
//
//  Created by Liusn on 6/30/18.
//  Copyright © 2020 Liusn. All rights reserved..
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

class ViewModel: NSObject {

    let provider: NetAPI
    var page = 1

    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()

    init(provider: NetAPI) {
        self.provider = provider
        super.init()
    }
}
