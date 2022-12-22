//
//  Metrics.swift
//  DooDooIOS
//
//  Created by Артем Лавров on 17.04.2022.
//

import Foundation

class Metrics {
    static let pageContentPadding = 10.pt
}

extension Double {
    var pt: Float {
        get {
            return Float(self * 1.0)
        }
    }
}

extension Int {
    var pt: Float {
        get {
            return Float(self) * 1.0.pt
        }
    }
}
