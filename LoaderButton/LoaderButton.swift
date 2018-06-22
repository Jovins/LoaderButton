//
//  LoaderButton.swift
//  LoaderButton
//
//  Created by 黄进文 on 2018/6/11.
//  Copyright © 2018年 Jovins. All rights reserved.
//

import UIKit


// MARK: - CAGradientLayer
extension CAGradientLayer {

    convenience init(frame: CGRect) {
        self.init()
        self.frame = frame
    }
}

// MARK: - LoaderButton
open class LoaderButton: UIButton {

    // MARK: - Properties
    internal var loaderTitle: String?
    internal var loaderBackgroundNormalImage: UIImage?
    internal var loaderBackgroundSelectedImage: UIImage?
    internal var loaderBackgroundDisabledImage: UIImage?
    internal var loaderBackgroundHighlightedImage: UIImage?
    internal var loaderNormalImage: UIImage?
    internal var loaderSelectedImage: UIImage?
    internal var loaderDisabledImage: UIImage?
    internal var loaderHighlightedImage: UIImage?
    internal var loaderBackgroundColor: UIColor?

    fileprivate var animationDuration: CFTimeInterval = 0.25
    fileprivate var isAnimating: Bool = false
    fileprivate var loaderType: LoaderType = .rotateChase

    @IBInspectable var cornerRadius: CGFloat = 0 {
        willSet {
            layer.cornerRadius = newValue
        }
    }

    public var loaderColor: UIColor = UIColor.gray
    public var title: String? {
        get {
            return self.title(for: .normal)
        }
        set {
            self.setTitle(newValue, for: .normal)
        }
    }

    // MARK: - Initializers
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        gradientLayer.frame = self.bounds
    }

    // MARK: - Method
    func setup() {

        if self.cornerRadius == 0 {
            self.cornerRadius = self.layer.cornerRadius
        }
        self.layer.cornerRadius = self.cornerRadius
        self.layer.masksToBounds = true
        if self.image(for: .normal) != nil && self.title != nil {

            let space: CGFloat = 10
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: space)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: space, bottom: 0, right: 0)
        }
    }

    // MARK: lazy
    internal lazy var gradientLayer: CAGradientLayer = {

        let gradient = CAGradientLayer(frame: self.frame)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }()
    public var gradientColors: [UIColor]? {
        willSet {
            gradientLayer.colors = newValue?.map({$0.cgColor})
        }
    }
}

// MARK: - Animation
public extension LoaderButton {

    // MARK: - Public Method
    /// Start Animation
    ///
    /// - Parameters:
    /// - LoaderType: Loader Type ( rotateChase(default), lineFade, circleStroke)
    /// - loader color: color of loader (default = gray)
    /// - complete: complation block (call after animation start)
    public func startAnimate(loaderType: LoaderType = .rotateChase, loaderColor: UIColor = .gray, complete: (() -> Void)?) {

        if self.cornerRadius == 0 {
            self.cornerRadius = self.layer.cornerRadius
        }
        self.stopAnimation()
        isAnimating = true
        self.loaderColor = loaderColor
        self.loaderType = loaderType
        self.layer.cornerRadius = self.frame.height * 0.5
        self.collapseAnimation(complete: complete)
    }

    /// stop Animation and set button in actual state
    ///
    /// - Parameter complete: complation block (call after animation Stop)
    public func stopAnimate(complete: (() -> Void)?) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

            self.backToDefault(complete: complete)
        }
    }

    // MARK: - Private Method
    /// stop animation of specific loader
    private func stopAnimation() {
        for item in layer.sublayers! where item is LoaderLayer {
            item.removeAllAnimations()
            item.removeFromSuperlayer()
        }
    }

    /// collapse animation
    private func collapseAnimation(complete: (() -> Void)?) {

        loaderTitle = title
        title = ""
        loaderBackgroundNormalImage = self.backgroundImage(for: .normal)
        loaderBackgroundSelectedImage = self.backgroundImage(for: .selected)
        loaderBackgroundDisabledImage = self.backgroundImage(for: .disabled)
        loaderBackgroundHighlightedImage = self.backgroundImage(for: .highlighted)
        loaderNormalImage = self.image(for: .normal)
        loaderDisabledImage = self.image(for: .disabled)
        loaderSelectedImage = self.image(for: .selected)
        loaderHighlightedImage = self.image(for: .highlighted)
        loaderBackgroundColor = self.backgroundColor
        self.setImage(nil, for: .normal)
        self.setImage(nil, for: .disabled)
        self.setImage(nil, for: .selected)
        self.setImage(nil, for: .highlighted)
        isUserInteractionEnabled = false
        let animation = CABasicAnimation(keyPath: "bounds.size.width")
        animation.fromValue = bounds.width
        animation.toValue = bounds.height
        animation.duration = animationDuration
        animation.fillMode = kCAFillModeBoth
        animation.isRemovedOnCompletion = false
        layer.add(animation, forKey: animation.keyPath)
        self.perform(#selector(startLoader), with: nil, afterDelay: animationDuration)
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {

            if complete != nil {
                complete!()
            }
        }
    }

    /// back to default
    private func backToDefault(complete: (() -> Void)?) {

        if !isAnimating {
            return
        }
        self.stopAnimation()
        setTitle(loaderTitle, for: .normal)
        self.setBackgroundImage(self.loaderNormalImage, for: .normal)
        self.setBackgroundImage(self.loaderDisabledImage, for: .disabled)
        self.setBackgroundImage(self.loaderSelectedImage, for: .selected)
        self.setBackgroundImage(self.loaderHighlightedImage, for: .highlighted)
        self.setImage(self.loaderNormalImage, for: .normal)
        self.setImage(self.loaderDisabledImage, for: .disabled)
        self.setImage(self.loaderSelectedImage, for: .selected)
        self.setImage(self.loaderHighlightedImage, for: .highlighted)
        isUserInteractionEnabled = true

        let animation = CABasicAnimation(keyPath: "bounds.size.width")
        animation.fromValue = frame.height
        animation.toValue = frame.width
        animation.duration = animationDuration
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false

        layer.add(animation, forKey: animation.keyPath)
        isAnimating = false
        self.layer.cornerRadius = self.cornerRadius
        if complete != nil {
            complete!()
        }
    }

    /// start laoding
    @objc private func startLoader() {

        let animation: LoaderButtonAnimationDelegate = self.loaderType.animation()
        animation.setupLoaderButtonAnimation(layer: self.layer, frame: self.bounds, color: self.loaderColor)
    }
}
