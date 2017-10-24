//
//  MainViewController.swift
//  LesBalls
//
//  Created by Thomas Mac on 04/06/2016.
//  Copyright © 2016 ThomasNeyraut. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController
{
    internal var mainModel : MainModel?
    
    fileprivate let ballsArray = NSMutableArray()
    
    fileprivate var compteur : UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Les Balls"
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(touch))
        self.view.addGestureRecognizer(gesture)
        
        self.addBalls()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.navigationController?.setToolbarHidden(false, animated:true)
        
        compteur = addCenterButtonInToolBar(title: "Compteur : " + String(self.ballsArray.count), target: nil, selector: nil)
        
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        self.clearAllBalls()
        
        super.viewWillDisappear(animated)
    }
    
    fileprivate func addBalls()
    {
        var i = 0
        while i < (self.mainModel?.nbBalls)! && self.ballsArray.count < (self.mainModel?.nbMaxBalls)!
        {
            let ball = Ball(
                speed: (self.mainModel?.speed)!,
                duplication: (self.mainModel?.duplication)!,
                size: (self.mainModel?.size)!,
                viewController: self)
            
            ball.setAndLaunchAnimation()
            
            i += 1
        }
    }
    
    @objc fileprivate func touch()
    {
        if self.ballsArray.count < (self.mainModel?.nbMaxBalls)!
        {
            let ball = Ball(
                speed: (self.mainModel?.speed)!,
                duplication: (self.mainModel?.duplication)!,
                size: (self.mainModel?.size)!,
                viewController: self)
            
            ball.setAndLaunchAnimation()
        }
    }

    internal func addBallToBallsArray(_ ball: Ball)
    {
        self.ballsArray.add(ball)
        
        self.compteur?.title = "Compteur : " + String(self.ballsArray.count)
    }
    
    fileprivate func clearAllBalls()
    {
        var i = 0
        while i < self.ballsArray.count
        {
            let ball = self.ballsArray[i] as! Ball
            ball.stopAnimating()
            i += 1
        }
    }
    
    internal func getBallsArrayCount() -> Int
    {
        return self.ballsArray.count
    }
    
}
