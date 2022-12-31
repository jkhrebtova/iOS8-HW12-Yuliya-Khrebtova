//
//  Extension.swift
//  iOS8-HW12-Yuliya Khrebtova
//
//  Created by Julia on 31.12.2022.
//

import UIKit

extension CALayer {
    func pauseAnimation() {
        if !isPaused() {
            let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
            speed = 0.0
            timeOffset = pausedTime
        }
    }

    func resumeAnimation() {
        if isPaused() {
            let pausedTime = timeOffset
            speed = 1.0
            timeOffset = 0.0
            beginTime = 0.0
            let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            beginTime = timeSincePause
        }
    }

    func isPaused() -> Bool {
        return speed == 0
    }
}
