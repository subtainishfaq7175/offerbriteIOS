//
//  ViewController.swift
//  Offer Brite
//
//  Created by Ahsan Hameed on 4/19/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var homeTV: UITableView!
    @IBAction func drawer(_ sender: Any) {
        AppUtils.getInstance().setToggle()
    }
    var navTitle:String?
    var selectedItemBG = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        if navTitle != nil {
            self.title = navTitle
        }
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
       homeTV.register(UINib(nibName: IdentifierConstants.XIB_HOME_CELL , bundle: nil), forCellReuseIdentifier: IdentifierConstants.XIB_HOME_CELL)
        homeTV.separatorColor =  UIColor.clear
        selectedItemBG.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierConstants.XIB_HOME_CELL, for: indexPath) as! HomeItemCell
        cell.selectedBackgroundView = selectedItemBG
        cell.likesBtnOL.backgroundColor = UIColor.lightGray
        cell.followedBtnOL.backgroundColor = UIColor.purple
       return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 271.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HomeItemCell
        cell.likesBtnOL.backgroundColor = UIColor.lightGray
        cell.followedBtnOL.backgroundColor = UIColor.purple
        let detailsVC = AppDelegate.getDelegateInstance().storyBoard.instantiateViewController(withIdentifier: IdentifierConstants.SB_HOME_ITEM_DETAILS) as! HomeItemDetails
        let backButton = UIBarButtonItem()
        backButton.tintColor = UIColor.white
        backButton.title = ""
        detailsVC.navTitle = Constants.ITEM_DETAILS_TITLE
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    }

}

