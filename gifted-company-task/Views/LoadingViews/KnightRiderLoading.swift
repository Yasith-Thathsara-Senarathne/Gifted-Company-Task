//
//  KnightRiderLoading.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-19.
//

import Foundation
import UIKit

class KnightRiderLoading: BaseView {
    
    var width: CGFloat!
    var color: UIColor!
    
    private var animateBarLayer: CALayer!
    
    override func createViews() {
        animateBarLayer = CALayer()
        animateBarLayer.frame = CGRect.init(origin: .zero, size: CGSize.init(width: 60, height: 1))
        self.layer.addSublayer(animateBarLayer)
    }
    
    override func config() {
        backgroundColor = .clear
    }

    func startAnimation() {
        
        self.isHidden = false
        
        let changeBgAnimation = CAKeyframeAnimation.init(keyPath: "backgroundColor")
        changeBgAnimation.keyTimes = [0,0.5,1]
        changeBgAnimation.values = [UIColor.white.withAlphaComponent(0).cgColor, color.withAlphaComponent(0.8).cgColor,UIColor.white.withAlphaComponent(0).cgColor]
        changeBgAnimation.duration = 1
        changeBgAnimation.autoreverses = true
        changeBgAnimation.repeatCount = 100
        changeBgAnimation.isRemovedOnCompletion = false
        
        animateBarLayer.add(changeBgAnimation, forKey: "change_background")
        
        let changePositionAnimation = CABasicAnimation.init(keyPath: "position.x")
        changePositionAnimation.fromValue = 0.0
        changePositionAnimation.toValue = width - 40
        changePositionAnimation.duration = 1
        changePositionAnimation.isAdditive = true
        changePositionAnimation.autoreverses = true
        changePositionAnimation.repeatCount = 100
        changePositionAnimation.isRemovedOnCompletion = false
        
        animateBarLayer.add(changePositionAnimation, forKey: "change_position")
        
        let changeSizeAnimation = CAKeyframeAnimation.init(keyPath: "bounds.size")
        changeSizeAnimation.values = [CGSize.init(width: 60, height: 1),CGSize.init(width: 70, height: 2),CGSize.init(width: 60, height: 1)]
        changeSizeAnimation.keyTimes = [0,0.5,1]
        changeSizeAnimation.duration = 1
        changeSizeAnimation.autoreverses = true
        changeSizeAnimation.repeatCount = 100
        changeSizeAnimation.isRemovedOnCompletion = false
        
        animateBarLayer.add(changeSizeAnimation, forKey: "change_width")
    }
    
    func stopAnimation(){
        animateBarLayer.removeAllAnimations()
        self.isHidden = true
    }
    
    convenience init(_ width: CGFloat, _ color: UIColor) {
        self.init(frame: .zero)
        self.width = width
        self.color = color
    }
}
