//
//  CostumeScanner.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/23/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

protocol CostumeScanner {
    
    var delegate: CostumeScannerDelegate? { get set }
    
    func startScan()
    func stopScan()
    
}

protocol CostumeScannerDelegate {
    
    func costumeScanner(scanner: CostumeScanner, didDiscoverCostume costume: Costume)
    
}