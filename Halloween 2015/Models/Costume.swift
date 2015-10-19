//
//  Costume.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//
//  Defines the Costume protocol and other related protocols.
//

import UIKit

// MARK: - CostumeState

/**
    A state that a costume can be in

    - Unknown: The state is now currently known
    - Discovered: The costume is known about but we are not connected to it
    - Connecting: We're currently in the process of connecting to the costume 
    - Connected: We are connected to the costume and can transmit / recieve data
*/
enum CostumeState {
    case Unknown
    case Discovered
    case Connecting
    case Connected
}

// MARK: - Costume

/**
    A costume is a halloween costume which we can connect to and send certian messages to
*/
protocol Costume: class, NSObjectProtocol {
    
    /**
        The state of the costume
    */
    var state: CostumeState { get }
    
    /**
        The delegate for the costume
    */
    var delegate: CostumeDelegate? { get set }
    
    /**
        The costume's name which is displayed to the user
    */
    var name: String { get }
    
    // MARK: - Connect / Disconnect
    
    /**
        Attempt to connect to this costume
    */
    func connect()
    
    /**
        Disconnect from this costume
    */
    func disconnect()
    
    // MARK: - Actions
    
    /**
        Fetches an array of possible actions that can be sent to this toy
    
        - returns: An array of CostumeAction instances which will can be triggered by the user of the app to intereact with the costume
    */
    func getActions() -> [CostumeAction]

}

/**
    Delegate for implementors of the Costume protocol
*/
protocol CostumeDelegate {
    
    /**
        Called when the costume connects
    
        - Parameter costume: The costume that was connected
    */
    func costumeDidConnect(costume: Costume)
    
    /**
        Called when the costume disconnects
    
        - Parameter costume: The costume that was disconnected
    */
    func costumeDidDisconnect(costume: Costume)
    
    /**
        Called when the costume's battery voltage information is updated
    
        - Parameter costume: The costume who'se battery information was updated
        - Parameter batteryStatus: The battery's new status
    */
    func costume(costume: Costume, didUpdateBatteryVoltage batteryStatus: NSNumber)
    
    /**
        Called when the costume updates state eg: gets connected, disconnected, etc.
    */
    func costume(costume: Costume, didUpdateState state: CostumeState)
    
}

// MARK: - CostumeScanner

/**
    Costume scanners' responsibility is to search for costumes to connect to
*/
protocol CostumeScanner {

    /**
        The costume scanner's delegate.  Should probably only be set to the CostumeManager which which this scanner is associated with
    */
    var delegate: CostumeScannerDelegate? { get set }
    
    /**
        Start scanning for costumes
    */
    func scanForCostumes()
    
    /**
        Stop scanning for costumes
    */
    func stopScanningForCostumes() 
    
}

/**
    Delegate for a costume scanner.  Should probably only be implemented by the CostumeManager class
*/
protocol CostumeScannerDelegate {
    
    /**
        Called when the scanner discovers a costume
    
        - Parameter scanner: The scanner that discovered a costume
        - Parameter costume: The costume that was discovered
    */
    func costumeScanner(scanner: CostumeScanner, didDiscoverCostume costume: Costume)
    
}
