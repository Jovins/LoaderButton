//
//  LoaderTypes.swift
//  LoaderButton
//
//  Created by 黄进文 on 2018/6/11.
//  Copyright © 2018年 Jovins. All rights reserved.
//

import UIKit

public enum LoaderType: Int {

    /// 0.rotateChase
    case rotateChase
    /// 1.lineFade
    case lineFade
    /// 2.circleStroke
    case circleChasse
    /// 3.clipRotate
    case circleNarrow
    /// 4.ballPulse
    case ballPulse
    /// 5.ballPulseRotate
    case ballPulseRotate
    /// 6.ballMultipleRotate
    case ballMultipleRotate
    /// 7.ballRotate
    case ballRotate
    /// 8.ballBeat
    case ballBeat
    /// 9.pacman
    case pacman
    /// 10.circleRotate
    case circleRotate

    func animation() -> LoaderButtonAnimationDelegate {

        switch self {
        case .rotateChase:
            return LoaderRotateChaseAnimation()                     /// 0.rotateChase
        case .lineFade:
            return LoaderLineFadeAnimation()                        /// 1.lineFade
        case .circleChasse:
            return LoaderCircleChaseAnimation()                     /// 2.circleChasse
        case .circleNarrow:
            return LoaderCircleNarrowAnimation()                    /// 3.circleNarrow
        case .ballPulse:
            return LoaderBallPulseAnimation()                       /// 4.ballPulse
        case .ballPulseRotate:
            return LoaderBallPulseRotateAnimation()                 /// 5.ballPulseRotate
        case .ballMultipleRotate:
            return LoaderBallMultipleRotateAnimation()              /// 6.ballMultipleRotate
        case .ballRotate:
            return LoaderBallRotateAnimation()                      /// 7.ballRotate
        case .ballBeat:
            return LoaderBallBeatAnimation()                        /// 8.ballBeat
        case .pacman:
            return LoaderPacmanAnimation()                          /// 9.pacman
        case .circleRotate:
            return LoaderCircleRotateAnimation()                  /// 10.circleRotate
        }
    }
}
