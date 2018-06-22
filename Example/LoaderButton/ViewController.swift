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

        view.addSubview(loaderButton)
        loaderButton.frame = CGRect(x: (UIScreen.main.bounds.width - 300) * 0.5,
                                    y: UIScreen.main.bounds.height - 56,
                                    width: 300, height: 40)
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

    @objc private func buttonDidClick(_ sender: LoaderButton) {

        sender.startAnimate(loaderType: .circleChasse, loaderColor: .orange, complete: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sender.stopAnimate(complete: nil)
        }
    }

    private lazy var loaderButton: LoaderButton = {

        let button = LoaderButton(type: .custom)
        button.addTarget(self, action: #selector(buttonDidClick(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor.green
        button.setTitle("TestLoaderButton", for: .normal)
        return button
    }()
}

