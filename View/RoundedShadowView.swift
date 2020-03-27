//
//  RoundedShadowView.swift
//  Madad
//
//  Created by bshayer  on 4/8/18.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {

    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 15 //as u like
        self.layer.shadowOpacity = 0.75 // as u like
        self.layer.cornerRadius = self.frame.height / 2
    }

}
