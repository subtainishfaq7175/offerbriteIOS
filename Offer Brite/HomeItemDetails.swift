//
//  HomeItemDetails.swift
//  Offer Brite
//
//  Created by Ahsan Hameed on 4/26/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import UIKit
import Alamofire
class HomeItemDetails: UIViewController, UIScrollViewDelegate {
    var navTitle:String?
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainScroller: UIScrollView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var itemContent: UITextView!
    @IBOutlet weak var additionalLabel: UILabel!
    @IBOutlet weak var additionalContent: UITextView!
    @IBOutlet weak var bottomView: UIView!
    @IBAction func likes(_ sender: Any) {
    }
    @IBAction func follows(_ sender: Any) {
    }
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var followsOL: UIButton!
    @IBOutlet weak var likesOL: UIButton!
    @IBOutlet weak var offerTitle: UILabel!
    @IBOutlet weak var startEndTime: UILabel!
    @IBOutlet weak var startEndDate: UILabel!
    @IBOutlet weak var termConditionsLable: UILabel!
    var offerId:String?
    var indicatorView = UIView()
    let util:AppUtils = AppUtils.getInstance()
    var mainViewHeightConstant = Constants.VALUE_ZERO_CGF
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView = AppUtils.getInstance().genActivityIndicatorView(self, message: Constants.LOADING)
        if navTitle != nil {
            self.title = navTitle
        }
        mainView.isHidden = true
        additionalLabel.isHidden = true
        additionalContent.isHidden = true
        navigationController?.navigationBar.tintColor = .white
        self.mainScroller.delegate = self
        self.mainScroller.isScrollEnabled = true
        if offerId != Constants.EMPTY_STRING {
            loadDetailsData(offerId!)
        }
    }
    func getDynamicSizForTextView(_ textView:UITextView, content:String) -> CGSize {
        var frame =  textView.frame
        textView.text = content
        let contentSize = textView.sizeThatFits(textView.frame.size)
        mainViewHeightConstant = mainViewHeightConstant + contentSize.height
        frame.size.height = contentSize.height
        textView.frame =  frame
        return  CGSize(width: frame.size.width, height: frame.size.height)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    func setMainViewHeight() {
//        let constant = topView.frame.height + bottomView.frame.height + 20.0
        let mainConstraint = NSLayoutConstraint(item: mainView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: mainViewHeightConstant)
        self.view.addConstraint(mainConstraint)
    }
    override func viewWillLayoutSubviews() {

    }
    func customToast(_ message:String)  {
        AppUtils.getInstance().makeToast(forView: self, message: message, seconds: Constants.TOAST_SHORT_TIME)
    }
    func loadDetailsData(_ offerId:String)  {
        if Reachability.isConnectedToNetwork(){
            view.addSubview(indicatorView)
            let url = "\(ServerConstants.OFFER_DETAILS)\(offerId)"
            Alamofire.request(url, method: .get)
                .responseObject{
                    (response: DataResponse<ResOfferDetails>) in
                    self.indicatorView.removeFromSuperview()
                    switch response.result{
                    case .success:
                        if let data = response.result.value{
                            if data.isResponse! {
                                if data.data != nil {
                                    self.setData(data.data!)
                                    
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
            self.loadDetailsData(self.offerId!)

        }
        let alertActionNo:UIAlertAction = UIAlertAction(title: Constants.NO, style: UIAlertActionStyle.default) { (a:UIAlertAction) in
        }
        AppUtils.getInstance().setAlert(alert: self, title: Constants.NO_INTERNET_TITLE, message: Constants.NO_INTERNET_MSG, alertAction: alertAction, alertActionNo: alertActionNo)
    }
    func setStartEndString(_ start:String?, end:String?, starter:String) -> String{
        var startEndText:String?
        if start != nil && start  != Constants.EMPTY_STRING {
            startEndText?.append(start!)
            startEndText?.append(Constants.TO_STR)
        }
        
        if end != nil && end != Constants.EMPTY_STRING {
            startEndText?.append(end!)
        }
        if startEndText != nil  {
            return startEndText!
        }else {
            return Constants.NA_STR
        }
    }
    func incMainViewHeight(_ height:CGFloat){
        mainViewHeightConstant = mainViewHeightConstant + height

    }
    func setData(_ data:OfferModel) {
        catName.text = util.checkStringData(data.title)
        offerTitle.text = util.checkStringData(data.title)
        var bannerUrl:URL?
        if util.checkStringData(data.banner) == Constants.NA_STR {
            bannerUrl = URL(string: Constants.EMPTY_STRING)
        }else {
            bannerUrl = URL(string: data.banner!)
 
        }
    
        mainImage.sd_setImage(with: bannerUrl, placeholderImage: #imageLiteral(resourceName: "home_page_item"), options: [.progressiveDownload, .continueInBackground])
        
        startEndDate.text = setStartEndString(data.startDate, end: data.endDate, starter:Constants.DATE_STR)
        startEndTime.text = setStartEndString(data.starthours, end: data.endHours, starter:Constants.TIME_STR)
        incMainViewHeight(topView.frame.size.height)
        incMainViewHeight((getDynamicSizForTextView(itemContent, content: util.checkStringData(data.description))).height)
        if util.checkStringData(data.additionalInformation) != Constants.NA_STR {
            additionalLabel.isHidden = false
            additionalContent.isHidden = false
            incMainViewHeight(additionalLabel.frame.size.height)
            incMainViewHeight((getDynamicSizForTextView(itemContent, content: util.checkStringData(data.additionalInformation))).height)
        }
        incMainViewHeight(termConditionsLable.frame.size.height)
        self.setMainViewHeight()
        self.mainView.isHidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
