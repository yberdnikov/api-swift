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
    /*
    class func restaurant_details(rid: String) {
        var api_key = ""
        var url = "https://r-test.ordr.in/rd/\(rid)?_auth=1,\(api_key)"
        var wait: Bool = true

        Agent.get(url,
            done: { (error: NSError?, response: NSHTTPURLResponse?, data: NSData?) -> () in
                if (error) {
                    println("error: \(error)")
                    return
                } else {
                    var results = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                    println(results)
                    wait = false
                }
            })
        
        waitFor(&wait)
    }
    
    class func delivery_list(datetime: String, zip: String, city: String, addr: String) {
        var api_key = ""
        var url = "https://r-test.ordr.in/dl/\(datetime)/\(zip)/\(city)/\(addr)?_auth=1,\(api_key)"
        var encodedUrl: NSString = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding);
        println(encodedUrl)
        var wait: Bool = true
        
        Agent.get(encodedUrl,
            done: { (error: NSError?, response: NSHTTPURLResponse?, data: NSData?) -> () in
                println("disri")
                if (error) {
                    println("error: \(error)")
                } else {
                    var results = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) //as NSDictionary
                    println("results: \(results)")
                    wait = false
                }
            })
        
        waitFor(&wait)
    }
    
    class func delivery_check(rid: String, datetime: String, zip: String, city: String, addr: String) {
        var api_key = ""
        var url = "https://r-test.ordr.in/dc/\(rid)/\(datetime)/\(zip)/\(city)/\(addr)?_auth=1,\(api_key)"
        var encodedUrl: NSString = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding);
        println(encodedUrl)
        var wait: Bool = true
        
        Agent.get(encodedUrl,
            done: { (error: NSError?, response: NSHTTPURLResponse?, data: NSData?) -> () in
                println("disri")
                if (error) {
                    println("error: \(error)")
                } else {
                    var results = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) //as NSDictionary
                    println("results: \(results)")
                    wait = false
                }
            })
        
        waitFor(&wait)
    }
    
    class func fee(rid: String, subtotal: String, tip: String, datetime: String, zip: String, city: String, addr: String) {
        var api_key = ""
        var url = "https://r-test.ordr.in/fee/\(rid)/\(subtotal)/\(tip)/\(datetime)/\(zip)/\(city)/\(addr)?_auth=1,\(api_key)"
        var encodedUrl: NSString = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding);
        println(encodedUrl)
        var wait: Bool = true
        
        Agent.get(encodedUrl,
            done: { (error: NSError?, response: NSHTTPURLResponse?, data: NSData?) -> () in
                println("disri")
                if (error) {
                    println("error: \(error)")
                } else {
                    var results = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) //as NSDictionary
                    println("results: \(results)")
                    wait = false
                }
            })
        
        waitFor(&wait)
    }
    */
}
