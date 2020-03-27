//
//  YourPlacesVC.swift
//  Madad
//
//  Created by bshayer  on 2/1/18.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import UIKit

class MyPlacesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var PlacesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PlacesTable.delegate = self
        PlacesTable.dataSource = self
    }
    
    @IBAction func CancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int
    { return DataService.instance.getPlaces().count }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cells = tableView.dequeueReusableCell(withIdentifier: "Pcells") as? PlacesCells {
            let Places = DataService.instance.getPlaces()[indexPath.row]
            cells.updateView(Places: Places)
            return cells
        }  else {
            return  PlacesCells()
        }
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat
    { return 50 }
}





