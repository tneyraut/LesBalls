//
//  Ball.swift
//  LesBalls
//
//  Created by Thomas Mac on 04/06/2016.
//  Copyright © 2016 ThomasNeyraut. All rights reserved.
//

import UIKit

class Ball: NSObject
{
    fileprivate var color : String?
    
    fileprivate var speed : Int?
    fileprivate var speedX : Double?
    fileprivate var speedY : Double?
    
    fileprivate var duplication : Bool?
    
    fileprivate var size : Int?
    
    fileprivate var timer = Timer()
    
    fileprivate let imageView = UIImageView()
    
    fileprivate var viewController : MainViewController?
    
    init(speed: Int, duplication: Bool, size: Int, viewController: MainViewController)
    {
        self.speed = speed
        self.duplication = duplication
        self.size = size
        self.viewController = viewController
        
        self.imageView.frame = CGRect(
            x: (self.viewController?.view.frame.size.width)! / 2,
            y: ((self.viewController?.view.frame.size.height)! - (self.viewController?.navigationController!.navigationBar.frame.size.height)! - (self.viewController?.navigationController?.toolbar.frame.size.height)!) / 2,
            width: CGFloat(self.size!),
            height: CGFloat(self.size!))
        
        self.viewController?.view.addSubview(self.imageView)
    }
    
    internal func setAndLaunchAnimation()
    {
        self.viewController?.addBallToBallsArray(self)
        
        self.setColor()
        
        self.imageView.image = UIImage(named: NSLocalizedString("ICON_BALL_" + self.color!, comment:""))
        
        self.setSpeed()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.01 / Double(self.speed!), target: self, selector: #selector(self.move), userInfo: nil, repeats: true)
    }
    
    @objc fileprivate func move()
    {
        let x = Double(self.imageView.frame.origin.x) + self.speedX!
        let y = Double(self.imageView.frame.origin.y) + self.speedY!
        
        self.imageView.frame = CGRect(x: CGFloat(x), y: CGFloat(y), width: self.imageView.frame.size.width, height: self.imageView.frame.size.height)
        if self.aLaFrontiereHautOuBas()
        {
            self.speedY = -self.speedY!
            if self.duplication! && (self.viewController?.getBallsArrayCount())! < (self.viewController?.mainModel?.nbMaxBalls)!
            {
                let ball = Ball(
                    speed: self.speed!,
                    duplication: self.duplication!,
                    size: self.size!,
                    viewController: self.viewController!)
                
                ball.setAndLaunchAnimation()
            }
        }
        if (self.aLaFrontiereGaucheOuDroite())
        {
            self.speedX = -self.speedX!
            if self.duplication!  && self.viewController!.getBallsArrayCount() < (self.viewController?.mainModel?.nbMaxBalls)!
            {
                let ball = Ball(
                    speed: self.speed!,
                    duplication: self.duplication!,
                    size: self.size!,
                    viewController: self.viewController!)
                
                ball.setAndLaunchAnimation()
            }
        }
    }
    
    fileprivate func setSpeed()
    {
        var signeX = 1.0
        var signeY = 1.0
        if (arc4random_uniform(2) == 0)
        {
            signeX = -1.0
        }
        if (arc4random_uniform(2) == 0)
        {
            signeY = -1.0
        }
        self.speedX = signeX * (Double(arc4random_uniform(10)) + 1.0) / 10.0
        self.speedY = signeY * (Double(arc4random_uniform(10)) + 1.0) / 10.0
        while (self.speedX == 0.0)
        {
            self.speedX = signeX * (Double(arc4random_uniform(10)) + 1.0) / 10.0
        }
        while (self.speedY == 0.0)
        {
            self.speedY = signeY * (Double(arc4random_uniform(10)) + 1.0) / 10.0
        }
    }
    
    fileprivate func setColor()
    {
        let aColor = arc4random_uniform(6)
        if (aColor == 0)
        {
            self.color = "BLEU1"
        }
        else if (aColor == 1)
        {
            self.color = "BLEU2"
        }
        else if (aColor == 2)
        {
            self.color = "BLEU_CIEL"
        }
        else if (aColor == 3)
        {
            self.color = "JAUNE"
        }
        else if (aColor == 4)
        {
            self.color = "NOIR"
        }
        else if (aColor == 5)
        {
            self.color = "ROUGE"
        }
    }
    
    fileprivate func aLaFrontiereGaucheOuDroite() -> Bool
    {
        return self.imageView.frame.origin.x + self.imageView.frame.size.height >= self.viewController!.view.frame.size.width || self.imageView.frame.origin.x <= 0
    }
    
    fileprivate func aLaFrontiereHautOuBas() -> Bool
    {
        return self.imageView.frame.origin.y + self.imageView.frame.size.height >= (self.viewController!.view.frame.size.height - (self.viewController!.navigationController?.toolbar.frame.size.height)!) || self.imageView.frame.origin.y <= self.viewController!.navigationController!.navigationBar.frame.size.height + 20.0
    }
    
    internal func stopAnimating()
    {
        self.timer.invalidate()
    }
}
