//
//  BeanCostumeScanner.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//
//  A costume scanner that looks for costumes using the Light Blue Bean as their micro controller
//

import UIKit

/**
    An array of strings which are the names of the beans we'd want to connect to
*/
internal let beanCostumeNames = [
    "h-2015-shirt"
]

/**
    A costume search strategy which looks for costumes using the Light Blue Bean as their micro controller
*/
class BeanCostumeScanner: NSObject, CostumeScanner, PTDBeanManagerDelegate {
    
    /**
        An array of already discovered costumes.
    
        Sometimes the beanManager will 'discover' the same bean multiple times for the same costume.  We keep this away so we can be sure we only discover a bean exactly once
    */
    internal var beanCostumes: [BeanCostume] = []
    
    /**
        The delegate that listens for events from the BeanCostumeScanner
    */
    var delegate: CostumeScannerDelegate?
    
    /**
        An instance of BeanManager which we use to do our scanning
    */
    var beanManager: PTDBeanManager!
    
    /**
        Initializes the scanner (and the bean manager)
    */
    override init() {
        super.init()
        beanManager = PTDBeanManager(delegate: self)
    }
    
    // MARK: - Connect / Disconnect
    
    /**
        Connect to a bean costume
    
        Since we need access to the beanManager to connect to a bean it makes sense to have the costume call out to the scanner when it wants to be connected
    
        - Parameter: costume: The costume that wants to be connected
    */
    func connect(costume: BeanCostume) {
        beanManager.connectToBean(costume.bean, error: nil)
    }
    
    /**
        Disconnect from a bean costume
    
        - Parameter: costume: The costume to disconnect from
    
        @see BeanCostumeScanner.connect
    */
    func disconnect(costume: BeanCostume) {
        beanManager.disconnectBean(costume.bean, error: nil)
    }
    
    // MARK: - CostumeScanner methods
    
    /**
        Begin searching for costumes using the Light Blue Bean micro controller
    */
    func scanForCostumes() {
        beanManager.startScanningForBeans_error(nil)
    }
    
    /**
        Stop searching for costumes
    */
    func stopScanningForCostumes() {
        beanManager.stopScanningForBeans_error(nil)
    }
    
    // MARK: - PTDBeanManagerDelegate methods
    
    /**
        Called when the bean manager discovers a bean
    
        - Parameter beanManager: The bean manager instance
        - Parameter bean: The bean that was discovered
        - Parameter error: An error if one occoured
    */
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
    
    /**
        Called when the bean manager connecs to a bean
    
        - Parameter beanManager: The bean manager instance
        - Parameter bean: The bean that was connected to
        - Parameter error: An error if one occoured
    */
    func beanManager(beanManager: PTDBeanManager!, didConnectToBean bean: PTDBean!, error: NSError!) {
        for costume in beanCostumes {
            if costume.bean.isEqualToBean(bean) {
                costume.delegate?.costumeDidConnect(costume)
                return
            }
        }
    }
    
    /**
        Called when the bean manager disconnects from a bean
    
        - Parameter beanManager: The bean manager instance
        - Parameter bean: The bean that was disconnected from
        - Parameter error: An error if one occoured
    */
    func beanManager(beanManager: PTDBeanManager!, didDisconnectBean bean: PTDBean!, error: NSError!) {
        for costume in beanCostumes {
            if costume.bean.isEqualToBean(bean) {
                costume.delegate?.costumeDidDisconnect(costume)
                return
            }
        }
    }
    
}
