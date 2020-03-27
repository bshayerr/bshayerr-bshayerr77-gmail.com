//
//  TutorialVC.swift
//  Madad
//
//  Created by bshayer  on 4/17/18.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController {

    @IBAction func TutorialBtn(_ sender: Any) {
         UIApplication.shared.open(URL(string: "https://www.madad-official.com/how-to-use")! as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
