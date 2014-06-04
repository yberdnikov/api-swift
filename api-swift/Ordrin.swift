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
        var api_key = "npr4VdOikTqNnq9WFsdlX-XzIUC_x1Ne_7FTlbfTMcc"
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
                    var results = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
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
                    var results = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                    println("results: \(results)")
                    wait = false
                }
            })
        
        waitFor(&wait)
    }
    
    class func fee(rid: String, subtotal: String, tip: String, datetime: String, zip: String, city: String, addr: String) {
        var api_key = "8l3kW3pv2UZXOebdQ-YU9qoUeE8GPPzj7_We-WxbKek"
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
                    var results = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                    println("results: \(results)")
                    wait = false
                }
            })
        
        waitFor(&wait)
    }

}