//
//  message.m
//  房伴
//
//  Created by tao xu on 13-8-26.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "message.h"

@implementation message
@synthesize  Id,Code,MsgType,TypeName, BuildCode,BuildName, MsgIntr,MsgHdpiPhoto,MsgMdpiPhoto, MsgLdpiPhoto, Address, CommentNum, TransmitNum, PraiseNum, AddTime, AddUser, NickName, UserHdpiPhoto, UserMdpiPhoto, UserLdpiPhoto;
-(message*)initWithJsonDictionary:(NSDictionary*)dic{
    if(self=[super init]){
        Id=[[dic getStringValueForKey:@"Id" defaultValue:@""] retain];
        Code=[[dic getStringValueForKey:@"Code" defaultValue:@""] retain];
        MsgType=[[dic getStringValueForKey:@"MsgType" defaultValue:@""] retain];
        TypeName=[[dic getStringValueForKey:@"TypeName" defaultValue:@""] retain];
        BuildCode=[[dic getStringValueForKey:@"BuildCode" defaultValue:@""] retain];
        
        BuildName=[[dic getStringValueForKey:@"BuildName" defaultValue:@""] retain];
        MsgIntr=[[dic getStringValueForKey:@"MsgIntr" defaultValue:@""] retain];
        MsgHdpiPhoto=[[dic getStringValueForKey:@"MsgHdpiPhoto" defaultValue:@""] retain];
        MsgMdpiPhoto=[[dic getStringValueForKey:@"MsgMdpiPhoto" defaultValue:@""] retain];
        MsgLdpiPhoto=[[dic getStringValueForKey:@"MsgLdpiPhoto" defaultValue:@""] retain];
        
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
    return self;
}
+(message*)messageWithJsonDictionary:(NSDictionary*)dic{
    return [[message alloc] initWithJsonDictionary:dic];
}
@end
