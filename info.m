//
//  info.m
//  房伴
//
//  Created by tao xu on 13-8-19.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "info.h"

@implementation info
@synthesize Id,Code,InfoType,TypeName,InfoIntr,InfoHdpiPhoto,InfoMdpiPhoto, InfoLdpiPhoto,Address,CommentNum,TransmitNum, PraiseNum, AddTime,AddUser, NickName,UserHdpiPhoto, UserMdpiPhoto, UserLdpiPhoto;
-(info*)initWithJsonDictionary:(NSDictionary*)dic{
    if(self=[super init]){
        Id=[[dic getStringValueForKey:@"Id" defaultValue:@""] retain];
        Code=[[dic getStringValueForKey:@"Code" defaultValue:@""] retain];
        InfoType=[[dic getStringValueForKey:@"InfoType" defaultValue:@""] retain];
        TypeName=[[dic getStringValueForKey:@"TypeName" defaultValue:@""] retain];
        InfoIntr=[[dic getStringValueForKey:@"InfoIntr" defaultValue:@""] retain];
        InfoHdpiPhoto=[[dic getStringValueForKey:@"InfoHdpiPhoto" defaultValue:@""] retain];
        InfoMdpiPhoto=[[dic getStringValueForKey:@"InfoMdpiPhoto" defaultValue:@""] retain];
        InfoLdpiPhoto=[[dic getStringValueForKey:@"InfoLdpiPhoto" defaultValue:@""] retain];
        Address=[[dic getStringValueForKey:@"Address" defaultValue:@""] retain];
        CommentNum=[[dic getStringValueForKey:@"CommentNum" defaultValue:@""] retain];
        TransmitNum=[[dic getStringValueForKey:@"TransmitNum" defaultValue:@""] retain];
        PraiseNum=[[dic getStringValueForKey:@"PraiseNum" defaultValue:@""] retain];
        AddTime=[[dic getStringValueForKey:@"AddTime" defaultValue:@""] retain];
        AddUser=[[dic getStringValueForKey:@"AddUser" defaultValue:@""] retain];
        NickName=[[dic getStringValueForKey:@"NickName" defaultValue:@""] retain];
        UserHdpiPhoto=[[dic getStringValueForKey:@"UserHdpiPhoto" defaultValue:@""] retain];
        UserMdpiPhoto=[[dic getStringValueForKey:@"UserMdpiPhoto" defaultValue:@""] retain];
        UserLdpiPhoto=[[dic getStringValueForKey:@"UserLdpiPhoto" defaultValue:@""] retain];
        
    }
    return  self;
}
+(info*)infoWithJsonDictionary:(NSDictionary*)dic{
    return [[[info alloc] initWithJsonDictionary:dic] autorelease];
}
@end
