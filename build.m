//
//  build.m
//  房伴
//
//  Created by tao xu on 13-8-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "build.h"

@implementation build
@synthesize ID,Code,BuildName,AreaName,PriceAverage,AgioType,AgioName,MinPay,LdpiPhoto,MdpiPhoto,HdpiPhoto,MaxRepay; 
-(build*)initWithJsonDictionary:(NSDictionary*)dic{
    if (self = [super init]) {
        ID=[[dic getStringValueForKey:@"Id" defaultValue:@""] retain];
        Code=[[dic getStringValueForKey:@"Code" defaultValue:@""] retain];
        BuildName=[[dic getStringValueForKey:@"BuildName" defaultValue:@""] retain];
        AreaName=[[dic getStringValueForKey:@"AreaName" defaultValue:@""] retain];
        PriceAverage=[[dic getStringValueForKey:@"PriceAverage" defaultValue:@""] retain];
        AgioType=[[dic getStringValueForKey:@"AgioType" defaultValue:@""] retain];
        AgioName=[[dic getStringValueForKey:@"AgioName" defaultValue:@""] retain];
        MinPay=[[dic getStringValueForKey:@"MinPay" defaultValue:@""] retain];
        MaxRepay=[[dic getStringValueForKey:@"MaxRepay" defaultValue:@""] retain];
        LdpiPhoto=[[dic getStringValueForKey:@"LdpiPhoto" defaultValue:@""] retain];
        MdpiPhoto=[[dic getStringValueForKey:@"MdpiPhoto" defaultValue:@""] retain];
        HdpiPhoto=[[dic getStringValueForKey:@"HdpiPhoto" defaultValue:@""] retain];
    }
	return self;
}
+(build*)buildWithJsonDictionary:(NSDictionary*)dic{
    return [[[build alloc] initWithJsonDictionary:dic] autorelease];
}
-(void)dealloc{
    [ID release];
    [Code release];
    [BuildName release];
    [AreaName release];
    [PriceAverage release];
    [AgioType release];
    [MinPay release];
    [MaxRepay release];
    [AgioName release];
    [LdpiPhoto release];
    [MdpiPhoto release];
    [HdpiPhoto release];
    [super dealloc];
}

@end
