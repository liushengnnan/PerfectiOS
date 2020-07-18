//
//  UIColor+SwiftHub.swift
//  MyProject
//
//  Created by Liusn on 1/4/17.
//  Copyright © 2020 Liusn. All rights reserved.
//

import UIKit

// MARK: Colors

extension UIColor {
    static func primary() -> UIColor {
        return themeService.type.associatedObject.primary
    }

    static func secondary() -> UIColor {
        return themeService.type.associatedObject.secondary
    }
}
