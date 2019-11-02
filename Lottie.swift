//
//  Lottie.swift
//  Lottie
//
//  Created by Hexagons on 2019-10-13.
//  Copyright © 2019 Hexagons. All rights reserved.
//

import UIKit
import SwiftUI
import Lottie

struct Lottie: UIViewRepresentable {
    
    let name: String
    let color: UIColor
    
    init(_ name: String, over color: UIColor = .clear) {
        self.name = name
        self.color = color
    }
    
    func makeUIView(context: Context) -> LottieView {
        return LottieView(name: name, over: color)
    }
    
    func updateUIView(_ nodeView: LottieView, context: Context) {}
    
}

class LottieView: UIView {
        
    let animationView: AnimationView
        
    init(name: String, over color: UIColor = .clear) {
        
        animationView = AnimationView()
                
        super.init(frame: .zero)
        
        backgroundColor = color
        
        let animation = Animation.named(name)
        animationView.animation = animation
        animationView.loopMode = .loop
        animationView.play()
        addSubview(animationView)
        
        layout()
        
    }
    
    func layout() {

        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        animationView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
