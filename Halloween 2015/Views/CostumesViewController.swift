//
//  CostumesViewController.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/23/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

import UIKit

let globalCostumeManager = costumeManager

class CostumesViewController: UIViewController, CostumeManagerDelegate, UITableViewDataSource, CostumeTableViewCellDelegate {

    @IBOutlet weak var scanButton: UIBarButtonItem!
    
    @IBOutlet weak var costumesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        globalCostumeManager.delegate = self
        scanButton.possibleTitles = ["Scan", "Stop Scanning"]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "View All", style: .Plain, target: self, action: "goToAllCostumes")
        
        costumesTableView.dataSource = self
    }
    
    func goToAllCostumes() {
        performSegueWithIdentifier("CostumesDetail", sender: self)
    }
    
    @IBAction func disconnectAllButtonWasPressed(sender: AnyObject) {
        globalCostumeManager.costumes.forEach({ $0.disconnect() })
    }
    
    @IBAction func scanButtonWasPressed(sender: AnyObject) {
        toggleScanning()
    }
    
    func toggleScanning() {
        switch globalCostumeManager.state {
        case .NotScanning:
            globalCostumeManager.startScan()
        case .Scanning:
            globalCostumeManager.stopScan()
        }
    }

    // MARK: - CostumeTableViewCellDelegate
    
    func costumeTableViewCell(cell: CostumeTableViewCell, didSelectViewFor costume: Costume) {
        performSegueWithIdentifier("CostumeDetail", sender: cell)
    }
    
    // MARK: - UITableViewDataSource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalCostumeManager.costumes.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = costumesTableView.dequeueReusableCellWithIdentifier("CostumeTableViewCell") as! CostumeTableViewCell
        var costume = globalCostumeManager.costumes[indexPath.row]
        costume.delegate = cell
        cell.delegate = self
        cell.costume = costume
        return cell
    }
    
    
    // MARK: - CostumeManagerDelegate methods
    
    func costumeManager(manager: CostumeManager, didUpdateState state: CostumeManagerState) {
        switch state {
        case .Scanning:
            scanButton.title = "Stop Scanning"
        case .NotScanning:
            scanButton.title = "Scan"
        }
    }
    
    func costumeManager(manager: CostumeManager, didFindCostume costume: Costume) {
        costumesTableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        globalCostumeManager.stopScan()
        
        if segue.identifier == "CostumeDetail" {
            let cell = sender as! CostumeTableViewCell
            let nextViewController = segue.destinationViewController as! CostumeDetailViewController
            nextViewController.costumes = [cell.costume]
        } else if segue.identifier == "CostumesDetail" {
            let nextViewController = segue.destinationViewController as! CostumeDetailViewController
            nextViewController.costumes = globalCostumeManager.costumes.filter { (costume: Costume) -> Bool in
                return costume.state == .Connected
            }
            nextViewController.multiCostumeSelection = true
        }
    }

}
