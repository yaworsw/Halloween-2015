//
//  CostumeViewController.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

import UIKit

class CostumeViewController: UIViewController, UITableViewDataSource {
    
    var costume: Costume!
    
    @IBOutlet weak var costumeActionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        costumeActionsTableView.dataSource = self
        navigationItem.title = costume.name
    }

    // MARK: - UITableViewDataSource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return costume.getActions().count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let action = costume.getActions()[indexPath.row]
        switch action.type {
        case .Button:
            let cell = costumeActionsTableView.dequeueReusableCellWithIdentifier("CostumeActionButton") as! CostumeButtonActionTableViewCell
            cell.action = action
            return cell
        }
    }
    
}
