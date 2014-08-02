//
//  nearby.h
//  房伴
//
//  Created by tao xu on 13-8-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionaryAdditions.h"
@interface nearby : NSObject{
    NSString* Id;
    NSString* Code;
    NSString* BuildName;
    NSString* LocalRange;
}
@property (nonatomic, retain) NSString* Id;
@property (nonatomic, retain) NSString* Code;
@property (nonatomic, retain) NSString* BuildName;
@property (nonatomic, retain) NSString* LocalRange;
-(nearby*)initWithJsonDictionary:(NSDictionary*)dic;
+(nearby*)nearbyWithJsonDictionary:(NSDictionary*)dic;
@end
