//
//  agio.m
//  房伴
//
//  Created by tao xu on 13-8-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "agio.h"

@implementation agio
@synthesize ID,Code,BuildName,AreaName,PriceAverage,DecName,LocalRange,AgioName,LdpiPhoto,MdpiPhoto,HdpiPhoto;
-(agio*)initWithJsonDictionary:(NSDictionary*)dic{
    if (self = [super init]) {
        ID=[[dic getStringValueForKey:@"Id" defaultValue:@""] retain];
        Code=[[dic getStringValueForKey:@"Code" defaultValue:@""] retain];
        BuildName=[[dic getStringValueForKey:@"BuildName" defaultValue:@""] retain];
        AreaName=[[dic getStringValueForKey:@"AreaName" defaultValue:@""] retain];
        PriceAverage=[[dic getStringValueForKey:@"PriceAverage" defaultValue:@""] retain];
        DecName=[[dic getStringValueForKey:@"DecName" defaultValue:@""] retain];
        LocalRange=[[dic getStringValueForKey:@"LocalRange" defaultValue:@""] retain];
        AgioName=[[dic getStringValueForKey:@"AgioName" defaultValue:@""] retain];
        LdpiPhoto=[[dic getStringValueForKey:@"LdpiPhoto" defaultValue:@""] retain];
        MdpiPhoto=[[dic getStringValueForKey:@"MdpiPhoto" defaultValue:@""] retain];
        HdpiPhoto=[[dic getStringValueForKey:@"HdpiPhoto" defaultValue:@""] retain];
    }
	return self;
}
+(agio*)agioWithJsonDictionary:(NSDictionary*)dic{
    return [[[agio alloc] initWithJsonDictionary:dic] autorelease];
}
-(void)dealloc{
    [ID release];
    [Code release];
    [BuildName release];
    [AreaName release];
    [PriceAverage release];
    [DecName release];
    [LocalRange release];
    [AgioName release];
    [LdpiPhoto release];
    [MdpiPhoto release];
    [HdpiPhoto release];
    [super dealloc];
}
@end
