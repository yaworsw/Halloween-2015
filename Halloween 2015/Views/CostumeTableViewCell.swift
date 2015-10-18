//
//  CostumeTableViewCell.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

import UIKit

protocol CostumeTableViewCellDelegate {
    
    func costumeTableViewCell(cell: CostumeTableViewCell, didSelectViewFor costume: Costume)
    
}

class CostumeTableViewCell: UITableViewCell, CostumeDelegate {

    @IBOutlet weak var disconnectButton: UIButton!
    
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var costumeNameLabel: UILabel!
    
    @IBOutlet weak var batteryStatusLabel: UILabel!
    
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
            case .Discovered:
                disconnectButton.hidden = true
                actionButton.setTitle("Connect", forState: .Normal)
                actionButton.enabled = true
            case .Connecting:
                disconnectButton.hidden = true
                actionButton.setTitle("Connecting...", forState: .Disabled)
                actionButton.enabled = false
            case .Connected:
                disconnectButton.hidden = false
                actionButton.setTitle("View", forState: .Normal)
                actionButton.enabled = true
            case .Unknown:
                disconnectButton.hidden = true
                actionButton.setTitle("State Unknown", forState: .Disabled)
                actionButton.enabled = false
            }
        }
    }
    
    // MARK: - actions
    
    @IBAction func disconnectButtonTapped(sender: AnyObject) {
        costume.disconnect()
    }
    
    @IBAction func actionButtonTapped(sender: AnyObject) {
        switch costumeState! {
        case .Discovered:
            costume.connect()
        case .Connected:
            delegate?.costumeTableViewCell(self, didSelectViewFor: costume)
        default:
            break
        }
    }

    // MARK: - initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        batteryStatusLabel.text = ""
    }
    
    // MARK: - CostumeDelegate methods
    
    func costumeDidConnect(costume: Costume) {
        actionButton.setTitle("Manage", forState: .Normal)
    }
    
    func costumeDidDisconnect(costume: Costume) {
        actionButton.setTitle("Connect", forState: .Normal)
        batteryStatusLabel.text = ""
    }
    
    func costume(costume: Costume, didUpdateBatteryVoltage: NSNumber) {
        batteryStatusLabel.text = "Bat: \(didUpdateBatteryVoltage)v"
    }
    
    func costume(costume: Costume, didUpdateState state: CostumeState) {
        self.costumeState = state
    }
    
}
