//
//  HelpVC.swift
//  Madad
//
//  Created by bshayer  on 1/30/18.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    @IBAction func CancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func TwitterBtnPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://mobile.twitter.com/Madadofficial")! as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil) }
    
    
    @IBAction func faqBtnPressed(_ sender: UIButton ) {
        sender.pulsate()
        
        UIApplication.shared.open(URL(string: "http://www.madad-official.com/faq")! as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)    }
    
    
    
    @IBAction func feedbackBtnPressed(_ sender: UIButton ) {
         sender.pulsate()
        
        UIApplication.shared.open(URL(string: "http://www.madad-official.com/contact-us")! as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil) }
    
    
    @IBAction func gmailBtnPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "mailto:madadd.gl@gmail.com")! as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil) }
    
    
    @IBAction func WebsiteBtnPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.madad-official.com")! as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil) }
    
}
   


   


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
