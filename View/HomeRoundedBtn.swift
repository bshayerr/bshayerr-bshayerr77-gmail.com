//
//  RoundedShadowButton.swift
//  Madad
//
//  Created by rihab aldabbagh on 20/01/2018.
//  Copyright © 2018 ohoud. All rights reserved.
//

import UIKit

class HomeRoundedBtn: UIButton {
    
    //desgin button
    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 20
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.cornerRadius = 7
    }
    
    //animate button
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
   
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5 , initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
               self.transform = CGAffineTransform.identity
        }, completion: nil)
    }*/
    
}
