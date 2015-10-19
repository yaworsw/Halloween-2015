//
//  CostumesViewController.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//
//  This view displays a list of costumes that have been discovered
//

import UIKit

/**
    The costumeManager singleton

    Since we have methods in CostumesViewController which are named costumeManager we need to create an alternate way to reference the costumeManager singleton
*/
internal let globalCostumeManager = costumeManager

/**
    
*/
class CostumesViewController: UIViewController, CostumeManagerDelegate, UITableViewDataSource, CostumeTableViewCellDelegate {

    @IBOutlet weak var scanButton: UIBarButtonItem!
    
    @IBOutlet weak var costumesTableView: UITableView!
    
    @IBAction func toggleScanning(sender: AnyObject) {
        switch globalCostumeManager.state {
        case .NotScanning:
            globalCostumeManager.scanForCostumes()
        case .Scanning:
            globalCostumeManager.stopScanningForCostumes()
        }
    }
    
    // MARK: - CostumeTableViewCell methods
    
    func costumeTableViewCell(cell: CostumeTableViewCell, didSelectViewFor costume: Costume) {
        self.performSegueWithIdentifier("CostumeDetail", sender: costume)
    }
    
    // MARK: - CostumeManagerDelegate methods
    
    func costumeManager(costumeManager: CostumeManager, didDiscoverCostume costume: Costume) {
        costumesTableView.reloadData()
    }
    
    func costumeManager(costumeManager: CostumeManager, didConnectToCostume costume: Costume) {
        costume.delegate?.costumeDidConnect(costume)
    }
    
    func costumeManager(costumeManager: CostumeManager, didUpdateState state: CostumeManagerState) {
        switch state {
        case .NotScanning:
            scanButton.title = "Scan"
        case .Scanning:
            scanButton.title = "Stop Scanning"
        }
    }
    
    // MARK: - Navigation methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        costumesTableView.dataSource = self
        globalCostumeManager.delegate = self
        scanButton.possibleTitles = ["Scan", "Stop Scanning"]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        globalCostumeManager.stopScanningForCostumes()
        
        if segue.identifier == "CostumeDetail" {
            let nextViewController = segue.destinationViewController as! CostumeViewController
            nextViewController.costume = sender as! Costume
        }
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
        let costume = globalCostumeManager.costumes[indexPath.row]
        costume.delegate = cell
        cell.delegate = self
        cell.costume = costume
        return cell
    }
    
}
