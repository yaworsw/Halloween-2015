//
//  CostumeManager.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//
//  Defines the costumeManager global which is an instance of CostumeManager.  This global is used to search for costumes to connect to.
//

import UIKit

let costumeManager = CostumeManager()

/**
    Represents a possible state for a costume manager
    
    - Scanning: The costume manager is looking for costumes 
    - NotScanning: The costume manager is not looking for costumes
 */
enum CostumeManagerState {
    case Scanning
    case NotScanning
}

// MARK: CostumeManagerDelegate

/** 
    The delegate for the CostumeManager class
*/
protocol CostumeManagerDelegate {
    
    /**
        Called when a costume is discovered by one of the CostumeScanners given to the CostumeManager
    
        - Parameter costumeManager: The CostumeManager instance that discovered a costume
        - Parameter costume: The costume that was discovered
    */
    func costumeManager(costumeManager: CostumeManager, didDiscoverCostume costume: Costume)
    
    /**
        Called when a costume gets disconnected
    
        - Parameter costumeManager: The CostumeManager instance that was responsible for the toy that disconnected
        - Parameter costume: The costume that was disconnected
    */
    func costumeManager(costumeManager: CostumeManager, didConnectToCostume costume: Costume)
    
    /**
        Called when the CostumeManager's state property is updated
    
        - Parameter costumeManager: The instance of CostumeManager who'se state changed
        - Parameter state: The new state of the costume manager
    */
    func costumeManager(costumeManager: CostumeManager, didUpdateState state: CostumeManagerState)
    
}

// MARK: CostumeManager

/**
    Searches for and manages costumes
*/
class CostumeManager: NSObject, CostumeScannerDelegate {

    /**
        An array of costumes that have been discovered
    */
    var costumes: [Costume] = []
    
    /**
        An array of costume search strategies
    */
    var scanners: [CostumeScanner] = []
    
    /**
        The delegate for this costume manager
    */
    var delegate: CostumeManagerDelegate?
    
    /**
        The state of the costume manager
    */
    var state = CostumeManagerState.NotScanning {
        didSet {
            delegate?.costumeManager(self, didUpdateState: state)
        }
    }
    
    // MARK: - Scanner management
    
    /**
        Begin searching for nearby costumes.
    */
    func scanForCostumes() {
        for scanner in scanners {
            scanner.scanForCostumes()
        }
        state = .Scanning
    }
    
    /**
        Stop searching for nearby costumes.
    */
    func stopScanningForCostumes() {
        for scanner in scanners {
            scanner.stopScanningForCostumes()
        }
        state = .NotScanning
    }
    
    /**
        Adds a search strategy to the strategies that will be executed when scanForCostumes is called
        
        - Parameter scanner: A CostumeScanner whose scanForCostumes method will be called when the costume manager's scanForCostumes is called
    */
    func addScanner(var scanner: CostumeScanner) {
        scanner.delegate = self
        scanners.append(scanner)
    }
    
    // MARK: - CostumeScannerDelegate methods
    
    /** 
        Called when a CostumeScanner discovers a new costume 
    
        - Parameter scanner: The scanner that found the costume
        - Parameter costime: The costime that was discovered
    */
    func costumeScanner(scanner: CostumeScanner, didDiscoverCostume costume: Costume) {        
        costumes.append(costume);
        self.delegate?.costumeManager(self, didDiscoverCostume: costume)
    }
    
}
