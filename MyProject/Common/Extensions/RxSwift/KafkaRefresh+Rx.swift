//
//  KafkaRefresh+Rx.swift
//  MyProject
//
//  Created by Liusn on 7/24/18.
//  Copyright © 2020 Liusn. All rights reserved..
//

import Foundation
import RxCocoa
import RxSwift
import KafkaRefresh

extension Reactive where Base: KafkaRefreshControl {

    public var isAnimating: Binder<Bool> {
        return Binder(self.base) { refreshControl, active in
            if active {
//                refreshControl.beginRefreshing()
            } else {
                refreshControl.endRefreshing()
            }
        }
    }
}
