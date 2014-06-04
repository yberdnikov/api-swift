//
//  Ordrin.swift
//  api-swift

//  Copyright (c) 2014 Ordr.in. All rights reserved.
//

import Foundation

class Ordrin {

    class func waitFor (inout wait: Bool) {
        while (wait) {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1))
        }
    }

    class func delivery_list() {
        var wait: Bool = true

        Agent.get("http://headers.jsontest.com", done: { (error: NSError?, response: NSHTTPURLResponse?) -> () in
            if (error) {
                println(error)
                return
            }
            println(response!)
            wait = false
            })
        waitFor(&wait)
    }

}
