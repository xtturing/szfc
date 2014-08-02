//
//  hint.m
//  房伴
//
//  Created by tao xu on 13-8-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "hint.h"

@implementation hint
@synthesize ID,Code,TypeId,HintName,FatherName;
-(hint*)initWithJsonDictionary:(NSDictionary*)dic{
    if (self = [super init]) {
        ID=[[dic getStringValueForKey:@"Id" defaultValue:@""] retain];
        Code=[[dic getStringValueForKey:@"Code" defaultValue:@""] retain];
        TypeId=[[dic getStringValueForKey:@"TypeId" defaultValue:@""] retain];
        HintName=[[dic getStringValueForKey:@"HintName" defaultValue:@""] retain];
        FatherName=[[dic getStringValueForKey:@"FatherName" defaultValue:@""] retain];
    }
	return self;
}
+(hint*)hintWithJsonDictionary:(NSDictionary*)dic{
    return [[[hint alloc] initWithJsonDictionary:dic] autorelease];
}
-(void)dealloc{
    [ID release];
    [Code release];
    [TypeId release];
    [HintName release];
    [FatherName release];
    [super dealloc];
}
@end
