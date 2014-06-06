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

/*
myOrdrin.get_account_information(["email": "lol@lol.com", "password": "lolololol"], callback: {(error: NSError?, data: AnyObject?) -> () in
    println("got into callback")
    if(error) {
        println("error: \(error)")
        wait = false
    } else {
        println("results: \(data)")
        wait = false
    }
    })
*/

//myOrdrin.delivery_list("ASAP", zip: "77840", city: "College Station", addr: "102 Church Ave") // GIVES STRANGE ERROR
//myOrdrin.fee("147", subtotal: "20.42", tip: "5.05", datetime: "ASAP", zip: "77840", city: "College Station", addr: "1 Main St")

println("Hey")


//Crypto test code
var crypto: Crypto = Crypto()

var temp: NSString = "hello world"
println(crypto.sha256HashFor(temp))

println(myOrdrin.hashUser("temppass", email: "reggi@gmail.com", uri: "/path"))

var myDict = Dictionary<String, String>()


/*
//restaurant details test
myDict["rid"] = "147"
myOrdrin.restaurant_details(myDict, callback: {(error: NSError?, data: AnyObject?) -> () in
    println("success")
    println(data)
    wait = false
})
*/

/*
//delivery list test
myDict["datetime"] = "ASAP";
myDict["zip"] = "08820";
myDict["city"] = "Edison";
myDict["addr"] = "14 Annette Drive";
myOrdrin.delivery_list(myDict, callback: {(error: NSError?, data: AnyObject?) -> () in
    println("success")
    println(data)
    wait = false
    })
*/

/*
//delivery check test
myDict["rid"] = "147"
myDict["datetime"] = "ASAP";
myDict["zip"] = "77840";
myDict["city"] = "College Station";
myDict["addr"] = "1 Main Street";
myOrdrin.delivery_check(myDict, callback: {(error: NSError?, data: AnyObject?) -> () in
println("success")
println(data)
wait = false
})
*/

/*
//fee test
myDict["rid"] = "147"
myDict["subtotal"] = "20.42";
myDict["tip"] = "5.05";
myDict["datetime"] = "ASAP";
myDict["addr"] = "1 Main Street";
myDict["city"] = "College Station";
myDict["zip"] = "77840";
myOrdrin.fee(myDict, callback: {(error: NSError?, data: AnyObject?) -> () in
    println("success")
    println(data)
    wait = false
    })
*/

/*
//put test
myDict["email"] = "reggi2@gmail.com"
myDict["password"] = myOrdrin.hashUser("temppass", email: "reggi2@gmail.com", uri: "/u/reggi2@gmail.com/addr/work")
myDict["nick"] = "work"
myDict["addr"] = "902 broadway"
myDict["city"] = "New York"
myDict["state"] = "NY"
myDict["zip"] = "10010"
myDict["phone"] = "2018938715"

Agent.put("https://u-test.ordr.in/u/reggi2@gmail.com/addrs/work?_auth=1,orqweJcnpgD4mxVRPKRTGAVbTGab33DlqqEDllP4Bck",
    data: myDict, done: {(error: NSError?, response: NSHTTPURLResponse?, data: NSMutableData?) -> () in
        println("printing put reqeust")
        println(NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil))
        wait = false
    })
*/

//put test
myDict["email"] = "reggi2@gmail.com"
myDict["password"] = myOrdrin.hashUser("temppass", email: "reggi2@gmail.com", uri: "/u/reggi2@gmail.com/addr/work")
myDict["nick"] = "work"

Agent.delete("https://u-test.ordr.in/u/reggi2@gmail.com/addrs/work?_auth=1,orqweJcnpgD4mxVRPKRTGAVbTGab33DlqqEDllP4Bck",
    headers: myDict, done: {(error: NSError?, response: NSHTTPURLResponse?, data: NSMutableData?) -> () in
        println("printing delete reqeust")
        println(NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil))
        wait = false
    })


waitFor(&wait)
