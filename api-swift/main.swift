//
//  main.swift
//  ordrin-api
//
//  Created by Eric Song on 6/4/14.
//  Copyright (c) 2014 ordrin. All rights reserved.
//

import Foundation

//Ordrin.restaurant_details("147")
//Ordrin.fee("23844", subtotal: "22.00", tip: "5.00", datetime: "ASAP", zip: "10010", city: "New York", addr: "902 Broadway")

var myOrdrin = Ordrin(apiKey: "orqweJcnpgD4mxVRPKRTGAVbTGab33DlqqEDllP4Bck", environment: "test")

func waitFor (inout wait: Bool) {
    while (wait) {
        NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1))
    }
}

var wait: Bool = true

var tmp = "8312817"
if tmp.toInt() {
    println("int found")
} else {
    println("not int found")
}


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


//Crypto test code
var crypto: Crypto = Crypto()

var temp: NSString = "hello world"
println(crypto.sha256HashFor(temp))

println(myOrdrin.hashUser("temppass", email: "reggi@gmail.com", uri: "/path"))

