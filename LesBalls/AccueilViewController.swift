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
    
    fileprivate let itemsArray: [ItemModel] = [
        ItemModel(
            title: NSLocalizedString("ACCUEIL_VIEW_NB_BALLS", comment:""),
            imageName: NSLocalizedString("ICON_BALL_BLEU1", comment:""),
            stepValue: Constants.stepNbBalls,
            minValue: Constants.minNbBalls,
            maxValue: Constants.maxNbBalls),
        ItemModel(
            title: NSLocalizedString("ACCUEIL_VIEW_SPEED", comment:""),
            imageName: NSLocalizedString("ICON_VITESSE", comment:""),
            stepValue: Constants.stepSpeed,
            minValue: Constants.minSpeed,
            maxValue: Constants.maxSpeed),
        ItemModel(
            title: NSLocalizedString("ACCUEIL_VIEW_DUPLICATION", comment:""),
            imageName: NSLocalizedString("ICON_BALL_BLEU1", comment:""),
            stepValue: 0,
            minValue: 0,
            maxValue: 0),
        ItemModel(
            title: NSLocalizedString("ACCUEIL_VIEW_SIZE", comment:""),
            imageName: NSLocalizedString("ICON_MESURE", comment:""),
            stepValue: Constants.stepSize,
            minValue: Constants.minSize,
            maxValue: Constants.maxSize),
        ItemModel(
            title: NSLocalizedString("ACCUEIL_VIEW_NB_MAX_BALLS", comment:""),
            imageName: NSLocalizedString("ICON_BALL_BLEU1", comment:""),
            stepValue: Constants.stepNbMaxBalls,
            minValue: Constants.minNbMaxBalls,
            maxValue: Constants.maxNbMaxBalls)
    ]
    
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
        let item = self.itemsArray[indexPath.row]
        
        if (indexPath.row == 2)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.switchCellId, for: indexPath) as! TableViewCellWithSwitch
            
            cell.iconView.image = UIImage(named: item.imageName)
            
            cell.label.text = "\(item.title)\(accueilModel.duplication ? NSLocalizedString("ACCUEIL_VIEW_YES", comment: "") : NSLocalizedString("ACCUEIL_VIEW_NO", comment: ""))"
            
            cell.switchObject.isOn = accueilModel.duplication
            
            cell.switchObject.addTarget(self, action:#selector(self.switchDuplicationActionListener(_:)), for:UIControlEvents.touchUpInside)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.stepperCellId, for: indexPath) as! TableViewCellWithStepper
        
        cell.iconView.image = UIImage(named: item.imageName);
        
        cell.stepper.minimumValue = Double(item.minValue)
        cell.stepper.maximumValue = Double(item.maxValue)
        cell.stepper.stepValue = Double(item.stepValue)
        
        if (indexPath.row == 0)
        {
            cell.label.text = "\(item.title)\(accueilModel.nbBalls)"
            cell.stepper.value = Double(accueilModel.nbBalls)
            
            cell.stepper.addTarget(self, action:#selector(self.stepperNumberBallsActionListener(_:)), for:UIControlEvents.touchUpInside)
        }
        else if (indexPath.row == 1)
        {
            cell.label.text = "\(item.title)\(accueilModel.speed)"
            cell.stepper.value = Double(accueilModel.speed)
            
            cell.stepper.addTarget(self, action:#selector(self.stepperVitesseActionListener(_:)), for:UIControlEvents.touchUpInside)
        }
        else if (indexPath.row == 3)
        {
            cell.label.text = "\(item.title)\(accueilModel.size)x\(accueilModel.size)"
            cell.stepper.value = Double(accueilModel.size)
            
            cell.stepper.addTarget(self, action:#selector(self.stepperTailleActionListener(_:)), for:UIControlEvents.touchUpInside)
        }
        else if (indexPath.row == 4)
        {
            cell.label.text = "\(item.title)\(accueilModel.nbMaxBalls)"
            cell.stepper.value = Double(accueilModel.nbMaxBalls)
            
            cell.stepper.addTarget(self, action:#selector(self.stepperNombreMaxBallsActionListener(_:)), for:UIControlEvents.touchUpInside)
        }
        return cell
    }
}
