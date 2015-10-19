//
//  threadManagement.swift
//  Halloween 2015
//
//  Created by William Yaworsky on 10/17/15.
//  Copyright © 2015 William Yaworsky. All rights reserved.
//
//  Includes the backgroundThread from stackoverflow
//  @see http://stackoverflow.com/a/30841417/1185698
//

import Foundation

/**
    Executes a closure in a background thread.

    - Parameter delay: The amount of time in seconds to wait before executing the closure
    - Parameter background: The closure to execute in the background
    - Parameter completion: A closure to execute on the main thread when the background closure completes
*/
func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
    dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.rawValue), 0)) {
        if(background != nil) { background!(); }
        
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(popTime, dispatch_get_main_queue()) {
            if(completion != nil){ completion!(); }
        }
    }
}