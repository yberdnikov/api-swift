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
    
    class func restaurant_details(rid: String) {
        var api_key = "orqweJcnpgD4mxVRPKRTGAVbTGab33DlqqEDllP4Bck"
        var wait: Bool = true

        var url = "http://r-test.ordr.in/rd/\(rid)?_auth=1,\(api_key)"
        println("Sending req")
        println(url)
        var newUrl = NSURL(string: url)
        var request = NSURLRequest(URL: newUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            wait = false
        })
        waitFor(&wait)
    }
    
}