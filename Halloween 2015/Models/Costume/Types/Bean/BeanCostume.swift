//
//  BeanCostume.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/23/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

import UIKit

class BeanCostume: NSObject, Costume, PTDBeanDelegate {

    var name: String {
        return bean.name
    }
    
    var state: CostumeState = .Disconnected {
        didSet {
            delegate?.costume(self, didUpdateState: state)
        }
    }
    
    var delegate: CostumeDelegate?
    
    var scanner: BeanCostumeScanner!
    
    var bean: PTDBean!
    
    init(_ bean: PTDBean, beanScanner: BeanCostumeScanner) {
        super.init()
        
        self.bean = bean
        self.scanner = beanScanner
        
        bean.delegate = self
    }
    
    // MARK: - Sending data to beans
    
    func doAction(action: CostumeAction, withParams params: [String]) {
        switch action {
        case .Identify:
            bean.sendSerialString("bb_\n")
        case .Rainbow:
            bean.sendSerialString("rainbow_\n")
        case .RainbowAll:
            bean.sendSerialString("rainbow-all_\n")
        case .RainbowShift:
            bean.sendSerialString("rainbow-shift_\n")
        case .SetLEDs:
            bean.sendSerialString("set-leds_\(params[0])\n")
        case .SetBrightness:
            bean.sendSerialString("set-bri_\(params[0])\n")
        case .SetAnimationSpeed:
            bean.sendSerialString("change-delay_\(params[0])\n")
        case .Off:
            bean.sendSerialString("off_\n")
        }
    }
    
    // MARK: - Connection management
    
    func connect() {
        scanner.connect(self)
    }
    
    func disconnect() {
        scanner.disconnect(self)
    }
    
}
