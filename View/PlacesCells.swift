//
//  PlacesCells.swift
//  Madad
//
//  Created by bshayer  on 1/27/18.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import UIKit

class PlacesCells: UITableViewCell {
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    
    func updateView(Places:Places){
        placeName.text = Places.placeName
        placeImage.image = UIImage(named: Places.placeImage)
    }
}
