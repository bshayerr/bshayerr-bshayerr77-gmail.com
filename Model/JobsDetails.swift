//
//  File.swift
//  Madad
//
//  Created by bshayer  on 1/28/18.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import Foundation

struct JobsDetails {
    
    // Private in "setting" cause we dont want the data to be set by someone for "Protection"
    // Public in getting to be shown and retrieveing publicly
    private(set) public var TitleLbl: String
    private(set) public var ContentLbl: String
    
    
    // Initializing the stored labels
    init( TitleLbl: String,  ContentLbl: String ){
        self.TitleLbl = TitleLbl
        self.ContentLbl = ContentLbl
        
    }
}

