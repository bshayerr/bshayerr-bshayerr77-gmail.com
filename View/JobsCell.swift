//
//  TableViewCell.swift
//  Madad
//
//  Created by bshayer  on 1/26/18.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import UIKit

class JobsCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var JobImage: UIImageView!
    @IBOutlet weak var JobName: UILabel!
    @IBOutlet weak var JobProvider: UILabel!
    
    func updateViews(jobs:Jobs){
        JobImage.image = UIImage(named: jobs.JobImage)
        JobName.text = jobs.JobName
        JobProvider.text = jobs.JobProvider
        
    }
    
}

