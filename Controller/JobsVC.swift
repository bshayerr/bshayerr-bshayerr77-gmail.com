//
//  JobsVC.swift
//  Madad
//
//  Created by bshayer  on 1/26/18.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import UIKit

class JobsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    
 ///----------------- <<< OUTLETS & VARIBLES >>> -----------------///
    
    // View Controller Labels
    @IBOutlet weak var JobsTable: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!

    var jobsArray = [Jobs]() // to store the data
    var currentJobsArray = [Jobs]() //to update data after a user do search

    
    
    
///----------------- <<< LOAD THE FUNCTIONS INTO VIEW >>> -----------------///

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpJobs()
        setUpSearchBar()
        alterLayout()
    }
    
    
    
    ///----------------- <<< ADD JOB SECTION >>> -----------------///
    
    @IBAction func AddJobsBtnPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://www.madad-official.com/add-job")! as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    
  
    
    
   ///----------------- <<< TABEL VIEW SECTION >>> -----------------///
 
    //connect jobs data with jobs VC, and put the data inside the jobsArray var
    
    private func setUpJobs() {
    JobsTable.delegate = self
    JobsTable.dataSource = self
    jobsArray = DataService.instance.getJobs()
    currentJobsArray = jobsArray
    }
    
    
    //- 1: UITabelViewFunction: To specify the number of rows "cells" in the table view
    
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int
    {   return currentJobsArray.count
       //or -> return DataService.instance.getJobs().count
          }
    
    
    //- 2: UITabelViewFunction: To add the data to each row "cell" in the tabel
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? JobsCell {
           let jobs = currentJobsArray[indexPath.row]
           
            // To make the cell corner looks convexyyy
            cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
            
            // To update the cell view when new data is been added
            cell.updateViews(jobs: jobs)
            return cell
              }  else   {
                 return JobsCell() } }
    
    
    // 3: UITabelViewFunction: To Fix the size of cells, so its cannot be bigger or smaller
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat
    { return 90 }
    
    
    // 4: UITabelViewFunction: To show the Details View Controller when the user press on a Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jobs = currentJobsArray[indexPath.row]
        performSegue(withIdentifier: "toJobDetails", sender: jobs )
    }
    
    
    // 5: UITabelViewFunction: To animate the Jobs Table in a faded way
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //1. Set initial state of cell
        cell.alpha = 0
        let Transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20 , 0)
        cell.layer.transform = Transform
        
        //2. Use UIView animation method to change the final state of cell
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    
    
    // To pass the data to JobsDetails View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DestinationVC = segue.destination as? JobDetailsVC {
            assert(sender as? Jobs != nil) //make sure the cell isnt empty 
            DestinationVC.initJobsDetails(jobs: sender as! Jobs)
        }
        
    }
    
    
  
    
    ///----------------- <<< SEARCH BAR SECTION >>> -----------------///
    
    private func setUpSearchBar() {
        SearchBar.delegate = self }
    
    func alterLayout() {
        // to make search bar in section header!
        JobsTable.tableHeaderView = UIView()
        JobsTable.estimatedSectionHeaderHeight = 50
        navigationItem.titleView = SearchBar
        SearchBar.placeholder = "Search Job by Name"
        SearchBar.showsScopeBar = false //hide the scope bar cause it changes the layout
        
    }
    
    // Search Bar 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentJobsArray = jobsArray.filter({ jobs -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty { return true }
                return jobs.JobName.lowercased().contains(searchText.lowercased())
            case 1:
                if searchText.isEmpty { return jobs.catg == .fem }
                return jobs.JobName.lowercased().contains(searchText.lowercased()) &&
                    jobs.catg  == .fem
            case 2:
                if searchText.isEmpty { return jobs.catg == .mal }
                return jobs.JobName.lowercased().contains(searchText.lowercased()) &&
                    jobs.catg == .mal
            default:
                return false
            }
        })
        JobsTable.reloadData()
    }
    
    
    // select a scope based on numbers, 1 is for showing females and 2 for males.. while 0 is for showing both togther
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentJobsArray = jobsArray
        case 1:
            currentJobsArray = jobsArray.filter({ jobs -> Bool in
                jobs.catg == gender.fem
            })
        case 2:
             currentJobsArray = jobsArray.filter({ jobs -> Bool in
                 jobs.catg == gender.mal
            })
        default:
            break
        }
        JobsTable.reloadData()
    }
}





    


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
