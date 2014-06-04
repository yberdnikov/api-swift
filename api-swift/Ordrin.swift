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
    /*
    class func restaurant_details(rid: String) {
        var api_key = "orqweJcnpgD4mxVRPKRTGAVbTGab33DlqqEDllP4Bck"
        var wait: Bool = true

        //var url = "http://r-test.ordr.in/rd/\(rid)"
        var url = "http:/headers.jsontest.com"
        println("Sending req")
        println(url)
        Agent.get(url, headers: "X-NAAMA-CLIENT-AUTHENTICATION", value: "id=\" \(api_key) \", version=\"1\"", done: { (error: NSError?, response: NSHTTPURLResponse?) -> () in
            if (error) {
                println(error)
                return
            }
            println(response!)
            wait = false
            })
        waitFor(&wait)
    }
    */
}