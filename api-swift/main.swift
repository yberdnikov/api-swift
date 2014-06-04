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

/*

    Agent.get("http://localhost:8000/testGet",
        done: { (error: NSError?, response: NSHTTPURLResponse?, data: NSData?) -> () in
  
            if (error) {
                println("error 2")
                return
            } else {
                var results = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                
                println(results["text"])
                wait = false
            }
        })
*/


    Agent.post("http://localhost:8000/testPost",
        data: ["text": "hi"],
        done: { (error: NSError?, response: NSHTTPURLResponse?, data: NSData?) -> () in
        if (error) {
            println("error 2")
            return
        } else {
            var results = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            println(results)
        }
            
            
            wait = false
    })



    waitFor(&wait)

println("done")
