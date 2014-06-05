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
    
    func makeApiRequest( apiGroup : String, endpointPath : String, pathTpl: String, parameters: Dictionary<String, String>, postFields: String[]?, callback : (NSError?, NSDictionary?) -> () ) {
        // set up the host + path
        var urlPath = urls[apiGroup]! + endpointPath
        var postData: Dictionary<String, AnyObject> = [:]
        
        for path in pathTpl.componentsSeparatedByString("/"){
            if path.hasPrefix(":") {
                var param = path.substringFromIndex(1)
                urlPath += "/\(parameters[param]!)"
            } else if(!path.isEmpty){
                urlPath += "/\(path)"
            }
        }
        
        // Initialize postData if post request is being made
        if postFields {
            for field in postFields!{
                postData[field] = parameters[field]
            }
        }
        
        // add authentication (since we're not using headers yet)
        urlPath += "?_auth=1,\(apiKey)"
        // sanity check
        var encodedUrl : NSString = urlPath.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        println(urlPath)
        
        // Agent stuff
        if postFields {
            Agent.post(encodedUrl,
                data: postData,
                done: { (error: NSError?, response: NSHTTPURLResponse?, data: NSData?) -> () in
                    if (error) {
                        callback(error, nil)
                    } else {
                        var results = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                        callback(nil, results)
                    }
                })
        } else {
            Agent.get(encodedUrl,
                done: { (error: NSError?, response: NSHTTPURLResponse?, data: NSData?) -> () in
                    if (error) {
                        callback(error, nil)
                    } else {
                        var results = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                        callback(nil, results)
                    }
                })
        }
    }

    func restaurant_details(rid: String, callback: (NSError?, NSDictionary?) -> ()) {
        //makeApiRequest("restaurant", endpointPath: "/rd", parameters: [rid], postFields: [], callback: callback)
    }
    
    func delivery_list(datetime: String, zip: String, city: String, addr: String, callback: (NSError?, NSDictionary?) -> ()) {
        //makeApiRequest("restaurant", endpointPath: "/dl", parameters: [datetime, zip, city, addr], postFields: [], callback: callback)
    }
    
    func delivery_check(rid: String, datetime: String, zip: String, city: String, addr: String, callback: (NSError?, NSDictionary?) -> ()) {
        //makeApiRequest("restaurant", endpointPath: "/dc", parameters: [rid, datetime, zip, city, addr], postFields: [], callback: callback)
    }
    
    func fee(rid: String, subtotal: String, tip: String, datetime: String, zip: String, city: String, addr: String, callback: (NSError?, NSDictionary?) -> ()) {
        //makeApiRequest("restaurant", endpointPath: "/fee", parameters: [rid, subtotal, tip, datetime, zip, city, addr], postFields: [], callback: callback)
    }
    
    func guest_order(parameters: Dictionary<String, String>, callback: (NSError?, NSDictionary?) -> ()) {
        
        var postFields: String[] = ["tray", "tip", "delivery_date", "first_name", "last_name", "addr", "city",
            "state", "zip", "phone", "em", "password", "card_name", "card_number", "card_cvc", "card_expiry",
            "card_bill_addr", "card_bill_addr2", "card_bill_city", "card_bill_state", "card_bill_zip", "card_bill_phone"
        ]
        
        makeApiRequest("order", endpointPath: "/o", pathTpl: "/:rid", parameters: parameters, postFields: postFields, callback: callback)
    }
}
