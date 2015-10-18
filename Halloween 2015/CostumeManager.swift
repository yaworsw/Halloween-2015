//
//  CostumeManager.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

import UIKit

let costumeManager = CostumeManager()

enum CostumeManagerState {
    case Scanning
    case NotScanning
}

// MARK: CostumeManager

class CostumeManager: NSObject, CostumeScannerDelegate {

    var costumes: [Costume] = []
    
    var scanners: [CostumeScanner] = []
    
    var delegate: CostumeManagerDelegate?
    
    var state = CostumeManagerState.NotScanning {
        didSet {
            delegate?.costumeManager(self, didUpdateState: state)
        }
    }
    
    override init() {
        super.init()
    }
    
    // MARK: - Scanner management
    
    func scanForCostumes() {
        for scanner in scanners {
            scanner.scanForCostumes()
        }
        state = .Scanning
    }
    
    func stopScanningForCostumes() {
        for scanner in scanners {
            scanner.stopScanningForCostumes()
        }
        state = .NotScanning
    }
    
    func addScanner(var scanner: CostumeScanner) {
        scanner.delegate = self
        scanners.append(scanner)
    }
    
    // MARK: - CostumeScannerDelegate methods
    
    func costumeScanner(scanner: CostumeScanner, didDiscoverCostume costume: Costume) {        
        costumes.append(costume);
        self.delegate?.costumeManager(self, didDiscoverCostume: costume)
    }
    
}

// MARK: CostumeManagerDelegate

protocol CostumeManagerDelegate {
    
    func costumeManager(costumeManager: CostumeManager, didDiscoverCostume costume: Costume)
    
    func costumeManager(costumeManager: CostumeManager, didConnectToCostume costume: Costume)
    
    func costumeManager(costumeManager: CostumeManager, didUpdateState state: CostumeManagerState)
    
}
