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
    
    func makeApiRequest( apiGroup : String, endpointPath : String, pathTpl: String, parameters: Dictionary<String, String>, postFields: String[]?, callback : (NSError?, AnyObject?) -> () ) {
        // set up the host + path
        var urlPath = urls[apiGroup]! + endpointPath
        var postData: Dictionary<String, AnyObject> = [:]
        
        for path in pathTpl.componentsSeparatedByString("/"){
            if path.hasPrefix(":") {
                var param = path.substringFromIndex(1)
                urlPath += "/\(parameters[param])"
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
                done: { (error: NSError?, response: NSHTTPURLResponse?, data: NSMutableData?) -> () in
                    if (error) {
                        callback(error, nil)
                    } else {
                        var results = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                        callback(nil, results)
                    }
                })
        } else {
            Agent.get(encodedUrl,
                done: { (error: NSError?, response: NSHTTPURLResponse?, data: NSMutableData?) -> () in
                    if (error) {
                        callback(error, nil)
                    } else {
                        var results : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
                        println(results)
                        callback(nil, results)
                    }
                })
        }
    }
/*
    func restaurant_details(rid: String, callback: (NSError?, NSDictionary?) -> ()) {
        //makeApiRequest("restaurant", endpointPath: "/rd", parameters: [rid], postFields: [], callback: callback)
    }
*/
    func restaurant_details(params: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        var endpointPath = "/rd"
        var pathTpl = "/:rid"
        var required = ["rid"]
        
        if validateParams(params, required: required){
            makeApiRequest("restaurant", endpointPath: endpointPath, pathTpl: pathTpl, parameters: params, postFields: nil, callback: callback)
        }
    }
  
    /*
    func delivery_list(datetime: String, zip: String, city: String, addr: String, callback: (NSError?, NSDictionary?) -> ()) {
        //makeApiRequest("restaurant", endpointPath: "/dl", parameters: [datetime, zip, city, addr], postFields: [], callback: callback)
    }
    */
    
    func delivery_list(params: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        println("list called")
        var endpointPath = "/dl"
        var pathTpl = "/:datetime/:zip/:city/:addr"
        var required = ["datetime", "zip", "city", "addr"]
        
        if validateParams(params, required: required){
            makeApiRequest("restaurant", endpointPath: endpointPath, pathTpl: pathTpl, parameters: params, postFields: nil, callback: callback)
        }
    }
    
    
    func delivery_check(rid: String, datetime: String, zip: String, city: String, addr: String, callback: (NSError?, NSDictionary?) -> ()) {
        //makeApiRequest("restaurant", endpointPath: "/dc", parameters: [rid, datetime, zip, city, addr], postFields: [], callback: callback)
    }
    
    func delivery_check(params: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        println("check called")
        var endpointPath = "/dc"
        var pathTpl = "/:rid/:datetime/:zip/:city/:addr"
        var required = ["rid", "datetime", "zip", "city", "addr"]
        
        if validateParams(params, required: required){
            makeApiRequest("restaurant", endpointPath: endpointPath, pathTpl: pathTpl, parameters: params, postFields: nil, callback: callback)
        }
    }

    func fee(rid: String, subtotal: String, tip: String, datetime: String, zip: String, city: String, addr: String, callback: (NSError?, AnyObject?) -> ()) {
        //makeApiRequest("restaurant", endpointPath: "/fee", parameters: [rid, subtotal, tip, datetime, zip, city, addr], postFields: [], callback: callback)
    }
    
    func fee(params: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        println("fee called")
        var endpointPath = "/fee"
        var pathTpl = "/:rid/:subtotal/:tip/:datetime/:zip/:city/:addr"
        var required = ["rid", "subtotal", "tip", "datetime", "zip", "city", "addr"]
        
        if validateParams(params, required: required){
            makeApiRequest("restaurant", endpointPath: endpointPath, pathTpl: pathTpl, parameters: params, postFields: nil, callback: callback)
        }
    }

    
    func guest_order(parameters: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        
        var postFields: String[] = ["tray", "tip", "delivery_date", "first_name", "last_name", "addr", "city",
            "state", "zip", "phone", "em", "password", "card_name", "card_number", "card_cvc", "card_expiry",
            "card_bill_addr", "card_bill_addr2", "card_bill_city", "card_bill_state", "card_bill_zip", "card_bill_phone"
        ]
        
        makeApiRequest("order", endpointPath: "/o", pathTpl: "/:rid", parameters: parameters, postFields: postFields, callback: callback)
    }
    

    func validateParams(params: Dictionary<String, String>, required: String[]) -> Bool{
        for key in required {
            if !params[key] {
                println("ERROR: required field '\(key)' not found")
                return false
            }
        }
        
        return true
    }
    
    func hashUser(password: String, email: String, uri: String) -> NSString{
        var crypto: Crypto = Crypto()
        var pass_hash = crypto.sha256HashFor(password)
        
        return crypto.sha256HashFor(pass_hash + email + uri)
    }
}
