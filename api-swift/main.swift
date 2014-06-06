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

/*
Creat cc
var params = ["email": "testSam2@example.com", "password": "testpass", "card_name": "Sam Agnew",
        "card_cvc": "123", "expiry_month": "02", "expiry_year": "2016", "type": "visa", "bill_addr": "224 Maurice Blvd",
        "bill_city": "Rio Grande", "bill_state": "NJ", "bill_zip": "08242", "bill_phone": "6107616189",
        "number": "4111111111111111", "nick": "doge"
    ]
*/

/*
User order with no addr or cc
var params = ["email": "testSam2@example.com", "password": "testpass", "card_name": "Sam Agnew",
    "card_cvc": "123", "card_expiry": "02/2016", "card_bill_addr": "224 Maurice Blvd",
    "card_bill_city": "Rio Grande", "card_bill_state": "NJ", "card_bill_zip": "08242", "card_bill_phone": "6107616189",
    "card_number": "4111111111111111", "rid": "147", "tray": "4622452/1,+4622476/1",
    "tip": "5.05", "delivery_date": "ASAP", "first_name": "Testy", "last_name": "tester", "addr": "1 Main Street",
    "city": "College Station", "state": "TX", "zip": "77840", "phone": "6107616189"
]*/

/*
User order with saved CC
var params = ["email": "testSam2@example.com", "password": "testpass", "rid": "147", "tray": "4622452/1,+4622476/1",
    "tip": "5.05", "delivery_date": "ASAP", "first_name": "Testy", "last_name": "tester", "addr": "1 Main Street",
    "city": "College Station", "state": "TX", "zip": "77840", "phone": "6107616189", "card_nick": "doge"
]
*/

/*
Create Addr
var params = ["email": "testSam2@example.com", "password": "testpass", "addr": "1 Main Street",
    "city": "College Station", "state": "TX", "zip": "77840", "phone": "6107616189", "nick": "workAddr"
]
*/

/*
User order with saved addr
var params = ["email": "testSam2@example.com", "password": "testpass", "card_name": "Sam Agnew",
    "card_cvc": "123", "card_expiry": "02/2016", "card_bill_addr": "224 Maurice Blvd",
    "card_bill_city": "Rio Grande", "card_bill_state": "NJ", "card_bill_zip": "08242", "card_bill_phone": "6107616189",
    "card_number": "4111111111111111", "rid": "147", "tray": "4622452/1,+4622476/1",
    "tip": "5.05", "delivery_date": "ASAP", "first_name": "Testy", "last_name": "tester", "nick": "workAddr"
]
*/

/*
User order with saved card and saved addr
var params = ["email": "testSam2@example.com", "password": "testpass", "rid": "147", "tray": "4622452/1,+4622476/1",
    "tip": "5.05", "delivery_date": "ASAP", "first_name": "Testy", "last_name": "tester", "nick": "workAddr", "card_nick": "doge"
]
*/

myOrdrin.order_user(params, callback: {(error: NSError?, data: AnyObject?) -> () in
    println("got into callback")
    if(error) {
        println("error: \(error)")
        wait = false
    } else {
        println("results(get): \(data)")
        wait = false
    }
})

waitFor(&wait)
