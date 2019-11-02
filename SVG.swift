//
//  SVG.swift
//  SVG
//
//  Created by Hexagons on 2019-10-13.
//  Copyright © 2019 Hexagons. All rights reserved.
//

import UIKit
import SwiftUI
import WebKit

struct SVG: UIViewRepresentable {
    
    let name: String
    let color: UIColor
    let size:CGSize?
    let placement: SVGPlacement
    
    init(_ name: String, over color: UIColor = .white,
         size:CGSize? = nil, at placement: SVGPlacement = .aspectFit) {
        self.name = name
        self.color = color
        self.size = size
        self.placement = placement
    }
    
    func makeUIView(context: Context) -> SVGView {
        return SVGView(name: name, over: color, size:size,  at: placement)
    }
    
    func updateUIView(_ nodeView: SVGView, context: Context) {}
    
}

public enum SVGPlacement {
    case aspectFit
    case scaleFit(CGFloat)
    case aspectFill
    case center
    case fill
}

class SVGView: UIView {
    
    let name: String
    let html: String
    
    let webView: WKWebView
    
    let size: CGSize
    let localSize: CGSize?
    
    let placement: SVGPlacement
    
    var widthLayoutConstraint: NSLayoutConstraint!
    var heightLayoutConstraint: NSLayoutConstraint!
    
    init(name: String, over color: UIColor = .white,
         size:CGSize? = nil, at placement: SVGPlacement = .aspectFit) {
        
        self.name = name
        
        webView = WKWebView()
        
        localSize = size
        
        self.placement = placement
        
        let ciColor = CIColor(color: color)
        let r = Int(ciColor.red * 255)
        let g = Int(ciColor.green * 255)
        let b = Int(ciColor.blue * 255)
        
        let url = Bundle.main.url(forResource: name, withExtension: "svg")!
        let data = try! Data(contentsOf: url)
        let text = String(data: data, encoding: .utf8)!
        html = "<html style=\"background-color: rgb(\(r),\(g),\(b));\">\(text)</html>"
        
        let raw1 = text.components(separatedBy: "viewBox")
        guard raw1.count >= 2 else { assert(false, "svg viewBox not found") }
        let raw2 = raw1[1].components(separatedBy: "\"")
        guard raw2.count >= 2 else { assert(false, "svg viewBox quotes not found") }
        let raw3 = raw2[1].components(separatedBy: " ")
        guard raw3.count == 4 else { assert(false, "svg viewBox numbers not found") }
        guard let w = Double(raw3[2]) else { assert(false, "svg viewBox width not found") }
        guard let h = Double(raw3[3]) else { assert(false, "svg viewBox height not found") }
        self.size = CGSize(width: w, height: h)
        
        super.init(frame: CGRect(origin: .zero, size: localSize ?? .zero))
        
        backgroundColor = color
        
        webView.loadHTMLString(html, baseURL: URL(string: "http://hexagons.se/"))
        webView.isUserInteractionEnabled = false
        addSubview(webView)
        
        layout()
        
    }
    
    func layout() {

        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        webView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        widthLayoutConstraint = webView.widthAnchor.constraint(equalToConstant: 0)
        widthLayoutConstraint.isActive = true
        heightLayoutConstraint = webView.heightAnchor.constraint(equalToConstant: 0)
        heightLayoutConstraint.isActive = true

    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutPlacement()
    }
        
    func layoutPlacement() {
        
        let bounds = localSize ?? self.bounds.size
        
        guard bounds.width > 0 else { return }
        
        let svgAspect = size.width / size.height
        let viewAspect = bounds.width / bounds.height
        let combinedAspect = svgAspect / viewAspect
        let dynamicAspect = svgAspect > viewAspect ? combinedAspect : 1 / combinedAspect
        
        let width: CGFloat
        let height: CGFloat
        var scale: CGFloat = 1.0
        switch placement {
        case .aspectFit:
            width = svgAspect >= viewAspect ? bounds.width : bounds.width / dynamicAspect
            height = svgAspect <= viewAspect ? bounds.height : bounds.height / dynamicAspect
        case .scaleFit(let s):
            width = svgAspect >= viewAspect ? bounds.width * s : (bounds.width / dynamicAspect) * s
            height = svgAspect <= viewAspect ? bounds.height * s : (bounds.height / dynamicAspect) * s
            scale = s
        case .aspectFill:
            width = svgAspect <= viewAspect ? bounds.width : bounds.width * dynamicAspect
            height = svgAspect >= viewAspect ? bounds.height : bounds.height * dynamicAspect
        case .center:
            width = size.width
            height = size.height
        case .fill:
            width = bounds.width
            height = bounds.height
        }
        
        widthLayoutConstraint.constant = width
        heightLayoutConstraint.constant = height
        webView.transform = CGAffineTransform.identity.scaledBy(x: 1 / scale, y: 1 / scale)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
