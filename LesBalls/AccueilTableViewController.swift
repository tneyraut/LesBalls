//
//  AccueilTableViewController.swift
//  LesBalls
//
//  Created by Thomas Mac on 04/06/2016.
//  Copyright © 2016 ThomasNeyraut. All rights reserved.
//

import UIKit

class AccueilTableViewController: UITableViewController {

    private var nombreDeBalls = 1

    private var vitesse = 1
    
    private var duplication = true
    
    private var taille = 10
    
    private var nombreMaxBalls = 20
    
    private let itemsArray: NSArray = ["Nombre de balls : ", "Vitesse : x", "Duplication : ", "Taille : ", "Nombre max de balls : "]
    
    private let imagesArray: NSArray = [NSLocalizedString("ICON_BALL_BLEU1", comment:""), NSLocalizedString("ICON_VITESSE", comment:""), NSLocalizedString("ICON_BALL_BLEU1", comment:""), NSLocalizedString("ICON_MESURE", comment:""), NSLocalizedString("ICON_BALL_BLEU1", comment:"")]
    
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.WhiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.tableView.registerClass(TableViewCellWithSwitch.classForCoder(), forCellReuseIdentifier:"cellSwitch")
        self.tableView.registerClass(TableViewCellWithStepper.classForCoder(), forCellReuseIdentifier:"cellStepper")
        
