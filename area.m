//
//  area.m
//  房伴
//
//  Created by tao xu on 13-8-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "area.h"

@implementation area
@synthesize ID,Code,AreaName,AreaInitial,TypeName,FatherName;
- (area *)initWithJsonDictionary:(NSDictionary*)dic {
	if (self = [super init]) {
        ID=[[dic getStringValueForKey:@"Id" defaultValue:@""] retain];
        Code=[[dic getStringValueForKey:@"Code" defaultValue:@""] retain];
        AreaName=[[dic getStringValueForKey:@"AreaName" defaultValue:@""] retain];
        AreaInitial=[[dic getStringValueForKey:@"AreaInitial" defaultValue:@""] retain];
        TypeName=[[dic getStringValueForKey:@"TypeName" defaultValue:@""] retain];
        FatherName=[[dic getStringValueForKey:@"FatherName" defaultValue:@""] retain];
    }
	return self;
}

+ (area*)areaWithJsonDictionary:(NSDictionary*)dic
{
	return [[[area alloc] initWithJsonDictionary:dic] autorelease];
}
-(void)dealloc{
    [ID release];
    [Code release];
    [AreaName release];
    [AreaInitial release];
    [TypeName release];
    [FatherName release];
    [super dealloc];
}
@end
