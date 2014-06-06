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
    
    func makeApiRequest( apiGroup : String, endpointPath : String, pathTpl: String, userAuth: Bool = false, parameters: Dictionary<String, String>, postFields: String[]?, callback : (NSError?, AnyObject?) -> () ) {

        // set up the host + path
        var uri = endpointPath
        var postData: Dictionary<String, AnyObject> = [:]
        
        for path in pathTpl.componentsSeparatedByString("/"){
            if path.hasPrefix(":") {
                var param = path.substringFromIndex(1)
                uri += "/\(parameters[param]!)"
            } else if(!path.isEmpty){
                uri += "/\(path)"
            }
        }
        
        // Initialize postData if post request is being made
        if postFields {
            for field in postFields!{
                postData[field] = parameters[field]
            }
        }
        
        // add authentication (since we're not using headers yet)
        if userAuth {
            var email = parameters["email"]
            var hashCode = hashUser(parameters["password"]!, email: email!, uri: uri)
            uri += "?_auth=1,\(apiKey)&_uauth=1,\(email),\(hashCode)"
        } else {
            uri += "?_auth=1,\(apiKey)"
        }
        
        // sanity check
        var encodedUrl : NSString = "\(urls[apiGroup]!)\(uri)".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        println(encodedUrl)
        
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
    
    func restaurant_details(params: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        var endpointPath = "/rd"
        var pathTpl = "/:rid"
        var required = ["rid"]
        
        if validateParams(params, required: required){
            makeApiRequest("restaurant", endpointPath: endpointPath, pathTpl: pathTpl, parameters: params, postFields: nil, callback: callback)
        }
    }
    
    func delivery_list(params: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        println("list called")
        var endpointPath = "/dl"
        var pathTpl = "/:datetime/:zip/:city/:addr"
        var required = ["datetime", "zip", "city", "addr"]
        
        if validateParams(params, required: required){
            makeApiRequest("restaurant", endpointPath: endpointPath, pathTpl: pathTpl, parameters: params, postFields: nil, callback: callback)
        }
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
    
    func fee(params: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        println("fee called")
        var endpointPath = "/fee"
        var pathTpl = "/:rid/:subtotal/:tip/:datetime/:zip/:city/:addr"
        var required = ["rid", "subtotal", "tip", "datetime", "zip", "city", "addr"]
        
        if validateParams(params, required: required){
            makeApiRequest("restaurant", endpointPath: endpointPath, pathTpl: pathTpl, parameters: params, postFields: nil, callback: callback)
        }
    }

    
    func order_guest(parameters: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        
        var postFields: String[] = ["tray", "tip", "delivery_date", "first_name", "last_name", "addr", "city",
            "state", "zip", "phone", "em", "password", "card_name", "card_number", "card_cvc", "card_expiry",
            "card_bill_addr", "card_bill_addr2", "card_bill_city", "card_bill_state", "card_bill_zip", "card_bill_phone"
        ]
        
        makeApiRequest("order", endpointPath: "/o", pathTpl: "/:rid", parameters: parameters, postFields: postFields, callback: callback)
    }
    
    func get_account_info(parameters: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        makeApiRequest("user", endpointPath: "/u", pathTpl: "/:email", userAuth: true, parameters: parameters, postFields: nil, callback: callback)
    }
    
    func get_all_saved_addrs(parameters: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        makeApiRequest("user", endpointPath: "/u", pathTpl: "/:email/addrs", userAuth: true, parameters: parameters, postFields: nil, callback: callback)
    }
    
    func get_saved_addr(parameters: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        makeApiRequest("user", endpointPath: "/u", pathTpl: "/:email/addrs/:nick", userAuth: true, parameters: parameters, postFields: nil, callback: callback)
    }
    
    func get_all_saved_ccs(parameters: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        makeApiRequest("user", endpointPath: "/u", pathTpl: "/:email/ccs/", userAuth: true, parameters: parameters, postFields: nil, callback: callback)
    }
    
    func get_saved_cc(parameters: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        makeApiRequest("user", endpointPath: "/u", pathTpl: "/:email/ccs/:nick", userAuth: true, parameters: parameters, postFields: nil, callback: callback)
    }
    
    func get_order_history(parameters: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        makeApiRequest("user", endpointPath: "/u", pathTpl: "/:email/orders/", userAuth: true, parameters: parameters, postFields: nil, callback: callback)
    }
    
    func get_order(parameters: Dictionary<String, String>, callback: (NSError?, AnyObject?) -> ()) {
        makeApiRequest("user", endpointPath: "/u", pathTpl: "/:email/orders/:oid", userAuth: true, parameters: parameters, postFields: nil, callback: callback)
    }
    
    // Need to do all non get requests(put and delete) to finish the User API.
    
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
