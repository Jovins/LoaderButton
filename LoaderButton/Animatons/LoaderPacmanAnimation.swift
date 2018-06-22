//
//  LoaderPacmanAnimation.swift
//  LoaderButton
//
//  Created by 黄进文 on 2018/6/13.
//  Copyright © 2018年 Jovins. All rights reserved.
//

import UIKit

class LoaderPacmanAnimation: LoaderButtonAnimationDelegate {

    /// Setup Loader Layer
    ///
    /// - Parameters:
    /// - layer: layer Parent layer (Button layer)
    /// - frame: frame of parant layer
    /// - color: color of Loader
    func setupLoaderButtonAnimation(layer: CALayer, frame: CGRect, color: UIColor) {

        let padding: CGFloat = 10.0
        let sizeValue: CGFloat = max(min(frame.width, frame.height) - padding, 1.0)
        createCircle(with: layer, sizeValue: sizeValue, color: color)
        createPacman(with: layer, sizeValue: sizeValue, color: color)
    }

    /// Create Pacman
    private func createPacman(with layer: CALayer, sizeValue: CGFloat, color: UIColor) {

        let padding: CGFloat = 10
        let pacmanValue: CGFloat = sizeValue
        let pacmanDuration: CFTimeInterval = 0.5
        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)

        /// Stroke Start Animaition
        let startAnimation = CAKeyframeAnimation(keyPath: "strokeStart")
        startAnimation.keyTimes = [0, 0.5, 1]
        startAnimation.timingFunctions = [timingFunction, timingFunction]
        startAnimation.values = [0.125, 0, 0.125]
        startAnimation.duration = pacmanDuration

        /// Stroke End Animation
        let endAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        endAnimation.keyTimes = [0, 0.5, 1]
        endAnimation.timingFunctions = [timingFunction, timingFunction]
        endAnimation.values = [0.875, 1, 0.875]
        endAnimation.duration = pacmanDuration

        /// Group Animation
        let animation = CAAnimationGroup()
        animation.animations = [startAnimation, endAnimation]
        animation.duration = pacmanDuration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        /// Draw Pacman
        let pacman = LoaderShape.pacman.layer(with: CGSize(width: pacmanValue, height: pacmanValue), color: color)
        let frame = CGRect(x: (sizeValue + padding - pacmanValue) * 0.5,
                           y: (sizeValue + padding - pacmanValue) * 0.5,
                           width: pacmanValue, height: pacmanValue)
        pacman.frame = frame
        pacman.add(animation, forKey: "animation")
        layer.addSublayer(pacman)
    }

    /// Create Circle
    private func createCircle(with layer: CALayer, sizeValue: CGFloat, color: UIColor) {

        let padding: CGFloat = 10.0
        let circleSize: CGFloat = sizeValue / 5
        let circleDuration: CFTimeInterval = 1.0

        /// Translate Animaton
        let translateAnimaton = CABasicAnimation(keyPath: "transform.translation.x")
        translateAnimaton.fromValue = 0
        translateAnimaton.toValue = -sizeValue * 0.5
        translateAnimaton.duration = circleDuration

        /// Opacity Animatoin
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.75
        opacityAnimation.duration = circleDuration

        /// Animation
        let animation = CAAnimationGroup()
        animation.animations = [translateAnimaton, opacityAnimation]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = circleDuration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        /// Draw Circle
        let circle = LoaderShape.circle.layer(with: CGSize(width: circleSize, height: circleSize), color: color)
        let frame = CGRect(x: sizeValue + padding * 0.5,
                           y: (sizeValue + padding - circleSize) * 0.5,
                           width: circleSize, height: circleSize)
        circle.frame = frame
        circle.add(animation, forKey: "animation")
        layer.addSublayer(circle)
    }
}
