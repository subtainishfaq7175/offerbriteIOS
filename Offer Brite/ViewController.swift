//
//  ViewController.swift
//  Offer Brite
//
//  Created by Ahsan Hameed on 4/19/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var homeTV: UITableView!
    @IBAction func drawer(_ sender: Any) {
        AppUtils.getInstance().setToggle()
    }
    var indicatorView = UIView()
    var offerData = [OfferModel]()
    var navTitle:String?
    var selectedItemBG = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTV.isHidden = true
        indicatorView = AppUtils.getInstance().genActivityIndicatorView(self, message: Constants.LOADING)
        if navTitle != nil {
            self.title = navTitle
        }
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
       homeTV.register(UINib(nibName: IdentifierConstants.XIB_HOME_CELL , bundle: nil), forCellReuseIdentifier: IdentifierConstants.XIB_HOME_CELL)
        homeTV.separatorColor =  UIColor.clear
        selectedItemBG.backgroundColor = UIColor(white: 1, alpha: 0.5)
        loadData()
    }
    
    func customToast(_ message:String)  {
        AppUtils.getInstance().makeToast(forView: self, message: message, seconds: Constants.TOAST_SHORT_TIME)
    }
    func loadData()  {
        if Reachability.isConnectedToNetwork(){
            view.addSubview(indicatorView)
            Alamofire.request(ServerConstants.ALL_OFFERS, method: .get)
                .responseObject{
                    (response: DataResponse<ResOffers>) in
                    self.indicatorView.removeFromSuperview()
                    switch response.result{
                    case .success:
                        if let data = response.result.value{
                            if data.isResponse! {
                                if data.data != nil {
                                    self.homeTV.isHidden = false
                                    self.offerData = data.data!
                                    self.homeTV.reloadData()
                                }
                            }
                            if data.responseMessage != nil {
                                self.customToast(data.responseMessage!)
                            }
                        }
                        break
                    case .failure:
                        if (response.result.error?.localizedDescription) != nil {
                            self.customToast((response.result.error?.localizedDescription)!)
                        }
                        break
                    }
            }
            
        }else{
            if indicatorView.tag == Constants.INDICATOR_TAG_ID {
                indicatorView.removeFromSuperview()
            }
            noInternet()
        }
    }
    
    func noInternet() {
        var alertAction = UIAlertAction()
        alertAction = UIAlertAction(title:  Constants.YES , style: UIAlertActionStyle.default) { (a:UIAlertAction) in
         self.loadData()
        }
        let alertActionNo:UIAlertAction = UIAlertAction(title: Constants.NO, style: UIAlertActionStyle.default) { (a:UIAlertAction) in
        }
        AppUtils.getInstance().setAlert(alert: self, title: Constants.NO_INTERNET_TITLE, message: Constants.NO_INTERNET_MSG, alertAction: alertAction, alertActionNo: alertActionNo)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierConstants.XIB_HOME_CELL, for: indexPath) as! HomeItemCell
        
        cell.selectedBackgroundView = selectedItemBG
        cell.likesBtnOL.backgroundColor = UIColor.lightGray
        cell.followedBtnOL.backgroundColor = UIColor.purple
        let row = indexPath.row
        if offerData[row].title != nil {
            cell.offerTitle.text = offerData[indexPath.row].title

        }else{
            cell.offerTitle.text = Constants.EMPTY_STRING

        }
        if offerData[row].totalLikes != nil {
            cell.likesBtnOL.setTitle("\(offerData[row].totalLikes!)\(Constants.LIKES)", for: .normal)
            
        }else{
            cell.likesBtnOL.setTitle("\(Constants.VALUE_ZERO_STR)\(Constants.LIKES)", for: .normal)
            
        }
        if offerData[row].totalFollows != nil {
            cell.followedBtnOL.setTitle("\(offerData[row].totalFollows!)\(Constants.FOLLOWS)", for: .normal)
            
        }else{
            cell.followedBtnOL.setTitle("\(Constants.VALUE_ZERO_STR)\(Constants.FOLLOWS)", for: .normal)
            
        }
        let url:URL?
        if offerData[row].banner != nil {
             url = URL(string:  offerData[row].banner!)
        }else {
            url = URL(string:  Constants.EMPTY_STRING)
 
        }
        cell.offerBanner.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "home_page_item"), options: [.continueInBackground, .progressiveDownload])
       return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.size.height / Constants.VALUE_TWO_CGF) 
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offerData.count
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
        detailsVC.offerId = "\(offerData[indexPath.row].id)"
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    }

}

