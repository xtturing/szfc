//
//  huType.m
//  房伴
//
//  Created by tao xu on 13-8-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "huType.h"

@implementation huType
@synthesize HuTypeId,HuTypeName;
-(huType*)initWithJsonDictionary:(NSDictionary*)dic{
    if (self = [super init]) {
        HuTypeId=[[dic getStringValueForKey:@"HuTypeId" defaultValue:@""] retain];
        HuTypeName=[[dic getStringValueForKey:@"HuTypeName" defaultValue:@""] retain];
    }
	return self;
}
+(huType*)huTypeWithJsonDictionary:(NSDictionary*)dic{
    return [[[huType alloc] initWithJsonDictionary:dic] autorelease];
}
-(void)dealloc{
    [HuTypeId release];
    [HuTypeName release];
    [super dealloc];
}
@end
