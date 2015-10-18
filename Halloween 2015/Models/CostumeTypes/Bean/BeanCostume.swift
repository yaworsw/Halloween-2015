//
//  BeanCostume.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

import UIKit

internal let STATE_UPDATE_LOOP_INTERVAL: Double = 0.1 // in seconds

class BeanCostume: NSObject, Costume, PTDBeanDelegate {

    var state: CostumeState {
        switch bean.state {
        case .Discovered:
            return .Discovered
        case .ConnectedAndValidated:
            return .Connected
        case .Unknown:
            return .Unknown
        default:
            return .Connecting
        }
    }
    
    var name: String {
        switch bean.name {
        case "h-2015-shirt":
            return "Shirt"
        default:
            return "Unknown"
        }
    }
    
    var costumeActions: [CostumeAction] = []
    
    var batteryVoltage: NSNumber?
    
    var delegate: CostumeDelegate?
    
    var bean: PTDBean!
    
    var scanner: BeanCostumeScanner!
    
    init(_ bean: PTDBean, beanScanner: BeanCostumeScanner) {
        super.init()
        
        self.bean = bean
        self.scanner = beanScanner
        self.batteryVoltage = bean.batteryVoltage
        
        bean.delegate = self
        
        // start state update loop
        stateUpdateLoop()
    }
    
    var prevState: CostumeState!
    internal func stateUpdateLoop() {
        if prevState == nil {
            prevState = state
        }
        var newState: CostumeState!
        backgroundThread(STATE_UPDATE_LOOP_INTERVAL, background: {
            newState = self.state
        }, completion: {
            if self.prevState != newState {
                self.delegate?.costume(self, didUpdateState: newState)
            }
            self.prevState = newState
            self.stateUpdateLoop()
        })
    }
    
    // MARK: - Actions / Messaging
    
    func getActions() -> [CostumeAction] {
        typealias Action = CostumeAction
        return [
            Action(title: "Blink Bean", type: .Button) {
                print("BLINK BEAN!")
                self.bean.sendSerialString("0_0\n")
            },
            
            Action(title: "Rainbow", type: .Button) {
                self.bean.sendSerialString("1_0\n")
            }
        ]
    }
    
    // MARK: - Connect / Disconnect
    
    func connect() {
        scanner.connect(self)
    }
    
    func disconnect() {
        scanner.disconnect(self)
    }
    
    // MARK: - PTDBeanDelegate methods
    
    func beanDidUpdateBatteryVoltage(bean: PTDBean!, error: NSError!) {
        batteryVoltage = bean.batteryVoltage
        self.delegate?.costume(self, didUpdateBatteryVoltage: bean.batteryVoltage)
    }
    
}
