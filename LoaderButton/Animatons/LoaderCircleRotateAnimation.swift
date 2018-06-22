//
//  LoaderBallClipRefreshAnimation.swift
//  LoaderButton
//
//  Created by 黄进文 on 2018/6/13.
//  Copyright © 2018年 Jovins. All rights reserved.
//

import UIKit

class LoaderCircleRotateAnimation: LoaderButtonAnimationDelegate {

    /// Setup Loader Layer
    ///
    /// - Parameters:
    /// - layer: layer Parent layer (Button layer)
    /// - frame: frame of parant layer
    /// - color: color of Loader
    func setupLoaderButtonAnimation(layer: CALayer, frame: CGRect, color: UIColor) {

        let padding: CGFloat = 10.0
        let sizeValue: CGFloat = max(min(frame.width, frame.height) - padding, 1.0)

        /// Rotate Animation
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.keyTimes = [0, 0.5, 1.0].map{ NSNumber(value: $0) }
        rotateAnimation.values = [0, Double.pi, 2 * Double.pi].map{ NSNumber(value: $0) }

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 0.75
        animationGroup.repeatCount = .infinity
        animationGroup.animations = [rotateAnimation]

        let circle = LoaderShape.ringThirdFour.layer(with: CGSize(width: sizeValue, height: sizeValue), color: color)
        circle.frame = CGRect(x: padding * 0.5, y: padding * 0.5,
                              width: sizeValue, height: sizeValue)
        circle.add(animationGroup, forKey: "animation")
        layer.addSublayer(circle)
    }
}
