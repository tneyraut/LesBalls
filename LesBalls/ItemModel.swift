//
//  ItemModel.swift
//  LesBalls
//
//  Created by Thomas Mac on 24/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

class ItemModel
{
    var title : String
    var imageName : String
    var stepValue : Int
    var minValue : Int
    var maxValue : Int
    
    init(title: String, imageName: String, stepValue: Int, minValue: Int, maxValue: Int)
    {
        self.title = title
        self.imageName = imageName
        self.stepValue = stepValue
        self.minValue = minValue
        self.maxValue = maxValue
    }
}
