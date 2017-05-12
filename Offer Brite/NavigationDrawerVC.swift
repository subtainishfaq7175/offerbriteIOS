//
//  NavigationDrawerVC.swift
//  Bounce Fitness (Trainer)
//
//  Created by Ahsan Hameed on 1/11/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import UIKit

class NavigationDrawerVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var firstSectionData = [DrawerItemModel]()
    var secondSectionData = [DrawerItemModel]()

//    these are temp data must be removed
    let sectionFirst = 1
    let sectionSecond = 2
    let sectionHeaders = ["Home","About"]

    var staticDrawerFirstSection = [String]()
    let staticDrawerFirstSectionIds = [1,2,3]

    let staticDrawerSecondSection = ["Privacy Policy","Terms and Conditions","App Version"]
    let staticDrawerSecondSectionIds = [4,5,6]


    @IBOutlet weak var percentageLable: UILabel!
    @IBOutlet weak var profilePercentage: UIProgressView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var drawerTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIsUserLogin()
        userImage.layer.masksToBounds = true
        userImage.layer.borderColor = UIColor.lightGray.cgColor
        userImage.layer.borderWidth = Constants.VALUE_ONE_CGF
        userImage.layer.cornerRadius = self.userImage.frame.size.height / Constants.VALUE_TWO_CGF
        drawerTV.register(UINib(nibName: IdentifierConstants.XIB_DRAWER_CELL , bundle: nil), forCellReuseIdentifier: IdentifierConstants.XIB_DRAWER_CELL)
        firstSectionData = loadData(sectionFirst)
        secondSectionData = loadData(sectionSecond)
    }
    func checkIsUserLogin()  {
        if UserDefaultsData.getBool(DefaultDataConstants.IS_USER_LOGIN){
            staticDrawerFirstSection = ["Home","Liked","Followed"]
            userName.text = UserDefaultsData.getString(DefaultDataConstants.USER_NAME)
            profilePercentage.progress = (Float (UserDefaultsData.getInteger(DefaultDataConstants.PROFILE_PERCENTAGE))/Float(Constants.VALUE_HUNDRAD_INT))
            percentageLable.text = "\(UserDefaultsData.getInteger(DefaultDataConstants.PROFILE_PERCENTAGE))%"
        }else {
            staticDrawerFirstSection = ["Home"]
            percentageLable.isHidden = true
            profilePercentage.isHidden = true
            userName.text = Constants.APP_NAME

        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func loadData(_ section:Int) -> [DrawerItemModel] {
        var dataArray:[String]?
        var dataIds = [Int]()
        var items = [DrawerItemModel]()
        if section == self.sectionFirst{
            dataArray = staticDrawerFirstSection
            dataIds = staticDrawerFirstSectionIds
        }else {
            dataArray = staticDrawerSecondSection
            dataIds = staticDrawerSecondSectionIds

        }
        for var i in (0..<(dataArray?.count)!) {
            let item = DrawerItemModel(dataArray![i], id: dataIds[i])
            items.append(item)
            
        }
        return items
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return self.sectionHeaders[section]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var centerNavController:UINavigationController?
        let appDelegate = AppDelegate.getDelegateInstance()
        if indexPath.section == Constants.VALUE_ZERO_INT{
            if self.firstSectionData[indexPath.row].id == Constants.VALUE_ONE_INT{
                let secondViewController = appDelegate.storyBoard.instantiateViewController(withIdentifier: IdentifierConstants.SB_VIEW_CONTROLLER) as! ViewController
                secondViewController.navTitle = self.firstSectionData[indexPath.row].drawerItemLabel!
                centerNavController = UINavigationController(rootViewController: secondViewController)
            }else if self.firstSectionData[indexPath.row].id == Constants.VALUE_TWO_INT {
                let secondViewController = appDelegate.storyBoard.instantiateViewController(withIdentifier: IdentifierConstants.SB_LIKED_VC) as! Liked
                secondViewController.navTitle = self.firstSectionData[indexPath.row].drawerItemLabel!
                centerNavController = UINavigationController(rootViewController: secondViewController)
            } else {
                let secondViewController = appDelegate.storyBoard.instantiateViewController(withIdentifier: IdentifierConstants.SB_FOLLOWED_VC) as! Followed
                secondViewController.navTitle = self.firstSectionData[indexPath.row].drawerItemLabel!
                centerNavController = UINavigationController(rootViewController: secondViewController)
            }
        } else if indexPath.section == Constants.VALUE_ONE_INT {
            if self.secondSectionData[indexPath.row].id == Constants.VALUE_FOUR_INT{
                let secondViewController = appDelegate.storyBoard.instantiateViewController(withIdentifier: IdentifierConstants.SB_PRIVACY_POLICY_VC) as! PrivacyPolicy
                secondViewController.navTitle = self.secondSectionData[indexPath.row].drawerItemLabel!
                centerNavController = UINavigationController(rootViewController: secondViewController)
            }else if self.secondSectionData[indexPath.row].id == Constants.VALUE_FIVE_INT {
                let secondViewController = appDelegate.storyBoard.instantiateViewController(withIdentifier: IdentifierConstants.SB_TERM_COND_VC) as! TermsConditions
                secondViewController.navTitle = self.secondSectionData[indexPath.row].drawerItemLabel!
                centerNavController = UINavigationController(rootViewController: secondViewController)
            } else {
                let secondViewController = appDelegate.storyBoard.instantiateViewController(withIdentifier: IdentifierConstants.SB_APP_VERSION_VC) as! AppVersion
                secondViewController.navTitle = self.secondSectionData[indexPath.row].drawerItemLabel!
                centerNavController = UINavigationController(rootViewController: secondViewController)
            }
        }
        if centerNavController != nil {
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggle(appDelegate.drawerSide, animated: true, completion: nil)
        }    

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.VALUE_TWO_INT
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Constants.VALUE_ZERO_INT {
            return (self.firstSectionData.count)
        }
        else {
            return self.secondSectionData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierConstants.XIB_DRAWER_CELL, for: indexPath) as! DrawerItemCell
        if indexPath.section == Constants.VALUE_ZERO_INT{
            cell.itemLabel.text = firstSectionData[indexPath.row].drawerItemLabel

        }else {
            cell.itemLabel.text = secondSectionData[indexPath.row].drawerItemLabel

        }
        return cell
    }


}
