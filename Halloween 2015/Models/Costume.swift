//
//  Costume.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

import UIKit

// MARK: - CostumeState

enum CostumeState {
    case Unknown
    case Discovered
    case Connecting
    case Connected
}

// MARK: - Costume

protocol Costume: class, NSObjectProtocol {
    
    var state: CostumeState { get }
    
    var delegate: CostumeDelegate? { get set }
    
    var name: String { get }
    
    // MARK: - Connect / Disconnect
    
    func connect()
    
    func disconnect()
    
    // MARK: - Actions
    
    func getActions() -> [CostumeAction]

}

protocol CostumeDelegate {
    
    func costumeDidConnect(costume: Costume)
    
    func costumeDidDisconnect(costume: Costume)
    
    func costume(costume: Costume, didUpdateBatteryVoltage batteryStatus: NSNumber)
    
    func costume(costume: Costume, didUpdateState state: CostumeState)
    
}

// MARK: - CostumeScanner

protocol CostumeScanner {

    var delegate: CostumeScannerDelegate? { get set }
    
    func scanForCostumes()
    
    func stopScanningForCostumes() 
    
}

protocol CostumeScannerDelegate {
    
    func costumeScanner(scanner: CostumeScanner, didDiscoverCostume costume: Costume)
    
}
