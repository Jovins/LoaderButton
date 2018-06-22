//
//  LoaderBallClipRotatePulseAnimation.swift
//  LoaderButton
//
//  Created by 黄进文 on 2018/6/12.
//  Copyright © 2018年 Jovins. All rights reserved.
//

import UIKit

class LoaderBallPulseRotateAnimation: LoaderButtonAnimationDelegate {

    /// Setup Loader Layer
    ///
    /// - Parameters:
    /// - layer: layer Parent layer (Button layer)
    /// - frame: frame of parant layer
    /// - color: color of Loader
    func setupLoaderButtonAnimation(layer: CALayer, frame: CGRect, color: UIColor) {

        let padding: CGFloat = 10.0
        let sizeValue = max(min(frame.width, frame.height) - padding, 1.0)
        let duration: CFTimeInterval = 1.0
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.09, 0.57, 0.49, 0.9)
        smallCircle(with: duration, timingFunction: timingFunction, layer: layer, sizeValue: sizeValue, color: color)
        bigCircle(with: duration, timingFunction: timingFunction, layer: layer, sizeValue: sizeValue, color: color)
    }

    /// Small Circle
    private func smallCircle(with duration: CFTimeInterval, timingFunction: CAMediaTimingFunction, layer: CALayer, sizeValue: CGFloat, color: UIColor) {

        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.keyTimes = [0, 0.3, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.3, 1]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        // Draw Circle
        let circleSize = sizeValue * 0.5
        let padding: CGFloat = 10.0
        let circle = LoaderShape.circle.layer(with: CGSize(width: circleSize, height: circleSize), color: color)
        let frame = CGRect(x: (sizeValue + padding - circleSize) * 0.5,
                           y: (sizeValue + padding - circleSize) * 0.5,
                           width: circleSize, height: circleSize)
        circle.frame = frame
        circle.add(animation, forKey: "animation")
        layer.addSublayer(circle)
    }

    /// Big Circle
    private func bigCircle(with duration: CFTimeInterval, timingFunction: CAMediaTimingFunction, layer: CALayer, sizeValue: CGFloat, color: UIColor) {

        /// Scale Animation
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0, 0.5, 1]
        scaleAnimation.timingFunctions = [timingFunction, timingFunction]
        scaleAnimation.values = [1, 0.6, 1]
        scaleAnimation.duration = duration

        /// Rotate Animation
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.keyTimes = scaleAnimation.keyTimes
        rotateAnimation.timingFunctions = [timingFunction, timingFunction]
        rotateAnimation.values = [0, Double.pi, 2 * Double.pi]
        rotateAnimation.duration = duration

        /// Group Animation
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, rotateAnimation]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        /// Draw Circle
        let padding: CGFloat = 10.0
        let circle = LoaderShape.ringVertical.layer(with: CGSize(width: sizeValue, height: sizeValue), color: color)
        let frame = CGRect(x: padding * 0.5,
                           y: padding * 0.5,
                           width: sizeValue,
                           height: sizeValue)
        circle.frame = frame
        circle.add(animation, forKey: "animation")
        layer.addSublayer(circle)
    }
}
