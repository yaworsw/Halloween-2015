//
//  CostumeTableViewCell.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/23/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

import UIKit

protocol CostumeTableViewCellDelegate {
    
    func costumeTableViewCell(cell: CostumeTableViewCell, didSelectViewFor costume: Costume)
    
}

class CostumeTableViewCell: UITableViewCell, CostumeDelegate {

    @IBOutlet weak var costumeNameLabel: UILabel!
    
    @IBOutlet weak var manageCostumeButton: UIButton!
    
    @IBOutlet weak var disconnectButton: UIButton!
    
    var delegate: CostumeTableViewCellDelegate?
    
    var costume: Costume! {
        didSet {
            costumeState = costume.state
            costumeNameLabel.text = costume.name
        }
    }
    
    var costumeState: CostumeState! {
        didSet {
            switch costumeState! {
            case .Disconnected:
                disconnectButton.hidden = true
                manageCostumeButton.setTitle("Connect", forState: .Normal)
                manageCostumeButton.enabled = true
            case .Connecting:
                disconnectButton.hidden = true
                manageCostumeButton.setTitle("Connecting...", forState: .Disabled)
                manageCostumeButton.enabled = false
            case .Connected:
                disconnectButton.hidden = false
                manageCostumeButton.setTitle("View", forState: .Normal)
                manageCostumeButton.enabled = true
            case .Unknown:
                disconnectButton.hidden = true
                manageCostumeButton.setTitle("State Unknown", forState: .Disabled)
                manageCostumeButton.enabled = false
            }
        }
    }
    
    // MARK: - Button presses
    
    @IBAction func disconnectButtonTapped(sender: AnyObject) {
        costume.disconnect()
    }
    
    @IBAction func manageCostumeTapped(sender: AnyObject) {
        switch costumeState! {
        case .Disconnected:
            costume.connect()
        case .Connected:
            delegate?.costumeTableViewCell(self, didSelectViewFor: self.costume)
        default:
            break
        }
    }
    
    // MARK: - init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - CostumeDelegate methods
    
    func costume(costume: Costume, didUpdateState state: CostumeState) {
        costumeState = state
    }
    
}
