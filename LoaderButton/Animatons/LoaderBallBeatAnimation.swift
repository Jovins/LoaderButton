//
//  LoaderBallBeatAnimation.swift
//  LoaderButton
//
//  Created by 黄进文 on 2018/6/13.
//  Copyright © 2018年 Jovins. All rights reserved.
//

import UIKit

class LoaderBallBeatAnimation: LoaderButtonAnimationDelegate {

    /// Setup Loader Layer
    ///
    /// - Parameters:
    /// - layer: layer Parent layer (Button layer)
    /// - frame: frame of parant layer
    /// - color: color of Loader
    func setupLoaderButtonAnimation(layer: CALayer, frame: CGRect, color: UIColor) {

        let space: CGFloat = 2
        let padding: CGFloat = 10.0
        let sizeValue: CGFloat = max(min(frame.width, frame.height) - padding, 1.0)
        let circleValue = (sizeValue - 2 * space) / 3
        let x: CGFloat = padding * 0.5
        let y: CGFloat = (sizeValue + padding - circleValue) * 0.5
        let duration: CFTimeInterval = 0.75
        let beginTime = CACurrentMediaTime()
        let beginTimes = [0.35, 0,  0.35]

        /// Scale Animation
        let scaleAnimaton = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimaton.keyTimes = [0, 0.5, 1]
        scaleAnimaton.values = [1, 0.75, 1]
        scaleAnimaton.duration = duration

        /// Opacity Animation
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.keyTimes = [0, 0.5, 1]
        opacityAnimation.values = [1, 0.25, 1]
        opacityAnimation.duration = duration

        /// Group Animation
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimaton, opacityAnimation]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        /// Draw Circles
        for i in 0..<3 {
            let circle = LoaderShape.circle.layer(with: CGSize(width: circleValue, height: circleValue), color: color)
            let frame = CGRect(x: x + circleValue * CGFloat(i) + space * CGFloat(i),
                               y: y,
                               width: circleValue, height: circleValue)
            animation.beginTime = beginTime + beginTimes[i]
            circle.frame = frame
            circle.add(animation, forKey: "animation")
            layer.addSublayer(circle)
        }

    }
}
