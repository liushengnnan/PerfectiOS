//
//  MyNetworking.swift
//  MyProject
//
//  Created by shengnan liu on 17/7/20.
//  Copyright © 2020 Liusn. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Alamofire


struct MyNetworking: NetworkingType {
    typealias T = MyApi
    let provider: OnlineProvider<T>
    static func defaultNetworking() -> Self {
        return MyNetworking(provider: newProvider(plugins))
    }
    static func stubbingNetworking() -> Self {
        return MyNetworking(provider: OnlineProvider(endpointClosure: endpointsClosure(), requestClosure: MyNetworking.endpointResolver(), stubClosure: MoyaProvider.immediatelyStub, online: .just(true)))
    }
    func request(_ token: T) -> Observable<Moya.Response> {
        let actualRequest = self.provider.request(token)
        return actualRequest
    }
}