        self.title = "Les Balls : Menu Principal"
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.8)
        shadow.shadowOffset = CGSizeMake(0, 1)
        
        let buttonPrevious = UIBarButtonItem(title:"Retour", style:UIBarButtonItemStyle.Done, target:nil, action:nil)
        buttonPrevious.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:245.0/255.0, green:245.0/255.0, blue:245.0/255.0, alpha:1.0), NSShadowAttributeName: shadow, NSFontAttributeName: UIFont(name:"HelveticaNeue-CondensedBlack", size:21.0)!], forState:UIControlState.Normal)
        
        self.navigationItem.backBarButtonItem = buttonPrevious
        
        self.activityIndicatorView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)
        
        self.activityIndicatorView.color = UIColor.blackColor()
        
        self.activityIndicatorView.hidesWhenStopped = true
        
        self.tableView.addSubview(self.activityIndicatorView)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        
        let buttonGo = UIBarButtonItem(title:"Lancer", style:.Plain, target:self, action:#selector(self.buttonGoActionListener))
        
        buttonGo.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:245.0/255.0, green:245.0/255.0, blue:245.0/255.0, alpha:1.0), NSShadowAttributeName: shadow, NSFontAttributeName: UIFont(name:"HelveticaNeue-CondensedBlack", size:21.0)!], forState:UIControlState.Normal)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target:nil, action:nil)
        
        self.navigationController?.toolbar.setItems([flexibleSpace, buttonGo, flexibleSpace], animated:true)
        
        super.viewDidAppear(animated)
    }
    
    @objc private func buttonGoActionListener()
    {
        self.activityIndicatorView.startAnimating()
        
        let mainViewController = MainViewController()
        
        mainViewController.nombreDeBalls = self.nombreDeBalls
        mainViewController.duplication = self.duplication
        mainViewController.vitesse = self.vitesse
        mainViewController.taille = self.taille
        mainViewController.nombreMaxBalls = self.nombreMaxBalls
        
        self.navigationController?.pushViewController(mainViewController, animated:true)
        
        self.activityIndicatorView.stopAnimating()
    }
    
    @objc private func stepperNumberBallsActionListener(sender: UIStepper)
    {
        self.nombreDeBalls = Int(sender.value)
        self.tableView.reloadData()
    }
    
    @objc private func stepperVitesseActionListener(sender: UIStepper)
    {
        self.vitesse = Int(sender.value)
        self.tableView.reloadData()
    }
    
    @objc private func switchDuplicationActionListener(sender: UISwitch)
    {
        self.duplication = sender.on
        self.tableView.reloadData()
    }
    
    @objc private func stepperTailleActionListener(sender: UIStepper)
    {
        self.taille = Int(sender.value)
        self.tableView.reloadData()
    }
    
    @objc private func stepperNombreMaxBallsActionListener(sender: UIStepper)
    {
        self.nombreMaxBalls = Int(sender.value)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.itemsArray.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 2)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("cellSwitch", forIndexPath: indexPath)
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
            
            cell.textLabel?.numberOfLines = 0
            
            cell.imageView?.image = UIImage(named: self.imagesArray[indexPath.row] as! String);
            
            cell.textLabel?.text = self.itemsArray[indexPath.row] as? String
            
            cell.textLabel?.text = (cell.textLabel?.text)! + String(self.duplication)
            
            (cell as! TableViewCellWithSwitch).switchObject.on = self.duplication
            
            (cell as! TableViewCellWithSwitch).switchObject.addTarget(self, action:#selector(self.switchDuplicationActionListener(_:)), forControlEvents:UIControlEvents.TouchUpInside)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellStepper", forIndexPath: indexPath)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        cell.textLabel?.numberOfLines = 0
        
        cell.imageView?.image = UIImage(named: self.imagesArray[indexPath.row] as! String);
        
        cell.textLabel?.text = self.itemsArray[indexPath.row] as? String
        
        if (indexPath.row == 0)
        {
            cell.textLabel?.text = (cell.textLabel?.text)! + String(self.nombreDeBalls)
            
            (cell as! TableViewCellWithStepper).stepper.minimumValue = 1
            (cell as! TableViewCellWithStepper).stepper.maximumValue = 100
            (cell as! TableViewCellWithStepper).stepper.value = Double(self.nombreDeBalls)
            
            (cell as! TableViewCellWithStepper).stepper.addTarget(self, action:#selector(self.stepperNumberBallsActionListener(_:)), forControlEvents:UIControlEvents.TouchUpInside)
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel?.text = (cell.textLabel?.text)! + String(self.vitesse)
            
            (cell as! TableViewCellWithStepper).stepper.minimumValue = 1
            (cell as! TableViewCellWithStepper).stepper.maximumValue = 5
            (cell as! TableViewCellWithStepper).stepper.value = Double(self.vitesse)
            
            (cell as! TableViewCellWithStepper).stepper.addTarget(self, action:#selector(self.stepperVitesseActionListener(_:)), forControlEvents:UIControlEvents.TouchUpInside)
        }
        else if (indexPath.row == 3)
        {
            cell.textLabel?.text = (cell.textLabel?.text)! + String(self.taille) + "x" + String(self.taille)
            
            (cell as! TableViewCellWithStepper).stepper.minimumValue = 5
            (cell as! TableViewCellWithStepper).stepper.maximumValue = 50
            (cell as! TableViewCellWithStepper).stepper.value = Double(self.taille)
            (cell as! TableViewCellWithStepper).stepper.stepValue = 5
            
            (cell as! TableViewCellWithStepper).stepper.addTarget(self, action:#selector(self.stepperTailleActionListener(_:)), forControlEvents:UIControlEvents.TouchUpInside)
        }
        else if (indexPath.row == 4)
        {
            cell.textLabel?.text = (cell.textLabel?.text)! + String(self.nombreMaxBalls)
            
            (cell as! TableViewCellWithStepper).stepper.minimumValue = 10
            (cell as! TableViewCellWithStepper).stepper.maximumValue = 10000
            (cell as! TableViewCellWithStepper).stepper.value = Double(self.nombreMaxBalls)
            (cell as! TableViewCellWithStepper).stepper.stepValue = 10
            
            (cell as! TableViewCellWithStepper).stepper.addTarget(self, action:#selector(self.stepperNombreMaxBallsActionListener(_:)), forControlEvents:UIControlEvents.TouchUpInside)
        }
        return cell
    }
    
}
