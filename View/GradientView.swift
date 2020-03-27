//
//  GradientView.swift
//  Madad
//
//  Created by ohoud on 19/01/2018.
//  Copyright © 2018 ohoud. All rights reserved.
//

import UIKit
@IBDesignable

class GradientView: UIView {
    
    @IBInspectable var topColor: UIColor =  #colorLiteral(red: 0.02213433883, green: 0.4934965583, blue: 0.5935750933, alpha: 1)
        {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var MiddleColor: UIColor =  #colorLiteral(red: 0.3764705882, green: 0.7647058824, blue: 0.7882352941, alpha: 1)
        {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        {
        didSet {
            self.setNeedsLayout()
        }
    }
    override func layoutSubviews(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, MiddleColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.5, y: 1.5)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        
    }}
