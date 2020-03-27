//
//  Jobs.swift
//  Madad
//
//  Created by bshayer  on 1/27/18.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import Foundation

struct Jobs {
    private(set) public var JobName: String
    private(set) public var JobProvider: String
    private(set) public var JobImage: String
    private(set) public var catg: gender
   
    init(jobName: String,  jobProvider: String, jobImage: String, catg:  gender){
        self.JobName = jobName
        self.JobProvider = jobProvider
        self.JobImage = jobImage
        self.catg = catg
    }
}
    
    enum gender: String {
        case fem = "Females"
        case mal = "Males"
    }


