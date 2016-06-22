//
//  MainViewController.swift
//  LesBalls
//
//  Created by Thomas Mac on 04/06/2016.
//  Copyright © 2016 ThomasNeyraut. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    internal var nombreDeBalls = 1
    
    internal var vitesse = 1
    
    internal var duplication = false
    
    internal var taille = 10
    
    internal var nombreMaxBalls = 20
    
    private let ballsArray = NSMutableArray()
    
    let compteur = UIBarButtonItem(title:"Compteur : ", style:.Plain, target:nil, action:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(touch))
        self.view.addGestureRecognizer(gesture)
        
        self.title = "Les Balls"
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.8)
        shadow.shadowOffset = CGSizeMake(0, 1)
        
        let buttonPrevious = UIBarButtonItem(title:"Retour", style:UIBarButtonItemStyle.Done, target:nil, action:nil)
        buttonPrevious.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:245.0/255.0, green:245.0/255.0, blue:245.0/255.0, alpha:1.0), NSShadowAttributeName: shadow, NSFontAttributeName: UIFont(name:"HelveticaNeue-CondensedBlack", size:21.0)!], forState:UIControlState.Normal)
        
        self.navigationItem.backBarButtonItem = buttonPrevious
        
        self.addBalls()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated:true)
        
        self.navigationController?.toolbar.barTintColor = UIColor(red:0.439, green:0.776, blue:0.737, alpha:1)
        
        let shadow = NSShadow()
        
        shadow.shadowColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.8)
        
        shadow.shadowOffset = CGSizeMake(0, 1)
        
        self.compteur.title = "Compteur : " + String(self.ballsArray.count)
        
        self.compteur.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:245.0/255.0, green:245.0/255.0, blue:245.0/255.0, alpha:1.0), NSShadowAttributeName: shadow, NSFontAttributeName: UIFont(name:"HelveticaNeue-CondensedBlack", size:21.0)!], forState:UIControlState.Normal)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target:nil, action:nil)
        
        self.navigationController?.toolbar.setItems([flexibleSpace, self.compteur, flexibleSpace], animated:true)
        
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.clearAllBalls()
        
        super.viewWillDisappear(animated)
    }
    
    private func addBalls()
    {
        var i = 0
        while (i < self.nombreDeBalls && self.ballsArray.count < self.nombreMaxBalls)
        {
            let ball = Ball()
            ball.initBall(self.vitesse, duplication: self.duplication, taille: self.taille, viewController: self)
            i += 1
        }
    }
    
    @objc private func touch()
    {
        if (self.ballsArray.count < self.nombreMaxBalls)
        {
            let ball = Ball()
            ball.initBall(self.vitesse, duplication: self.duplication, taille: self.taille, viewController: self)
        }
    }

    func addBallToBallsArray(ball: Ball)
    {
        self.ballsArray.addObject(ball)
        self.compteur.title = "Compteur : " + String(self.ballsArray.count)
    }
    
    private func clearAllBalls()
    {
        var i = 0
        while (i < self.ballsArray.count)
        {
            let ball = self.ballsArray[i] as! Ball
            ball.stopAnimating()
            i += 1
        }
    }
    
    func getBallsArrayCount() -> Int
    {
        return self.ballsArray.count
    }
    
}
