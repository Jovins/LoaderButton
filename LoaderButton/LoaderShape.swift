//
//  LoaderShape.swift
//  LoaderButton
//
//  Created by 黄进文 on 2018/6/11.
//  Copyright © 2018年 Jovins. All rights reserved.
//

import UIKit

enum LoaderShape {
    case ring
    case ringVertical
    case ringHorizontal
    case ringThirdFour
    case circle
    case circleSemi
    case line
    case stroke
    case rectangle
    case triangle
    case pacman

    /// Return CALayer of specific shape
    /// - Parameters:
    /// - size: size of draw shape area
    /// - color: stroke color of shape
    func layer(with size: CGSize, color: UIColor) -> CALayer {

        let layer: CAShapeLayer = LoaderLayer()
        var path: UIBezierPath = UIBezierPath()
        let lineWidth: CGFloat = 2
        switch self {
        case .ring:
             path.addArc(withCenter: CGPoint(x: size.width * 0.5, y: size.height * 0.5),
                         radius: (size.width * 0.5),
                         startAngle: CGFloat(-3 * Double.pi / 4),
                         endAngle: CGFloat(-Double.pi / 4),
                         clockwise: false)
            layer.fillColor = nil
            layer.strokeColor = color.cgColor
            layer.lineWidth = 2
        case .ringVertical:
            path.addArc(withCenter: CGPoint(x: size.width * 0.5, y: size.height * 0.5),
                        radius: size.width * 0.5,
                        startAngle: CGFloat(-3 * Double.pi / 4),
                        endAngle: CGFloat(-Double.pi / 4),
                        clockwise: true) /// clockwise: 顺时针
            path.move(to: CGPoint(x: size.width * 0.5 - size.width * 0.5 * cos(CGFloat(Double.pi / 4)),
                                  y: size.height * 0.5 + size.height * 0.5 * sin(CGFloat(Double.pi / 4))))
            path.addArc(withCenter: CGPoint(x: size.width * 0.5, y: size.height * 0.5),
                        radius: size.width * 0.5,
                        startAngle: CGFloat(-5 * Double.pi / 4),
                        endAngle: CGFloat(-7 * Double.pi / 4), clockwise: false)
            layer.fillColor = nil
            layer.strokeColor = color.cgColor
            layer.lineWidth = lineWidth
        case .ringHorizontal:
            path.addArc(withCenter: CGPoint(x: size.width * 0.5, y: size.height * 0.5),
                        radius: size.width * 0.5,
                        startAngle: CGFloat(3 * Double.pi / 4),
                        endAngle: CGFloat(5 * Double.pi / 4),
                        clockwise: true)
            path.move(to: CGPoint(x: size.width * 0.5 + size.width * 0.5 * cos(CGFloat(Double.pi / 4)),
                                  y: size.height * 0.5 - size.height * 0.5 * sin(CGFloat(Double.pi / 4))))
            path.addArc(withCenter: CGPoint(x: size.width * 0.5, y: size.height * 0.5),
                        radius: size.width * 0.5,
                        startAngle: CGFloat(-Double.pi / 4),
                        endAngle: CGFloat(Double.pi / 4),
                        clockwise: true)
            layer.fillColor = nil
            layer.strokeColor = color.cgColor
            layer.lineWidth = lineWidth
        case .ringThirdFour:
            path.addArc(withCenter: CGPoint(x: size.width * 0.5, y: size.height * 0.5),
                        radius: size.width * 0.5,
                        startAngle: CGFloat(-3 * Double.pi / 4),
                        endAngle: CGFloat(-Double.pi / 4),
                        clockwise: false)
            layer.fillColor = nil
            layer.strokeColor = color.cgColor
            layer.lineWidth = lineWidth
        case .circle:
            path.addArc(withCenter: CGPoint(x: size.width * 0.5, y: size.height * 0.5),
                        radius: size.width * 0.5,
                        startAngle: 0,
                        endAngle: CGFloat(2 * Double.pi), clockwise: false)
            layer.fillColor = color.cgColor
        case .circleSemi:
            path.addArc(withCenter: CGPoint(x: size.width * 0.5, y: size.height * 0.5),
                        radius: size.width * 0.5,
                        startAngle: CGFloat(-Double.pi / 6),
                        endAngle: CGFloat(-5 * Double.pi / 6),
                        clockwise: false)
            path.close()
            layer.fillColor = color.cgColor
        case .line:
            path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height),
                                cornerRadius: size.width * 0.5)
            layer.fillColor = color.cgColor
        case .stroke:
            path.addArc(withCenter: CGPoint(x: size.width * 0.5, y: size.height * 0.5),
                        radius: size.width * 0.5,
                        startAngle: -(.pi * 0.5),
                        endAngle: .pi + .pi * 0.5,
                        clockwise: true)
            layer.fillColor = nil
            layer.strokeColor = color.cgColor
            layer.lineWidth = lineWidth
        case .rectangle:
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: size.width, y: 0))
            path.addLine(to: CGPoint(x: size.width, y: size.height))
            path.addLine(to: CGPoint(x: 0, y: size.height))
            layer.fillColor = color.cgColor
        case .triangle:
            let offsetY = size.height / 4
            path.move(to: CGPoint(x: 0, y: size.height - offsetY))
            path.addLine(to: CGPoint(x: size.width * 0.5, y: size.height * 0.5 - offsetY))
            path.addLine(to: CGPoint(x: size.width, y: size.height - offsetY))
            path.close()
            layer.fillColor = color.cgColor
        case .pacman:
            path.addArc(withCenter: CGPoint(x: size.width * 0.5, y: size.height * 0.5),
                        radius: size.width / 4,
                        startAngle: 0,
                        endAngle: CGFloat(2 * Double.pi),
                        clockwise: true)
            layer.fillColor = nil
            layer.strokeColor = color.cgColor
            layer.lineWidth = size.width * 0.5
        }
        layer.backgroundColor = nil
        layer.path = path.cgPath
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        return layer
    }
}
