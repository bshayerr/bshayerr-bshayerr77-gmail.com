//
//  RoundedShadowImageView.swift
//  Madad
//
//  Created by bshayer  on 4/8/18.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import UIKit

class RoundedShadowImageView: UIImageView {

    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 15 //as u like
        self.layer.shadowOpacity = 0.75 // as u like
        self.layer.cornerRadius =  15
    }
}
