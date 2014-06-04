//
//  main.swift
//  ordrin-api
//
//  Created by Eric Song on 6/4/14.
//  Copyright (c) 2014 ordrin. All rights reserved.
//

import Foundation

//Ordrin.restaurant_details("147")

var myOrdrin = Ordrin(apiKey: "orqweJcnpgD4mxVRPKRTGAVbTGab33DlqqEDllP4Bck", environment: "test")

func waitFor (inout wait: Bool) {
    while (wait) {
        NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1))
    }
}

var wait: Bool = true

myOrdrin.restaurant_details("147", callback: {(error: NSError?, data: NSDictionary?) -> () in
    println("got into callback")
    if(error) {
        println("error: \(error)")
        wait = false
    } else {
        println("results: \(data)")
        wait = false
    }
})

waitFor(&wait)


//myOrdrin.delivery_check("147", datetime: "ASAP", zip: "77840", city: "College Station", addr: "1 Main Street")
//myOrdrin.delivery_list("ASAP", zip: "77840", city: "College Station", addr: "102 Church Ave") // GIVES STRANGE ERROR
//myOrdrin.fee("147", subtotal: "20.42", tip: "5.05", datetime: "ASAP", zip: "77840", city: "College Station", addr: "1 Main St")

println("Hey")