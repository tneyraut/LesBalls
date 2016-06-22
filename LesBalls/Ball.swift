//
//  Ball.swift
//  LesBalls
//
//  Created by Thomas Mac on 04/06/2016.
//  Copyright © 2016 ThomasNeyraut. All rights reserved.
//

import UIKit

class Ball: NSObject {
    
    private var color = ""
    
    private var vitesse = 1
    private var vitesseX = 0.0
    private var vitesseY = 0.0
    
    private var duplication = false
    
    private var taille = 10
    
    private var timer = NSTimer()
    
    private let imageView = UIImageView()
    
    private var viewController = MainViewController()
    
    func initBall(vitesse: Int, duplication: Bool, taille: Int, viewController: MainViewController)
    {
        self.vitesse = vitesse
        self.duplication = duplication
        self.taille = taille
        self.viewController = viewController
        self.viewController.addBallToBallsArray(self)
        self.setColor()
        self.imageView.frame = CGRectMake(self.viewController.view.frame.size.width / 2, (self.viewController.view.frame.size.height - self.viewController.navigationController!.navigationBar.frame.size.height - (self.viewController.navigationController?.toolbar.frame.size.height)!) / 2, CGFloat(self.taille), CGFloat(self.taille))
        self.imageView.image = UIImage(named: NSLocalizedString("ICON_BALL_" + self.color, comment:""))
        self.viewController.view.addSubview(self.imageView)
        self.setVitesse()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01 / Double(self.vitesse), target: self, selector: #selector(self.deplacement), userInfo: nil, repeats: true)
    }
    
    @objc private func deplacement()
    {
        let x = Double(self.imageView.frame.origin.x) + self.vitesseX
        let y = Double(self.imageView.frame.origin.y) + self.vitesseY
        
        self.imageView.frame = CGRectMake(CGFloat(x), CGFloat(y), self.imageView.frame.size.width, self.imageView.frame.size.height)
        if (self.aLaFrontiereHautOuBas())
        {
            self.vitesseY = -self.vitesseY
            if (self.duplication && self.viewController.getBallsArrayCount() < self.viewController.nombreMaxBalls)
            {
                let ball = Ball()
                ball.initBall(self.vitesse, duplication: self.duplication, taille: self.taille, viewController: self.viewController)
            }
        }
        if (self.aLaFrontiereGaucheOuDroite())
        {
            self.vitesseX = -self.vitesseX
            if (self.duplication  && self.viewController.getBallsArrayCount() < self.viewController.nombreMaxBalls)
            {
                let ball = Ball()
                ball.initBall(self.vitesse, duplication: self.duplication, taille: self.taille, viewController: self.viewController)
            }
        }
    }
    
    private func setVitesse()
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
        self.vitesseX = signeX * (Double(arc4random_uniform(10)) + 1.0) / 10.0
        self.vitesseY = signeY * (Double(arc4random_uniform(10)) + 1.0) / 10.0
        while (self.vitesseX == 0.0)
        {
            self.vitesseX = signeX * (Double(arc4random_uniform(10)) + 1.0) / 10.0
        }
        while (self.vitesseY == 0.0)
        {
            self.vitesseY = signeY * (Double(arc4random_uniform(10)) + 1.0) / 10.0
        }
    }
    
    private func setColor()
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
    
    private func aLaFrontiereGaucheOuDroite() -> Bool
    {
        return (self.imageView.frame.origin.x + self.imageView.frame.size.height >= self.viewController.view.frame.size.width || self.imageView.frame.origin.x <= 0)
    }
    
    private func aLaFrontiereHautOuBas() -> Bool
    {
        return (self.imageView.frame.origin.y + self.imageView.frame.size.height >= (self.viewController.view.frame.size.height - (self.viewController.navigationController?.toolbar.frame.size.height)!) || self.imageView.frame.origin.y <= self.viewController.navigationController!.navigationBar.frame.size.height + 20.0)
    }
    
    func stopAnimating()
    {
        self.timer.invalidate()
    }
    
}
