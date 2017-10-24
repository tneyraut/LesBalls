//
//  AccueilTableViewController.swift
//  LesBalls
//
//  Created by Thomas Mac on 04/06/2016.
//  Copyright © 2016 ThomasNeyraut. All rights reserved.
//

import UIKit

class AccueilViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var tableView : UITableView!
    
    fileprivate var accueilModel = AccueilModel()
    
    fileprivate let itemsArray: NSArray =
        [NSLocalizedString("ACCUEIL_VIEW_NB_BALLS", comment:""),
         NSLocalizedString("ACCUEIL_VIEW_SPEED", comment:""),
         NSLocalizedString("ACCUEIL_VIEW_DUPLICATION", comment:""),
         NSLocalizedString("ACCUEIL_VIEW_SIZE", comment:""),
         NSLocalizedString("ACCUEIL_VIEW_NB_MAX_BALLS", comment:"")]
    
    fileprivate let imagesArray: NSArray =
        [NSLocalizedString("ICON_BALL_BLEU1", comment:""),
         NSLocalizedString("ICON_VITESSE", comment:""),
         NSLocalizedString("ICON_BALL_BLEU1", comment:""),
         NSLocalizedString("ICON_MESURE", comment:""),
         NSLocalizedString("ICON_BALL_BLEU1", comment:"")]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.title = NSLocalizedString("ACCUEIL_VIEW_TITLE", comment:"")
    }

    override func viewDidAppear(_ animated: Bool)
    {
        self.navigationController?.setToolbarHidden(false, animated:true)
        
        _ = addCenterButtonInToolBar(title: NSLocalizedString("ACCUEIL_VIEW_LAUNCH", comment:""), target: self, selector: #selector(self.buttonGoActionListener))
        
        super.viewDidAppear(animated)
    }
    
    @objc fileprivate func buttonGoActionListener()
    {
        let mainViewController = MainViewController()
        
        mainViewController.mainModel = MainModel(
            nbBalls: accueilModel.nbBalls,
            duplication: accueilModel.duplication,
            speed: accueilModel.speed,
            size: accueilModel.size,
            nbMaxBalls: accueilModel.nbMaxBalls)
        
        self.navigationController?.pushViewController(mainViewController, animated:true)
    }
    
    @objc fileprivate func stepperNumberBallsActionListener(_ sender: UIStepper)
    {
        accueilModel.nbBalls = Int(sender.value)
        self.tableView.reloadData()
    }
    
    @objc fileprivate func stepperVitesseActionListener(_ sender: UIStepper)
    {
        accueilModel.speed = Int(sender.value)
        self.tableView.reloadData()
    }
    
    @objc fileprivate func switchDuplicationActionListener(_ sender: UISwitch)
    {
        accueilModel.duplication = sender.isOn
        self.tableView.reloadData()
    }
    
    @objc fileprivate func stepperTailleActionListener(_ sender: UIStepper)
    {
        accueilModel.size = Int(sender.value)
        self.tableView.reloadData()
    }
    
    @objc fileprivate func stepperNombreMaxBallsActionListener(_ sender: UIStepper)
    {
        accueilModel.nbMaxBalls = Int(sender.value)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if (indexPath.row == 2)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.switchCellId, for: indexPath) as! TableViewCellWithSwitch
            
            cell.iconView.image = UIImage(named: self.imagesArray[indexPath.row] as! String);
            
            cell.label.text = self.itemsArray[indexPath.row] as? String
            
            cell.label.text = (cell.label.text)! + String(accueilModel.duplication)
            
            cell.switchObject.isOn = accueilModel.duplication
            
            cell.switchObject.addTarget(self, action:#selector(self.switchDuplicationActionListener(_:)), for:UIControlEvents.touchUpInside)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.stepperCellId, for: indexPath) as! TableViewCellWithStepper
        
        cell.iconView.image = UIImage(named: self.imagesArray[indexPath.row] as! String);
        
        cell.label.text = self.itemsArray[indexPath.row] as? String
        
        if (indexPath.row == 0)
        {
            cell.label.text = (cell.label.text)! + String(accueilModel.nbBalls)
            
            cell.stepper.minimumValue = 1
            cell.stepper.maximumValue = 100
            cell.stepper.value = Double(accueilModel.nbBalls)
            
            cell.stepper.addTarget(self, action:#selector(self.stepperNumberBallsActionListener(_:)), for:UIControlEvents.touchUpInside)
        }
        else if (indexPath.row == 1)
        {
            cell.label.text = (cell.label.text)! + String(accueilModel.speed)
            
            cell.stepper.minimumValue = 1
            cell.stepper.maximumValue = 5
            cell.stepper.value = Double(accueilModel.speed)
            
            cell.stepper.addTarget(self, action:#selector(self.stepperVitesseActionListener(_:)), for:UIControlEvents.touchUpInside)
        }
        else if (indexPath.row == 3)
        {
            cell.label.text = (cell.label.text)! + String(accueilModel.size) + "x" + String(accueilModel.size)
            
            cell.stepper.minimumValue = 5
            cell.stepper.maximumValue = 50
            cell.stepper.value = Double(accueilModel.size)
            cell.stepper.stepValue = 5
            
            cell.stepper.addTarget(self, action:#selector(self.stepperTailleActionListener(_:)), for:UIControlEvents.touchUpInside)
        }
        else if (indexPath.row == 4)
        {
            cell.label.text = (cell.label.text)! + String(accueilModel.nbMaxBalls)
            
            cell.stepper.minimumValue = 10
            cell.stepper.maximumValue = 10000
            cell.stepper.value = Double(accueilModel.nbMaxBalls)
            cell.stepper.stepValue = 10
            
            cell.stepper.addTarget(self, action:#selector(self.stepperNombreMaxBallsActionListener(_:)), for:UIControlEvents.touchUpInside)
        }
        return cell
    }
}
