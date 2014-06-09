# Ordr.in Swift Library

A Swift library for the ordr.in API.

## Table of Contents

 - [Installation](#installation)
 - [Usage](#usage)
   - [Initialization](#initialization)
   
   - [Order Endpoints](#order-endpoints-api-reference)
     - [Guest Order](#guest-order-api-reference) (`order_guest`)
     - [User Order](#user-order-api-reference) (`order_user`)
     
   - [Restaurant Endpoints](#restaurant-endpoints-api-reference)
     - [Delivery Check](#delivery-check-api-reference) (`delivery_check`)
     - [Delivery List](#delivery-list-api-reference) (`delivery_list`)
     - [Fee](#fee-api-reference) (`fee`)
     - [Restaurant Details](#restaurant-details-api-reference) (`restaurant_details`)
     
   - [User Endpoints](#user-endpoints-api-reference)
     - [Change Password](#change-password-api-reference) (`change_password`)
     - [Create Account](#create-account-api-reference) (`create_account`)
     - [Create Address](#create-address-api-reference) (`create_addr`)
     - [Create Credit Card](#create-credit-card-api-reference) (`create_cc`)
     - [Remove address](#remove-address-api-reference) (`delete_addr`)
     - [Remove Credit Card](#remove-credit-card-api-reference) (`delete_cc`)
     - [Get Account Information](#get-account-information-api-reference) (`get_account_info`)
     - [Get All Saved Addresses](#get-all-saved-addresses-api-reference) (`get_all_saved_addrs`)
     - [Get all saved credit cards](#get-all-saved-credit-cards-api-reference) (`get_all_saved_ccs`)
     - [Get an Order](#get-an-order-api-reference) (`get_order`)
     - [Get Order History](#get-order-history-api-reference) (`get_order_history`)
     - [Get a single saved address](#get-a-single-saved-address-api-reference) (`get_saved_addr`)
     - [Get a single saved credit card](#get-a-single-saved-credit-card-api-reference) (`get_saved_cc`)
     

## Installation
1. Create a new group in your project directory labeled "Ordrin"
2. Drag and drop all files in ```api-swift/``` into the group created above
3. __Check off all targets in "Add to targets"__
4. Click "Yes" when prompted to created bridging header files
5. Add the line ```#import "Crypto.h"``` into all ```*-Bridging-Header.h``` files that should have been generated for you
6. Done!
7. If you want to test the API, add this function into your unit test file and run "Product -> Test"
```
    //If you're running the code from a main function instead of a unit test, just add a line to actually execute the function
    func testOrdrin() {
        var myOrdrin = Ordrin(apiKey: "orqweJcnpgD4mxVRPKRTGAVbTGab33DlqqEDllP4Bck", environment: "test")
        
        var myDict = Dictionary<String, String>()
        myDict["rid"] = "147"
        
        var wait: Bool = true
        
        myOrdrin.restaurant_details(myDict, callback: {(error: NSError?, data: AnyObject?) -> () in
            println("success")
            println(data)
            wait = false
            })
        
        waitFor(&wait)
        
    }
    
    func waitFor (inout wait: Bool){
        while(wait){
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1))
        }
    }
```

## Usage


### Callbacks

Every function call you make to the ordrin api includes a
callback. This callback will be called when the API has finished processing the
request. This callback takes two arguments, `error` and `data`. If the request
fails, then `error` will be an `Error` object; otherwise it will be nil. The
`data` argument contains the Swift Dictionary returned by the API.

### Initialization

```Swift
var ordrin = Ordrin(apiKey: "YOUR-API-KEY", environment: "test")
```

In the initializer, the second argument sets the servers that API requests will
be sent to, and must be set to either `production` or `test`

(defaults to "test").


### Order Endpoints ([API Reference](http://hackfood.ordr.in/docs/order))

#### Guest Order ([API Reference](http://hackfood.ordr.in/docs/order#order_guest))

    ordrin.order_guest(args, callback)

##### Arguments
- `args.rid` : Ordr.in's unique restaurant identifier for the restaurant. (A number)
- `args.em` : The customer's email address
- `args.tray` : Represents a tray of menu items in the format '[menu item id]/[qty],[option id],...,[option id]'
- `args.tip` : Tip amount in dollars and cents
- `args.first_name` : The customer's first name
- `args.last_name` : The customer's last name
- `args.phone` : The customer's phone number
- `args.zip` : The zip code part of the address (5 digits)
- `args.addr` : The street address
- `args.addr2` : The second part of the street address, if needed
- `args.city` : The city part of the address
- `args.state` : The state part of the address (Two letters)
- `args.card_name` : Full name as it appears on the credit card
- `args.card_number` : Credit card number (16 digits)
- `args.card_cvc` : 3 or 4 digit security code (3 or 4 digits)
- `args.card_expiry` : The credit card expiration date. (mm/yyyy)
- `args.card_bill_addr` : The credit card's billing street address
- `args.card_bill_addr2` : The second part of the credit card's biling street address.
- `args.card_bill_city` : The credit card's billing city
- `args.card_bill_state` : The credit card's billing state (2 letters)
- `args.card_bill_zip` : The credit card's billing zip code (5 digits)
- `args.card_bill_phone` : The credit card's billing phone number


###### Either
- `args.delivery_date` : Delivery date (mm-dd)
- `args.delivery_time` : Delivery time (HH:MM)

###### Or
- `args.delivery_date` : Delivery date (ASAP)



#### User Order ([API Reference](http://hackfood.ordr.in/docs/order#order_user))

    ordrin.order_user(args, callback)

##### Arguments
- `args.rid` : Ordr.in's unique restaurant identifier for the restaurant. (A number)
- `args.tray` : Represents a tray of menu items in the format '[menu item id]/[qty],[option id],...,[option id]'
- `args.tip` : Tip amount in dollars and cents
- `args.first_name` : The customer's first name
- `args.last_name` : The customer's last name
- `args.email` : The user's email address
- `args.current_password` : The user's current password

###### Either
- `args.phone` : The customer's phone number
- `args.zip` : The zip code part of the address (5 digits)
- `args.addr` : The street address
- `args.addr2` : The second part of the street address, if needed
- `args.city` : The city part of the address
- `args.state` : The state part of the address (Two letters)

###### Or
- `args.nick` : The delivery location nickname. (From the user's addresses)



###### Either
- `args.card_name` : Full name as it appears on the credit card
- `args.card_number` : Credit card number (16 digits)
- `args.card_cvc` : 3 or 4 digit security code (3 or 4 digits)
- `args.card_expiry` : The credit card expiration date. (mm/yyyy)
- `args.card_bill_addr` : The credit card's billing street address
- `args.card_bill_addr2` : The second part of the credit card's biling street address.
- `args.card_bill_city` : The credit card's billing city
- `args.card_bill_state` : The credit card's billing state (2 letters)
- `args.card_bill_zip` : The credit card's billing zip code (5 digits)
- `args.card_bill_phone` : The credit card's billing phone number

###### Or
- `args.card_nick` : The credit card nickname. (From the user's credit cards)



###### Either
- `args.delivery_date` : Delivery date (mm-dd)
- `args.delivery_time` : Delivery time (HH:MM)

###### Or
- `args.delivery_date` : Delivery date (ASAP)




### Restaurant Endpoints ([API Reference](http://hackfood.ordr.in/docs/restaurant))

#### Delivery Check ([API Reference](http://hackfood.ordr.in/docs/restaurant#delivery_check))

    ordrin.delivery_check(args, callback)

##### Arguments
- `args.datetime` : Delivery date and time (ASAP or mm-dd+HH:MM)
- `args.rid` : Ordr.in's unique restaurant identifier for the restaurant. (A number)
- `args.addr` : Delivery location street address
- `args.city` : Delivery location city
- `args.zip` : The zip code part of the address (5 digits)


#### Delivery List ([API Reference](http://hackfood.ordr.in/docs/restaurant#delivery_list))

    ordrin.delivery_list(args, callback)

##### Arguments
- `args.datetime` : Delivery date and time (ASAP or mm-dd+HH:MM)
- `args.addr` : Delivery location street address
- `args.city` : Delivery location city
- `args.zip` : The zip code part of the address (5 digits)


#### Fee ([API Reference](http://hackfood.ordr.in/docs/restaurant#fee))

    ordrin.fee(args, callback)

##### Arguments
- `args.datetime` : Delivery date and time (ASAP or mm-dd+HH:MM)
- `args.rid` : Ordr.in's unique restaurant identifier for the restaurant. (A number)
- `args.subtotal` : The cost of all items in the tray in dollars and cents.
- `args.tip` : The tip in dollars and cents.
- `args.addr` : Delivery location street address
- `args.city` : Delivery location city
- `args.zip` : The zip code part of the address (5 digits)


#### Restaurant Details ([API Reference](http://hackfood.ordr.in/docs/restaurant#restaurant_details))

    ordrin.restaurant_details(args, callback)

##### Arguments
- `args.rid` : Ordr.in's unique restaurant identifier for the restaurant. (A number)



### User Endpoints ([API Reference](http://hackfood.ordr.in/docs/user))

#### Change Password ([API Reference](http://hackfood.ordr.in/docs/user#change_password))

    ordrin.change_password(args, callback)

##### Arguments
- `args.email` : The user's email address
- `args.password` : The user's new password (SHA256 hex encoded)
- `args.current_password` : The user's current password

#### Create Account ([API Reference](http://hackfood.ordr.in/docs/user#create_account))

    ordrin.create_account(args, callback)

##### Arguments
- `args.email` : The user's email address
- `args.pw` : The user's password
- `args.first_name` : The user's first name
- `args.last_name` : The user's last name


#### Create Address ([API Reference](http://hackfood.ordr.in/docs/user#create_addr))

    ordrin.create_addr(args, callback)

##### Arguments
- `args.email` : The user's email address
- `args.nick` : The nickname of this address
- `args.phone` : The customer's phone number
- `args.zip` : The zip code part of the address (5 digits)
- `args.addr` : The street address
- `args.addr2` : The second part of the street address, if needed
- `args.city` : The city part of the address
- `args.state` : The state part of the address (Two letters)
- `args.current_password` : The user's current password

#### Create Credit Card ([API Reference](http://hackfood.ordr.in/docs/user#create_cc))

    ordrin.create_cc(args, callback)

##### Arguments
- `args.email` : The user's email address
- `args.nick` : The nickname of this address
- `args.card_number` : Credit card number (16 digits)
- `args.card_cvc` : 3 or 4 digit security code (3 or 4 digits)
- `args.card_expiry` : The credit card expiration date. (Two digits/Four digits)
- `args.bill_addr` : The credit card's billing street address
- `args.bill_addr2` : The second part of the credit card's biling street address.
- `args.bill_city` : The credit card's billing city
- `args.bill_state` : The credit card's billing state (2 letters)
- `args.bill_zip` : The credit card's billing zip code (5 digits)
- `args.bill_phone` : The credit card's billing phone number
- `args.current_password` : The user's current password

#### Remove address ([API Reference](http://hackfood.ordr.in/docs/user#delete_addr))

    ordrin.delete_addr(args, callback)

##### Arguments
- `args.email` : The user's email address
- `args.nick` : The nickname of this address
- `args.current_password` : The user's current password

#### Remove Credit Card ([API Reference](http://hackfood.ordr.in/docs/user#delete_cc))

    ordrin.delete_cc(args, callback)

##### Arguments
- `args.email` : The user's email address
- `args.nick` : The nickname of this address
- `args.current_password` : The user's current password

#### Get Account Information ([API Reference](http://hackfood.ordr.in/docs/user#get_account_info))

    ordrin.get_account_info(args, callback)

##### Arguments
- `args.email` : The user's email address
- `args.current_password` : The user's current password

#### Get All Saved Addresses ([API Reference](http://hackfood.ordr.in/docs/user#get_all_saved_addrs))

    ordrin.get_all_saved_addrs(args, callback)

##### Arguments
- `args.email` : The user's email address
- `args.current_password` : The user's current password

#### Get all saved credit cards ([API Reference](http://hackfood.ordr.in/docs/user#get_all_saved_ccs))

    ordrin.get_all_saved_ccs(args, callback)

##### Arguments
- `args.email` : The user's email address
- `args.current_password` : The user's current password

#### Get an Order ([API Reference](http://hackfood.ordr.in/docs/user#get_order))

    ordrin.get_order(args, callback)

##### Arguments
- `args.email` : The user's email address
- `args.oid` : Ordr.in's unique order id number. (A number)
- `args.current_password` : The user's current password

#### Get Order History ([API Reference](http://hackfood.ordr.in/docs/user#get_order_history))

    ordrin.get_order_history(args, callback)

##### Arguments
- `args.email` : The user's email address
- `args.current_password` : The user's current password

#### Get a single saved address ([API Reference](http://hackfood.ordr.in/docs/user#get_saved_addr))

    ordrin.get_saved_addr(args, callback)

##### Arguments
- `args.email` : The user's email address
- `args.nick` : The nickname of this address
- `args.current_password` : The user's current password

#### Get a single saved credit card ([API Reference](http://hackfood.ordr.in/docs/user#get_saved_cc))

    ordrin.get_saved_cc(args, callback)

##### Arguments
- `args.email` : The user's email address
- `args.nick` : The nickname of this address
- `args.current_password` : The user's current password


