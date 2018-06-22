//
//  LoaderBallClipRotateMultipleAnimation.swift
//  LoaderButton
//
//  Created by 黄进文 on 2018/6/12.
//  Copyright © 2018年 Jovins. All rights reserved.
//

import UIKit

class LoaderBallMultipleRotateAnimation: LoaderButtonAnimationDelegate {

    /// Setup Loader Layer
    ///
    /// - Parameters:
    /// - layer: layer Parent layer (Button layer)
    /// - frame: frame of parant layer
    /// - color: color of Loader
    func setupLoaderButtonAnimation(layer: CALayer, frame: CGRect, color: UIColor) {

        let padding: CGFloat = 10.0
        let kWidth: CGFloat = min(frame.width, frame.height)
        let sizeValue = max(kWidth - padding, 1.0)
        let bigFrame: CGRect = CGRect(x: padding * 0.5, y: padding * 0.5,
                                      width: sizeValue, height: sizeValue)
        let smallFrame: CGRect = CGRect(x: (kWidth - sizeValue * 0.5) * 0.5,
                                        y: (kWidth - sizeValue * 0.5) * 0.5,
                                        width: sizeValue * 0.5, height: sizeValue * 0.5)
        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        let duration: CFTimeInterval = 1.0
        createCircle(with: .ringHorizontal, duration: duration, timingFunction: timingFunction, layer: layer, size: bigFrame.size, frame: bigFrame, color: color, reverse: false)
        createCircle(with: .ringVertical, duration: duration, timingFunction: timingFunction, layer: layer, size: smallFrame.size, frame: smallFrame, color: color, reverse: true)
    }

    private func createCircle(with shape: LoaderShape, duration: CFTimeInterval, timingFunction: CAMediaTimingFunction, layer: CALayer, size: CGSize, frame: CGRect, color: UIColor, reverse: Bool) {

        let circle = shape.layer(with: size, color: color)
        let animation = createAnimation(with: duration, timingFunction: timingFunction, reverse: reverse)
        circle.frame = frame
        circle.add(animation, forKey: "animation")
        layer.addSublayer(circle)
    }

    private func createAnimation(with duration: CFTimeInterval, timingFunction: CAMediaTimingFunction, reverse: Bool) -> CAAnimation {

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
        if !reverse {
            rotateAnimation.values = [0, Double.pi, 2 * Double.pi]
        } else {
            rotateAnimation.values = [0, -Double.pi,-2 * Double.pi]
        }
        rotateAnimation.duration = duration

        /// Group Animation
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, rotateAnimation]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        return animation
    }
}
