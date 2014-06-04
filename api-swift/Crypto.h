//
//  Crypto.h
//  api-swift
//
//  Created by Eric Song on 6/4/14.
//  Copyright (c) 2014 Sam Agnew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>

@interface Crypto : NSObject

- (NSString*) sha256HashFor:(NSString*)input;

@end

