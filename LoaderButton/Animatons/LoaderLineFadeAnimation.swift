//
//  LoaderLineFadeAnimation.swift
//  LoaderButton
//
//  Created by 黄进文 on 2018/6/11.
//  Copyright © 2018年 Jovins. All rights reserved.
//

import UIKit

class LoaderLineFadeAnimation: LoaderButtonAnimationDelegate {

    /// Setup Loader Layer
    ///
    /// - Parameters:
    /// - layer: layer Parent layer (Button layer)
    /// - frame: frame of parant layer
    /// - color: color of Loader
    func setupLoaderButtonAnimation(layer: CALayer, frame: CGRect, color: UIColor) {

        let padding: CGFloat = 4.0

        let sizeValue = max(min(frame.width, frame.height) - padding, 1.0)
        let center = CGPoint(x: sizeValue * 0.5 + padding * 0.5, y: sizeValue * 0.5 + padding * 0.5)
        let duration: CFTimeInterval = 1.2
        let beginTime = CACurrentMediaTime()
        let beginTimes: [CFTimeInterval] = [0.12, 0.24, 0.36, 0.48, 0.6, 0.72, 0.84, 0.96]
        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        /// animation
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.keyTimes = [0, 0.5, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.1, 1]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        let lineSpace: CGFloat = 2
        let lineSize = CGSize(width: max((sizeValue - 4 * lineSpace) / 8, 1.0),
                              height: max((sizeValue - 2 * lineSpace) / 3, 1.0))
        for i in 0..<8 {
            let line = lineAt(angle: CGFloat(Double.pi / 4 * Double(i)),
                              size: lineSize,
                              origin: center,
                              containerSize: CGSize(width: sizeValue, height: sizeValue),
                              color: color)
            animation.beginTime = beginTime + beginTimes[i]
            line.add(animation, forKey: "animation")
            layer.addSublayer(line)
        }
    }

    private func lineAt(angle: CGFloat, size: CGSize, origin: CGPoint, containerSize: CGSize, color: UIColor) -> CALayer {

        let radius = (containerSize.width * 0.5 - max(size.width, size.height) * 0.5) - 2
        let lineContainerSize = CGSize(width: max(size.width, size.height), height: max(size.width, size.height))
        let lineContainer = LoaderLayer()
        let lineContainFrame = CGRect(x: origin.x + radius * (cos(angle) - 0.5),
                                      y: origin.y + radius * (sin(angle) - 0.5),
                                      width: lineContainerSize.width,
                                      height: lineContainerSize.height)
        let line = LoaderShape.line.layer(with: size, color: color)
        let lineFrame = CGRect(x: (lineContainerSize.width - size.width) * 0.5,
                               y: (lineContainerSize.height - size.height) * 0.5,
                               width: size.width, height: size.height)

        lineContainer.frame = lineContainFrame
        line.frame = lineFrame
        lineContainer.addSublayer(line)
        lineContainer.sublayerTransform = CATransform3DMakeRotation(CGFloat(Double.pi * 0.5) + angle, 0, 0, 1)
        return lineContainer
    }
}
