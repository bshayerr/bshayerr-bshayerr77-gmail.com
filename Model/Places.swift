//
//  Places.swift
//  Madad
//
//  Created by bshayer  on 1/27/18.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import Foundation

struct Places {
    private(set) public var placeName: String
    private(set) public var placeImage: String

    init(placeName: String, placeImage: String ){
        self.placeName = placeName
        self.placeImage = placeImage
    }
}
