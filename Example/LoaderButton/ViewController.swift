//
//  ViewController.swift
//  LoaderButton
//
//  Created by Jovins on 06/21/2018.
//  Copyright (c) 2018 Jovins. All rights reserved.
//

import UIKit
import LoaderButton

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func loaderButtonDidClick(_ sender: LoaderButton) {

        let types: [LoaderType] = [.rotateChase, .lineFade, .circleChasse, .circleNarrow, .ballPulse,
                                   .ballPulseRotate, .ballMultipleRotate, .ballRotate,
                                   .ballBeat, .pacman, .circleRotate]
        sender.startAnimate(loaderType: types[sender.tag], loaderColor: .white, complete: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sender.stopAnimate(complete: nil)
        }
    }
}

