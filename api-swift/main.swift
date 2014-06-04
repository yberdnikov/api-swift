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

myOrdrin.makeApiRequest("restaurant", endpointPattern: "/dl", parameters: ["10035"])


println("Hey")
//Ordrin.fee("23844", subtotal: "22.00", tip: "5.00", datetime: "ASAP", zip: "10010", city: "New York", addr: "902 Broadway")
