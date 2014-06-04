//
//  main.swift
//  api-swift
//
//  Created by Sam Agnew on 6/3/14.
//  Copyright (c) 2014 Sam Agnew. All rights reserved.
//

import Foundation

//Ordrin.restaurant_details("147")

var myOrdrin = Ordrin(apiKey: "orqweJcnpgD4mxVRPKRTGAVbTGab33DlqqEDllP4Bck", environment: "test")

myOrdrin.makeApiRequest("restaurant", endpointPattern: "/dl", parameters: ["10035"])


println("Hey")