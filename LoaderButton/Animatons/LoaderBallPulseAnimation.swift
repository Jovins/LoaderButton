//
//  LoaderBallPulseAnimation.swift
//  LoaderButton
//
//  Created by 黄进文 on 2018/6/12.
//  Copyright © 2018年 Jovins. All rights reserved.
//

import UIKit

class LoaderBallPulseAnimation: LoaderButtonAnimationDelegate {

    /// Setup Loader Layer
    ///
    /// - Parameters:
    /// - layer: layer Parent layer (Button layer)
    /// - frame: frame of parant layer
    /// - color: color of Loader
    func setupLoaderButtonAnimation(layer: CALayer, frame: CGRect, color: UIColor) {

        let padding: CGFloat = 10.0
        let sizeValue = max(min(frame.width, frame.height) - padding, 1.0)
        let space: CGFloat = 2
        let circleSize: CGFloat = (sizeValue - 2 * space) / 3
        let x: CGFloat = padding * 0.5
        let y: CGFloat = (layer.bounds.size.height - circleSize) * 0.5
        let duration: CFTimeInterval = 0.75
        let beginTime = CACurrentMediaTime()
        let beginTimes: [CFTimeInterval] = [0.12, 0.24, 0.36]
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)

        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.keyTimes = [0, 0.3, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.3, 1]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        /// Draw circles
        for i in 0..<3 {
            let circle = LoaderShape.circle.layer(with: CGSize(width: circleSize, height: circleSize), color: color)
            let frame = CGRect(x: x + circleSize * CGFloat(i) + space * CGFloat(i),
                               y: y, width: circleSize, height: circleSize)
            animation.beginTime = beginTime + beginTimes[i]
            circle.frame = frame
            circle.add(animation, forKey: "animation")
            layer.addSublayer(circle)
        }
    }
}
