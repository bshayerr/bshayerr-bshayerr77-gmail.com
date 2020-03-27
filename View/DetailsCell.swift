//
//  JobDetailCell.swift
//  Madad
//
//  Created by bshayer  on 2/6/18.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {

    
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var ContetnLbl: UILabel!
  
    func UpdateViews(jobDetails: JobsDetails ) {
        TitleLbl.text = jobDetails.TitleLbl
        ContetnLbl.text = jobDetails.ContentLbl
    }
}
