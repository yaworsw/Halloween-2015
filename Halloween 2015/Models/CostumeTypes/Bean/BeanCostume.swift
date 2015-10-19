//
//  BeanCostume.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//
// BeanCostume represents a costume that uses a Light Blue Bean as it's micro controller
//
// @see http://legacy.punchthrough.com/bean/
//

import UIKit

/**
    The rate of which we check to see if the bean's state has changed

    @see BeanCostume.stateUpdateLoop
*/
internal let STATE_UPDATE_LOOP_INTERVAL: Double = 0.1 // in seconds

/**
    A BeanCostume is a costume built using the Light Blue Bean as it's micro controller
*/
class BeanCostume: NSObject, Costume, PTDBeanDelegate {

    /**
        The current state of the costume
    */
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
    
    /**
        The costume's name which is displayed to the user when selecting a cotume to interact with
    */
    var name: String {
        switch bean.name {
        case "h-2015-shirt":
            return "Shirt"
        default:
            return "Unknown"
        }
    }
    
    /**
        The battery voltage of the Light Blue Bean's coin cell
    */
    var batteryVoltage: NSNumber?
    
    /**
        The delegate that responds to events from this costume
    */
    var delegate: CostumeDelegate?
    
    /**
        This PTDBean instance is what is used to interact with the costume under the hood
    */
    var bean: PTDBean!
    
    /**
        The scanner that found this costume. 
    
        We keep a reference to the scanner so that we can call connect / disconnect on it later
    */
    var scanner: BeanCostumeScanner!
    
    /**
        Instanciate a BeanCostume
    
        - Parameter bean: A PTDBean instance that represents the bean on the costume
        - Parameter beanScanner: The bean scanner that discovered this costume
    */
    init(_ bean: PTDBean, beanScanner: BeanCostumeScanner) {
        super.init()
        
        self.bean = bean
        self.scanner = beanScanner
        self.batteryVoltage = bean.batteryVoltage
        
        bean.delegate = self
        
        // start state update loop
        stateUpdateLoop()
    }
    
    // MARK: - state update loop
    
    /**
        The state of the costume the last time we checked
    
        Since we watch for state changes by checking over and over we need to keep the value of the costume's state the last time we checked
    */
    internal var prevState: CostumeState!
    
    /**
        This loop is called in a background thread and checks to see if the costume's state has changed
    */
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
    
    /**
        Returns the actions that this costume can do
    
        returns: An array of CostumeAction instances that this costume can do
    */
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
    
    /**
        Connect this costume
    */
    func connect() {
        scanner.connect(self)
    }
    
    /**
        Disconnect this costume
    */
    func disconnect() {
        scanner.disconnect(self)
    }
    
    // MARK: - PTDBeanDelegate methods
    
    /**
        Called when the bean's battery voltage value is updated
    
        - Parameter bean: The bean who'se battery voltage waws updated
        - Parapeter error: An error if there was one
    */
    func beanDidUpdateBatteryVoltage(bean: PTDBean!, error: NSError!) {
        batteryVoltage = bean.batteryVoltage
        self.delegate?.costume(self, didUpdateBatteryVoltage: bean.batteryVoltage)
    }
    
}
