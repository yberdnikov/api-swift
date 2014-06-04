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
    
    func makeApiRequest( apiGroup : String, endpointPath : String, parameters: String[] /*, callback : typeIn -> typeOut */ ) {
        // set up the host + path
        var urlPath = urls[apiGroup]! + endpointPath
        for param in parameters{
            urlPath += "/\(param)"
        }
        // add authentication (since we're not using headers yet)
        urlPath += "?_auth=1,\(apiKey)"
        // sanity check
        var encodedUrl : NSString = urlPath.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        println(urlPath)
        // Agent stuff
        var wait: Bool = true
        Agent.get(encodedUrl,
            done: { (error: NSError?, response: NSHTTPURLResponse?, data: NSData?) -> () in
                if (error) {
                    println("error: \(error)")
                } else {
                    var results = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                    println(results)
                    wait = false
                }
            })
        
        waitFor(&wait)
        //return "done!" // change the return to what it's supposed to be
    }
    
    
    // may remove once properly passing in cb functions
    func waitFor (inout wait: Bool) {
        while (wait) {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1))
        }
    }

    
    func restaurant_details(rid: String) {
        makeApiRequest("restaurant", endpointPath: "/rd", parameters: [rid])
    }
    
    func delivery_list(datetime: String, zip: String, city: String, addr: String) {
        makeApiRequest("restaurant", endpointPath: "/dl", parameters: [datetime, zip, city, addr])
    }
    
    func delivery_check(rid: String, datetime: String, zip: String, city: String, addr: String) {
        makeApiRequest("restaurant", endpointPath: "/dc", parameters: [rid, datetime, zip, city, addr])
    }
    
    func fee(rid: String, subtotal: String, tip: String, datetime: String, zip: String, city: String, addr: String) {
        makeApiRequest("restaurant", endpointPath: "/fee", parameters: [rid, subtotal, tip, datetime, zip, city, addr])
    }
}
