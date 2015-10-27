//
//  CostumeManager.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/23/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

import UIKit

let costumeManager = CostumeManager()

enum CostumeManagerState {
    case Scanning
    case NotScanning
}

protocol CostumeManagerDelegate {
    
    func costumeManager(manager: CostumeManager, didFindCostume costume: Costume)
    
    func costumeManager(manager: CostumeManager, didUpdateState state: CostumeManagerState)
    
}

class CostumeManager: NSObject, CostumeScannerDelegate {
    
    var costumes: [Costume] = []
    
    var delegate: CostumeManagerDelegate?

    var scanners: [CostumeScanner] = []
    
    internal(set) var state: CostumeManagerState = .NotScanning {
        didSet {
            delegate?.costumeManager(self, didUpdateState: state)
        }
    }
    
    func addScanner(var scanner: CostumeScanner) {
        scanner.delegate = self
        scanners.append(scanner)
    }
    
    // MARK: - start / stop scanning
    
    func startScan() {
        for scanner in scanners {
            scanner.startScan()
        }
        state = .Scanning
    }
    
    func stopScan() {
        for scanner in scanners {
            scanner.stopScan()
        }
        state = .NotScanning
    }
    
    // MARK: - CostumeScannerDelegate methods
    
    func costumeScanner(scanner: CostumeScanner, didDiscoverCostume costume: Costume) {
        costumes.append(costume)
        self.delegate?.costumeManager(self, didFindCostume: costume)
    }
    
}
