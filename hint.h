//
//  hint.h
//  房伴
//
//  Created by tao xu on 13-8-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionaryAdditions.h"
@interface hint : NSObject{
    NSString* ID;
    NSString* Code;
    NSString* TypeId;
    NSString* HintName;
    NSString* FatherName;
}

@property (nonatomic, retain) NSString* ID;
@property (nonatomic, retain) NSString* Code;
@property (nonatomic, retain) NSString* TypeId;
@property (nonatomic, retain) NSString* HintName;
@property (nonatomic, retain) NSString* FatherName;
-(hint*)initWithJsonDictionary:(NSDictionary*)dic;
+(hint*)hintWithJsonDictionary:(NSDictionary*)dic;
@end
