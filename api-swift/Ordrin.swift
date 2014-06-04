//
//  Ordrin.swift
//  api-swift

//  Copyright (c) 2014 Ordr.in. All rights reserved.
//

import Foundation

class Ordrin {
    
    // declare class variables
    let apiKey : String
    let environment : String
    let urls : Dictionary<String,String>
    
    // initialize instance of class
    init(apiKey: String, environment: String) {
        self.apiKey = apiKey
        self.environment = environment
        
        if(environment == "test") {
            urls = [
                "restaurant" : "https://r-test.ordr.in",
                "order" : "https://o-test.ordr.in",
                "user" : "https://u-test.ordr.in"
            ]
        } else { // environment == "production"
            urls = [
                "restaurant" : "https://r.ordr.in",
                "order" : "https://o.ordr.in",
                "user" : "https://u.ordr.in"
            ]
        }
    }
    
    func makeApiRequest( apiGroup : String, endpointPattern : String, parameters: String[] /*, callback : typeIn -> typeOut */ ) -> String {
        var server = urls[apiGroup]
        var authentication = "_auth=1,\(apiKey)"
        println(server)
        return "done!"
    }
    
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
            println(response)
            wait = false
        })
        waitFor(&wait)
    }
    
}