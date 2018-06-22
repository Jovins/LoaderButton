//
//  LoaderBallRotateAnimation.swift
//  LoaderButton
//
//  Created by 黄进文 on 2018/6/12.
//  Copyright © 2018年 Jovins. All rights reserved.
//

import UIKit

class LoaderBallRotateAnimation: LoaderButtonAnimationDelegate {

    /// Setup Loader Layer
    ///
    /// - Parameters:
    /// - layer: layer Parent layer (Button layer)
    /// - frame: frame of parant layer
    /// - color: color of Loader
    func setupLoaderButtonAnimation(layer: CALayer, frame: CGRect, color: UIColor) {

        let padding: CGFloat = 10.0
        let sizeValue: CGFloat = max(min(frame.width, frame.height) - padding, 1.0)
        let circleSize: CGFloat = sizeValue / 5
        let duration: CFTimeInterval = 1.0
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.7, -0.13, 0.22, 0.86)

        /// Scale Animation
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0, 0.5, 1]
        scaleAnimation.timingFunctions = [timingFunction, timingFunction]
        scaleAnimation.values = [1, 0.6, 1]
        scaleAnimation.duration = duration

        /// Rotate Animation
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.keyTimes = [0, 0.5, 1]
        rotateAnimation.timingFunctions = [timingFunction, timingFunction]
        rotateAnimation.values = [0, Double.pi, 2 * Double.pi]
        rotateAnimation.duration = duration

        /// Group Animation
        let animaton = CAAnimationGroup()
        animaton.animations = [scaleAnimation, rotateAnimation]
        animaton.duration = duration
        animaton.repeatCount = HUGE
        animaton.isRemovedOnCompletion = false

        /// Draw Circles
        let leftCircle = LoaderShape.circle.layer(with: CGSize(width: circleSize, height: circleSize), color: color)
        let centerCircle = LoaderShape.circle.layer(with: CGSize(width: circleSize, height: circleSize), color: color)
        let rightCircle = LoaderShape.circle.layer(with: CGSize(width: circleSize, height: circleSize), color: color)

        leftCircle.opacity = 0.8
        leftCircle.frame = CGRect(x: padding * 0.5, y: (sizeValue + padding - circleSize) * 0.5,
                                  width: circleSize, height: circleSize)
        centerCircle.frame = CGRect(x: (sizeValue + padding - circleSize) * 0.5,
                                    y: (sizeValue + padding - circleSize) * 0.5,
                                    width: circleSize, height: circleSize)
        rightCircle.opacity = 0.8
        rightCircle.frame = CGRect(x: sizeValue - circleSize + padding * 0.5,
                                   y: (sizeValue + padding - circleSize) * 0.5,
                                   width: circleSize, height: circleSize)

        /// circle
        let circle = LoaderShape.circle.layer(with: CGSize(width: sizeValue + padding, height: sizeValue + padding), color: .clear)
        circle.frame = CGRect(x: 0, y: 0, width: sizeValue + padding, height: sizeValue + padding)
        circle.addSublayer(leftCircle)
        circle.addSublayer(centerCircle)
        circle.addSublayer(rightCircle)
        circle.add(animaton, forKey: "animaton")
        layer.addSublayer(circle)
    }

    private func oldBallRotateAnimation(layer: CALayer, frame: CGRect, color: UIColor) {

        let padding: CGFloat = 10.0
        let sizeValue: CGFloat = max(min(frame.width, frame.height) - padding, 1.0)
        let circle = LoaderShape.ring.layer(with: CGSize(width: sizeValue, height: sizeValue), color: color)
        circle.frame = CGRect(x: padding * 0.5, y: padding * 0.5,
                              width: sizeValue, height: sizeValue)
        layer.addSublayer(circle)

        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.duration = 4.0
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = 2 * Double.pi
        rotateAnimation.repeatCount = .infinity
        rotateAnimation.isRemovedOnCompletion = false
        circle.add(rotateAnimation, forKey: "rotateAnimation")

        let headAnimation = CABasicAnimation(keyPath: "strokeStart")
        headAnimation.duration = 1.0
        headAnimation.fromValue = 0.0
        headAnimation.toValue = 0.25
        headAnimation.timingFunction = timingFunction

        let tailAnimation = CABasicAnimation(keyPath: "strokeEnd")
        tailAnimation.duration = 1.0
        tailAnimation.fromValue = 0.0
        tailAnimation.toValue = 1.0
        tailAnimation.timingFunction = timingFunction

        let endHeadAnimation = CABasicAnimation(keyPath: "strokeStart")
        endHeadAnimation.beginTime = 1.0
        endHeadAnimation.duration = 0.5
        endHeadAnimation.fromValue = 0.25
        endHeadAnimation.toValue = 1.0
        endHeadAnimation.timingFunction = timingFunction

        let endTailAnimation = CABasicAnimation(keyPath: "strokeEnd")
        endTailAnimation.beginTime = 1.0
        endTailAnimation.duration = 0.5
        endTailAnimation.fromValue = 1.0
        endTailAnimation.toValue = 1.0
        endTailAnimation.timingFunction = timingFunction

        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 1.5
        groupAnimation.animations = [headAnimation, tailAnimation, endHeadAnimation, endTailAnimation]
        groupAnimation.repeatCount = .infinity
        groupAnimation.isRemovedOnCompletion = false

        circle.add(groupAnimation, forKey: "groupAnimation")
    }
}
