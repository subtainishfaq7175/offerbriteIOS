//
//  Liked.swift
//  Offer Brite
//
//  Created by Ahsan Hameed on 4/20/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import UIKit

class Liked: UIViewController {
    var navTitle:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if navTitle != nil {
            self.title = navTitle
        }        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
