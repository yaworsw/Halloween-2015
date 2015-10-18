//
//  CostumeAction.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//

import UIKit

enum CostumeActionType {
    case Button
}

internal typealias Action = () -> ()

struct CostumeAction {

    var title: String
    var type: CostumeActionType
    var action: Action
    
}
