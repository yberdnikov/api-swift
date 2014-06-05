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
    
    func makeApiRequest( apiGroup : String, endpointPath : String, parameters: String[] , callback : (NSError?, NSDictionary?) -> () ) {
        // set up the host + path
        var urlPath = urls[apiGroup]! + endpointPath
        for param in parameters{
            urlPath += "/\(param)"
        }
        // add authentication (since we're not using headers yet)
        urlPath += "?_auth=1,\(apiKey)"
        // sanity check
        var encodedUrl : NSString = urlPath.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        println(urlPath)
        // Agent stuff
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

    func restaurant_details(rid: String, callback: (NSError?, NSDictionary?) -> ()) {
        makeApiRequest("restaurant", endpointPath: "/rd", parameters: [rid], callback: callback)
    }

    func restaurant_details(params: Dictionary<String, String>, callback: (NSError?, NSDictionary?) -> ()) {
        var pathTpl = "/rd/:rid"
        var parameters = Dictionary<String, String>()
        var required = ["rid"]
        
        if validateParams(params, required: required){
            makeApiRequest("restaurant", endpointPath: "/rd", parameters: parameters, callback: callback)
        }
    }
    
    
    func delivery_list(datetime: String, zip: String, city: String, addr: String, callback: (NSError?, NSDictionary?) -> ()) {
        makeApiRequest("restaurant", endpointPath: "/dl", parameters: [datetime, zip, city, addr], callback: callback)
    }
    
    func delivery_check(rid: String, datetime: String, zip: String, city: String, addr: String, callback: (NSError?, NSDictionary?) -> ()) {
        makeApiRequest("restaurant", endpointPath: "/dc", parameters: [rid, datetime, zip, city, addr], callback: callback)
    }
    
    func fee(rid: String, subtotal: String, tip: String, datetime: String, zip: String, city: String, addr: String, callback: (NSError?, NSDictionary?) -> ()) {
        makeApiRequest("restaurant", endpointPath: "/fee", parameters: [rid, subtotal, tip, datetime, zip, city, addr], callback: callback)
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
}
