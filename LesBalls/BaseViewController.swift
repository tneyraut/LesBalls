//
//  BaseViewController.swift
//  LesBalls
//
//  Created by Thomas Mac on 24/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit

class BaseViewController : UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let shadow = NSShadow()
        shadow.shadowColor = AppColors.titleShadowColor
        shadow.shadowOffset = CGSize(width: 0, height: 1)
        
        let buttonPrevious = UIBarButtonItem(title:NSLocalizedString("SHARED_BACK_BUTTON", comment:""), style:UIBarButtonItemStyle.done, target:nil, action:nil)
        
        buttonPrevious.setTitleTextAttributes([NSForegroundColorAttributeName: AppColors.whiteColor, NSShadowAttributeName: shadow, NSFontAttributeName: UIFont(name:"HelveticaNeue-CondensedBlack", size:21.0)!], for:UIControlState())
        
        self.navigationItem.backBarButtonItem = buttonPrevious
    }
    
    func addCenterButtonInToolBar(title: String, target: Any?, selector: Selector?) -> UIBarButtonItem
    {
        let shadow = NSShadow()
        
        shadow.shadowColor = AppColors.titleShadowColor
        
        shadow.shadowOffset = CGSize(width: 0, height: 1)
        
        let button = UIBarButtonItem(title: title, style: .plain, target:target, action: selector)
        
        button.setTitleTextAttributes([NSForegroundColorAttributeName: AppColors.whiteColor, NSShadowAttributeName: shadow, NSFontAttributeName: UIFont(name:"HelveticaNeue-CondensedBlack", size:21.0)!], for:UIControlState())
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action:nil)
        
        self.navigationController?.toolbar.setItems([flexibleSpace, button, flexibleSpace], animated:true)
        
        return button
    }
}
