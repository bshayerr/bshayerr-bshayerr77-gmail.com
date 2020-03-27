//
//  ButtonsVC.swift
//  Madad
//
//  Created by ohoud on 19/01/2018.
//  Copyright © 2018 GeekLoop. All rights reserved.
//


import UIKit

class HomeVC: UIViewController {
    
    
    
    //buttons
    @IBOutlet weak var CameraBtn: UIButton! 
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var searchBtn: UIBarButtonItem!
    @IBOutlet weak var jobsBtn: UIButton!
    @IBOutlet weak var placesBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
    }
    
    func sideMenus() {
        if revealViewController() != nil {
            menuBtn.target = revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    
    //Actions
    @IBAction func CameraBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CAMERA , sender: nil)
    }
    
    
    
    @IBAction func PlacesBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_PLACES , sender: nil)
    }
    
    
    
    @IBAction func JobsBtnPressed(_ sender: Any) {
         performSegue(withIdentifier: TO_JOBS , sender: nil)
         }
    }


