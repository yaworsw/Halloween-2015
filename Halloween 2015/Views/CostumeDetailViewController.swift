//
//  CostumeViewController.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/23/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

import UIKit

class CostumeDetailViewController: UIViewController {

    var costumes: [Costume]!
    
    var multiCostumeSelection = false

    override func viewDidLoad() {
        super.viewDidLoad()

        if multiCostumeSelection {
            navigationItem.title = "Connected Costumes (\(costumes.count))"
        } else {
            navigationItem.title = costumes[0].name
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Identify", style: .Plain, target: self, action: "identifyCostumes")
    }

    @IBAction func rainbowSequenceButtonWasPressed(sender: AnyObject) {
        doAction(.Rainbow)
    }
    
    @IBAction func rainbowAllButtonWasPressed(sender: AnyObject) {
        doAction(.RainbowAll)
    }

    @IBAction func rainbowShiftButtonWasPressed(sender: AnyObject) {
        doAction(.RainbowShift)
    }
    
    @IBAction func setColorSliderWasMoved(sender: UISlider) {
        let intVal = Int(sender.value)
        doAction(.SetLEDs, withParams: [String(intVal)])
    }
    
    @IBAction func setBrightnessSliderWasMoved(sender: UISlider) {
        let intVal = Int(sender.value)
        doAction(.SetBrightness, withParams: [String(intVal)])
    }
    
    @IBAction func animationSpeedSliderWasMoved(sender: UISlider) {
        let intVal = Int(sender.value)
        doAction(.SetAnimationSpeed, withParams: [String(intVal)])
    }
    
    @IBAction func offButtonWasTapped(sender: AnyObject) {
        doAction(.Off)
    }
    
    func identifyCostumes() {
        costumes.forEach { $0.doAction(.Identify, withParams: []) }
    }
    
    func doAction(action: CostumeAction) {
        doAction(action, withParams: [])
    }
    
    func doAction(action: CostumeAction, withParams: [String]) {
        costumes.forEach { $0.doAction(action, withParams: withParams) }
    }
    
}
