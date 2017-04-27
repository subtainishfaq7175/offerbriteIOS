//
//  HomeItemDetails.swift
//  Offer Brite
//
//  Created by Ahsan Hameed on 4/26/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import UIKit

class HomeItemDetails: UIViewController, UIScrollViewDelegate {
    var navTitle:String?
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainScroller: UIScrollView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var itemContent: UITextView!
    @IBOutlet weak var additionalLabel: UILabel!
    @IBOutlet weak var additionalContent: UITextView!
    @IBOutlet weak var bottomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if navTitle != nil {
            self.title = navTitle
        }
        navigationController?.navigationBar.tintColor = .white
        self.mainScroller.delegate = self
        self.mainScroller.isScrollEnabled = true
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    func setMainViewHeight() {
        let constant = topView.frame.height + bottomView.frame.height + 20.0
        let mainConstraint = NSLayoutConstraint(item: mainView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: constant)
        self.view.addConstraint(mainConstraint)
    }
    override func viewWillLayoutSubviews() {
        setMainViewHeight()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
