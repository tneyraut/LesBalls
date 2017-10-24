//
//  MainModel.swift
//  LesBalls
//
//  Created by Thomas Mac on 24/10/2017.
//  Copyright © 2017 ThomasNeyraut. All rights reserved.
//

class MainModel
{
    var nbBalls : Int?
    var duplication : Bool?
    var speed : Int?
    var size : Int?
    var nbMaxBalls : Int?
    
    init(nbBalls: Int, duplication: Bool, speed: Int, size: Int, nbMaxBalls: Int)
    {
        self.nbBalls = nbBalls
        self.duplication = duplication
        self.speed = speed
        self.size = size
        self.nbMaxBalls = nbMaxBalls
    }
}
