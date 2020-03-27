//
//  ViewController.swift
//  Madad
//
//  Created by bshayer  on 1/31/18.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func CancelBtnPressed(_ sender: Any) {
      dismiss(animated: true, completion: nil)
      //performSegue(withIdentifier: TO_MENU, sender: nil )
    }
    
    /* @IBAction func RateBtnPressed(_ sender: UIButton) {
         sender.pulsate()
         UIApplication.shared.open(URL(string: "itms://")! as URL, options: [:], completionHandler: nil)
    }
     */
     @IBAction func ShareBtnPressed(_ sender: UIButton) {
        let URLstring =  String(format:"https://http://madad-official.com/")
        let urlToShare = URL(string:URLstring)
        let activityViewController = UIActivityViewController(
            activityItems: [urlToShare!],
            applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        //so that ipads won't crash
        present(activityViewController,animated: true,completion: nil)
     }
}
