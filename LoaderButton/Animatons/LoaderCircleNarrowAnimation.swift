//
//  LoaderButtonClipRotateAnimation.swift
//  LoaderButton
//
//  Created by 黄进文 on 2018/6/11.
//  Copyright © 2018年 Jovins. All rights reserved.
//

import UIKit

class LoaderCircleNarrowAnimation: LoaderButtonAnimationDelegate {

    /// Setup Loader Layer
    ///
    /// - Parameters:
    /// - layer: layer Parent layer (Button layer)
    /// - frame: frame of parant layer
    /// - color: color of Loader
    func setupLoaderButtonAnimation(layer: CALayer, frame: CGRect, color: UIColor) {

        let sizeValue = min(frame.width, frame.height)
        let clipRotate = LoaderShape.ring.layer(with: CGSize(width: sizeValue, height: sizeValue), color: color)
        clipRotate.frame = CGRect(x: 0, y: 0, width: sizeValue, height: sizeValue)
        layer.addSublayer(clipRotate)

        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0, 0.5, 1].map{ NSNumber(value: $0) }
        scaleAnimation.values = [0.8, 0.4, 0.8].map{ NSNumber(value: $0) }

        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.keyTimes = scaleAnimation.keyTimes
        rotateAnimation.values = [0, Double.pi, 2 * Double.pi].map{ NSNumber(value: $0) }

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1.0
        animationGroup.repeatCount = .infinity
        animationGroup.animations = [scaleAnimation, rotateAnimation]
        clipRotate.add(animationGroup, forKey: "animation")
    }
}
