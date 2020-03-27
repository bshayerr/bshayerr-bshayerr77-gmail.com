//
//  HomePageVC.swift
//  Madad
//
//  Created by ohoud on 19/01/2018.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {
    
   //@IBAction func prepareForUnwind(for segue: UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 100
    }
    
    //Actions
 
    @IBAction func AboutBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_ABOUT , sender: nil) 
    }
    
    @IBAction func HelpBtnPressed(_ sender: Any) {
         performSegue(withIdentifier: TO_HELP , sender: nil)
    }
    
    @IBAction func MyMadadBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_MYPLACES , sender: nil)
    }
    
}


