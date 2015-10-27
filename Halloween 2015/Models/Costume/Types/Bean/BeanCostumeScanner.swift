//
//  BeanCostumeScanner.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/23/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

import UIKit

class BeanCostumeScanner: NSObject, CostumeScanner, PTDBeanManagerDelegate {

    var delegate: CostumeScannerDelegate?
    
    var beanManager: PTDBeanManager!
    
    internal var beanCostumes: [BeanCostume] = []
    
    override init() {
        super.init()
        beanManager = PTDBeanManager(delegate: self)
    }
    
    // MARK: - Connection management
    
    func connect(costume: BeanCostume) {
        costume.state = .Connecting
        beanManager.connectToBean(costume.bean, error: nil)
    }
    
    func disconnect(costume: BeanCostume) {
        beanManager.disconnectBean(costume.bean, error: nil)
    }
    
    // MARK: - Scanning
    
    func startScan() {
        beanManager.startScanningForBeans_error(nil)
    }
    
    func stopScan() {
        beanManager.stopScanningForBeans_error(nil)
    }
    
    // MARK: - PTDBeanManagerDelegate
    
    func beanManager(beanManager: PTDBeanManager!, didDiscoverBean bean: PTDBean!, error: NSError!) {
        if !beanCostumes.contains({ return $0.bean.isEqualToBean(bean) }) {
            let costume = BeanCostume(bean, beanScanner: self)
            beanCostumes.append(costume)
            delegate?.costumeScanner(self, didDiscoverCostume: costume)
        }
    }
    
    func beanManager(beanManager: PTDBeanManager!, didConnectBean bean: PTDBean!, error: NSError!) {
        for costume in beanCostumes {
            if costume.bean.isEqualToBean(bean) {
                costume.state = .Connected
                return
            }
        }
    }
    
    func beanManager(beanManager: PTDBeanManager!, didDisconnectBean bean: PTDBean!, error: NSError!) {
        for costume in beanCostumes {
            if costume.bean.isEqualToBean(bean) {
                costume.state = .Disconnected
                return
            }
        }
    }
    
}
