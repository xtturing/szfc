//
//  nearby.m
//  房伴
//
//  Created by tao xu on 13-8-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "nearby.h"

@implementation nearby
@synthesize Id,Code,BuildName,LocalRange;
-(nearby*)initWithJsonDictionary:(NSDictionary*)dic{
    if(self = [super init]){
        Id=[[dic getStringValueForKey:@"Id" defaultValue:@""] retain];
        Code=[[dic getStringValueForKey:@"Code" defaultValue:@""] retain];
        BuildName=[[dic getStringValueForKey:@"BuildName" defaultValue:@""] retain];
        LocalRange=[[dic getStringValueForKey:@"LocalRange" defaultValue:@""] retain];
    }
    return  self;
}
+(nearby*)nearbyWithJsonDictionary:(NSDictionary*)dic{
    return [[nearby alloc] initWithJsonDictionary:dic];
}
@end
