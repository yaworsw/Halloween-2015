//
//  Costume.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/23/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

enum CostumeState {
    case Connected
    case Disconnected
    case Connecting
    case Unknown
}

enum CostumeAction {
    case Identify
    case Rainbow
    case RainbowAll
    case RainbowShift
    case SetLEDs
    case SetBrightness
}

protocol Costume {
    
    var delegate: CostumeDelegate? { get set }
    
    var name: String { get }
    
    var state: CostumeState { get set }
    
    func connect()
    func disconnect()
    
    func doAction(action: CostumeAction, withParams params: [String])
    
}

protocol CostumeDelegate {
    
    func costume(costume: Costume, didUpdateState state: CostumeState)
    
}