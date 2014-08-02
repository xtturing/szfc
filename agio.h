//
//  agio.h
//  房伴
//
//  Created by tao xu on 13-8-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionaryAdditions.h"
@interface agio : NSObject{
    NSString* ID;
    NSString* Code;
    NSString* BuildName;
    NSString* AreaName;
    NSString* PriceAverage;
    NSString* DecName;
    NSString* LocalRange;
    NSString* AgioName;
    NSString* LdpiPhoto;
    NSString* MdpiPhoto;
    NSString* HdpiPhoto;
}
@property (nonatomic, retain) NSString* ID;
@property (nonatomic, retain) NSString* Code;
@property (nonatomic, retain) NSString* BuildName;
@property (nonatomic, retain) NSString* AreaName;
@property (nonatomic, retain) NSString* PriceAverage;
@property (nonatomic, retain) NSString* DecName;
@property (nonatomic, retain) NSString* LocalRange;
@property (nonatomic, retain) NSString* AgioName;
@property (nonatomic, retain) NSString* LdpiPhoto;
@property (nonatomic, retain) NSString* MdpiPhoto;
@property (nonatomic, retain) NSString* HdpiPhoto;
-(agio*)initWithJsonDictionary:(NSDictionary*)dic;
+(agio*)agioWithJsonDictionary:(NSDictionary*)dic;
@end
