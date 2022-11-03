//
//  LOTAnimationView+SM.swift
//  
//
//  Created by Daniel Crespo Duarte on 31/10/22.
//
import Foundation
import Lottie

extension LottieAnimationView {
    
    func loadAnimation(animation: AnimationType) {
        self.loadAnimationName(animationName: animation.name)
    }
    
    private func loadAnimationName(animationName: String) {
        self.animation = LottieAnimation.named(animationName, bundle: .module)
        self.loopMode = .loop
    }
    
    func show() {
        self.play()
        self.isHidden = false
    }
    
    func hide() {
        self.stop()
        self.isHidden = true
    }
}
