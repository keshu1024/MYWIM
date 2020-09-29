//
//  IndicatorView.swift
//  Rendezvous
//
//  Created by keshu rai on 30/10/19.
//  Copyright © 2019 com.nvest. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class IndicatorView : UIView {
    
    static let shared = IndicatorView()
    
    var loadingAnimation : AnimationView = {
        let lottieView = AnimationView()
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.layer.masksToBounds = true
        return lottieView
    }()
    
    var loadingLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SegoeUI", size: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show(controller : UIViewController) {
        setupLoadingView(controller : controller)

        self.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.isHidden = false
            self.alpha = 1
        }, completion: nil)
        applyLottieAnimation()
    }
    
    public func hide() {
        removeLoadingView()
    }
    
    func applyLottieAnimation() {
        
        let animationToShow = Animation.named("scissor-loader")
        loadingAnimation.animation = animationToShow
        loadingAnimation.animationSpeed = 1.0
        loadingAnimation.loopMode = .loop
        loadingAnimation.contentMode = .scaleAspectFill
        loadingAnimation.play()
        
    }
    
    private func setupLoadingView(controller : UIViewController) {
        
       // UIApplication.shared.keyWindow?.addSubview(self)
        controller.view.addSubview(self)
        self.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        guard let activeWindow = controller.view?.layoutMarginsGuide else {return}
        self.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height + 100).isActive = true
        self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        self.centerXAnchor.constraint(equalTo: activeWindow.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: activeWindow.centerYAnchor).isActive = true
        self.addSubview(loadingAnimation)
        
        loadingAnimation.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loadingAnimation.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingAnimation.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loadingAnimation.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        loadingAnimation.backgroundColor = .clear // UIColor(red: 48/255, green: 72/255, blue: 96/255, alpha: 1.0)
        loadingAnimation.layer.cornerRadius = 20
        loadingAnimation.clipsToBounds = true
        
       
        self.setNeedsLayout()
        self.reloadInputViews()
    }
    
    func removeLoadingView() {
        self.alpha = 1
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
            self.loadingAnimation.stop()
        }, completion: { _ in
            self.isHidden = true
            self.removeFromSuperview()
        })
    }
}
