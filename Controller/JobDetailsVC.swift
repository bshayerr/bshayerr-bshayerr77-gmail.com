//
//  JobDetailsVC.swift
//  Madad
//
//  Created by bshayer  on 1/26/18.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import UIKit

class JobDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var DetailsTable: UITableView!

    private(set) public var jobDetails = [JobsDetails]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DetailsTable.dataSource = self
        DetailsTable.delegate = self
      }
    
    
     // 1: UITabelViewFunction: To specify the number of rows "cells" in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              // it means: count number of data in array and return it as row numbers
              // return DataService.instance.getJobDetails1().count
              return jobDetails.count }
    
    
     // 2: UITabelViewFunction: To add the data to each row "cell" in the tabel
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as? DetailsCell {
            let jobDetails = self.jobDetails[indexPath.row]
            cell.UpdateViews(jobDetails: jobDetails) // To update the cell view
            return cell }
        else   { return DetailsCell()  }
    }
    
    
    
     // 3: UITabelViewFunction: To Fix the size of cells, so its cannot be bigger or smaller
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat
    { return 110 }
    
    
    
    // 4: UITabelViewFunction: To animate the Jobs Table in a faded way
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1.0 }
    }
    
    
    
   // initialise the content of jobsDetailsVC depend on the name of job that been selected in JobsVC
   func initJobsDetails(jobs: Jobs) {
    jobDetails = DataService.instance.getJobDetails(forJobsName: jobs.JobName)
    }
}
