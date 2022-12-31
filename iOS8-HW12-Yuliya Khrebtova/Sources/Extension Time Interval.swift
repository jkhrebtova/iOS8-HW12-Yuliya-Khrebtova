//
//  Extensions.swift
//  iOS8-HW12-Yuliya Khrebtova
//
//  Created by Julia on 25.12.2022.
//

import UIKit

extension TimeInterval {
    var minuteSecondMS: String {
        String(format:"%02d:%02d.%02d", minute, second, millisecond)
    }
    var secondMS: String {
        String(format:"%02d:%02d", second, millisecond)
    }
    var hour: Int {
        Int((self / 3600).truncatingRemainder(dividingBy: 3600))
    }
    var minute: Int {
        Int((self / 60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        Int((self * 100).truncatingRemainder(dividingBy: 100))
    }
}
