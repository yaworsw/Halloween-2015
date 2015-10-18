//
//  CostumeButtonActionTableViewCell.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

import UIKit

class CostumeButtonActionTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    var action: CostumeAction! {
        didSet {
            label.text = action.title
        }
    }

    @IBAction func triggerButtonTapped(sender: AnyObject) {
        action.action()
    }
}
