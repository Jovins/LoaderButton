//
//  LoaderRotateChaseAnimation.swift
//  LoaderButton
//
//  Created by 黄进文 on 2018/6/11.
//  Copyright © 2018年 Jovins. All rights reserved.
//

import UIKit

class LoaderRotateChaseAnimation: LoaderButtonAnimationDelegate {

    /// Setup Loader Layer
    ///
    /// - Parameters:
    /// - layer: layer Parent layer (Button layer)
    /// - frame: frame of parant layer
    /// - color: color of Loader
    func setupLoaderButtonAnimation(layer: CALayer, frame: CGRect, color: UIColor) {

        let padding: CGFloat = 10.0
        let size = max(min(frame.width, frame.height) - padding, 1.0)
        let center = CGPoint(x: size * 0.5 + padding * 0.5, y: size * 0.5 + padding * 0.5)
        let circleSize = size / 6
        for i in 0..<5 {
            let factor = Float(i) * 1 / 5
            let circle = LoaderShape.circle.layer(with: CGSize(width: circleSize, height: circleSize), color: color)
            let animation = rotateAnimation(factor, x: center.x, y: center.y,
                                            size: CGSize(width: size - circleSize, height: size - circleSize))
            circle.frame = CGRect(x: 0, y: 0, width: circleSize, height: circleSize)
            circle.add(animation, forKey: "animation")
            layer.addSublayer(circle)
        }
    }

    /// Rotate Animation
    ///
    /// - Parameters:
    ///   - rate: rate of rotation
    ///   - x: X value of center
    ///   - y: Y value of center
    ///   - size: size of spinner
    /// - Returns: Rotate Animation group
    private func rotateAnimation(_ rate: Float, x: CGFloat, y: CGFloat, size: CGSize) -> CAAnimationGroup {

        let duration: CFTimeInterval = 1.5
        let frameScale = 1 - rate
        let toScale = 0.2 + rate
        let timeFunc = CAMediaTimingFunction(controlPoints: 0.5, 0.15 + rate, 0.25, 1)

        /// scale
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = duration
        scaleAnimation.repeatCount = HUGE
        scaleAnimation.fromValue = frameScale
        scaleAnimation.toValue = toScale

        /// position
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.duration = duration
        positionAnimation.repeatCount = HUGE
        positionAnimation.path = UIBezierPath(arcCenter: CGPoint(x: x, y: y),
                                              radius: size.width * 0.5,
                                              startAngle: CGFloat(3 * Double.pi * 0.5),
                                              endAngle: CGFloat(3 * Double.pi * 0.5 + 2 * Double.pi),
                                              clockwise: true).cgPath

        /// animation
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, positionAnimation]
        animation.timingFunction = timeFunc
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        return animation
    }
}
