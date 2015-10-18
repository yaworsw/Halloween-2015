//
//  BeanCostumeScanner.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

import UIKit

internal let beanCostumeNames = [
    "h-2015-shirt"
]

class BeanCostumeScanner: NSObject, CostumeScanner, PTDBeanManagerDelegate {
    
    internal var beanCostumes: [BeanCostume] = []
    
    var delegate: CostumeScannerDelegate?
    
    var beanManager: PTDBeanManager!
    
    override init() {
        super.init()
        beanManager = PTDBeanManager(delegate: self)
    }
    
    // MARK: - Connect / Disconnect
    
    func connect(costume: BeanCostume) {
        beanManager.connectToBean(costume.bean, error: nil)
    }
    
    func disconnect(costume: BeanCostume) {
        beanManager.disconnectBean(costume.bean, error: nil)
    }
    
    // MARK: - CostumeScanner methods
    
    func scanForCostumes() {
        beanManager.startScanningForBeans_error(nil)
    }
    
    func stopScanningForCostumes() {
        beanManager.stopScanningForBeans_error(nil)
    }
    
    // MARK: - PTDBeanManagerDelegate methods
    
    func beanManager(beanManager: PTDBeanManager!, didDiscoverBean bean: PTDBean!, error: NSError!) {
        if let name = bean.name {
            if beanCostumeNames.contains(name) {
                if !beanCostumes.contains({ return $0.bean.isEqualToBean(bean) }) {
                    let costume = BeanCostume(bean, beanScanner: self)
                    beanCostumes.append(costume)
                    delegate?.costumeScanner(self, didDiscoverCostume: costume)
                }

            }
        }
    }
    
    func beanManager(beanManager: PTDBeanManager!, didConnectToBean bean: PTDBean!, error: NSError!) {
        for costume in beanCostumes {
            if costume.bean.isEqualToBean(bean) {
                costume.delegate?.costumeDidConnect(costume)
                return
            }
        }
    }
    
    func beanManager(beanManager: PTDBeanManager!, didDisconnectBean bean: PTDBean!, error: NSError!) {
        for costume in beanCostumes {
            if costume.bean.isEqualToBean(bean) {
                costume.delegate?.costumeDidDisconnect(costume)
                return
            }
        }
    }
    
}
