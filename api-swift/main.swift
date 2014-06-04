//
//  main.swift
//  ordrin-api
//
//  Created by Eric Song on 6/4/14.
//  Copyright (c) 2014 ordrin. All rights reserved.
//

import Foundation

func waitFor (inout wait: Bool) {
    while (wait) {
        NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1))
    }
}
    
    var wait: Bool = true

    Agent.get("https://r-test.ordr.in/rd/147?_auth=1,8l3kW3pv2UZXOebdQ-YU9qoUeE8GPPzj7_We-WxbKek",
        done: { (error: NSError?, response: NSHTTPURLResponse?, data: NSData?) -> () in
  
            if (error) {
                println("error 2")
                return
            } else {
                var results = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                
                println(results["addr"])
                wait = false
            }
        })
   
    waitFor(&wait)

println("done")
