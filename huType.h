//
//  huType.h
//  房伴
//
//  Created by tao xu on 13-8-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionaryAdditions.h"
@interface huType : NSObject{
    NSString* HuTypeId;
     NSString* HuTypeName;
}
@property (nonatomic, retain)  NSString* HuTypeId;
@property (nonatomic, retain) NSString* HuTypeName;
-(huType*)initWithJsonDictionary:(NSDictionary*)dic;
+(huType*)huTypeWithJsonDictionary:(NSDictionary*)dic;
@end
