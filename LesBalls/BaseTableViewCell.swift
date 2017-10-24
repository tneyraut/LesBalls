//
//  BaseTableViewCell.swift
//  LesBalls
//
//  Created by Thomas Mac on 24/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

import UIKit

class BaseTableViewCell : UITableViewCell
{
    @IBOutlet var iconView : UIImageView!
    @IBOutlet var label : UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        self.layer.borderColor = AppColors.lightGrayColor.cgColor
        
        self.layer.borderWidth = 2.5
        self.layer.cornerRadius = 7.5
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = AppColors.shadowColor.cgColor
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
    }
}
