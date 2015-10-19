//
//  CostumeAction.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//
//  Defines the CostumeAction struct which is used in the UI to display the actions that can be triggered for a given costume.
//

import UIKit

/**
    Specifies how a CostumeAction should be displayed

    - Button: Displays the action on the view as a table row with a label and a button
*/
enum CostumeActionType {
    case Button
}

internal typealias Action = () -> ()

/**
    The data required to display and trigger an action
*/
struct CostumeAction {

    /**
        The name for the action that will be displayed to the user
    */
    var title: String
    
    /**
        The type of action.  Used to determine how the action is rendered in the UI
    */
    var type: CostumeActionType
    
    // TODO: Should rename action?
    
    /**
        A closure that gets called when the action is triggered
    */
    var action: Action
    
}
