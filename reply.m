//
//  reply.m
//  房伴
//
//  Created by tao xu on 13-8-19.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "reply.h"

@implementation reply
@synthesize Id,Code,InfoCode,IsReply, AtUser,AtNick,ReplyIntr,ReplyHdpiPhoto,ReplyMdpiPhoto,ReplyLdpiPhoto,Address,ReplyUser,ReplyNick,AddTime,UserHdpiPhoto,UserMdpiPhoto,UserLdpiPhoto;
-(reply*)initWithJsonDictionary:(NSDictionary*)dic{
    if(self=[super init]){
        Id=[[dic getStringValueForKey:@"Id" defaultValue:@""] retain];
        Code=[[dic getStringValueForKey:@"Code" defaultValue:@""] retain];
        InfoCode=[[dic getStringValueForKey:@"InfoCode" defaultValue:@""] retain];
        IsReply=[[dic getStringValueForKey:@"IsReply" defaultValue:@""] retain];
        AtUser=[[dic getStringValueForKey:@"AtUser" defaultValue:@""] retain];
        AtNick=[[dic getStringValueForKey:@"AtNick" defaultValue:@""] retain];
        ReplyIntr=[[dic getStringValueForKey:@"ReplyIntr" defaultValue:@""] retain];
        ReplyHdpiPhoto=[[dic getStringValueForKey:@"ReplyHdpiPhoto" defaultValue:@""] retain];
        ReplyMdpiPhoto=[[dic getStringValueForKey:@"ReplyMdpiPhoto" defaultValue:@""] retain];
        ReplyLdpiPhoto=[[dic getStringValueForKey:@"ReplyLdpiPhoto" defaultValue:@""] retain];
        Address=[[dic getStringValueForKey:@"Address" defaultValue:@""] retain];
        ReplyUser=[[dic getStringValueForKey:@"ReplyUser" defaultValue:@""] retain];
        ReplyNick=[[dic getStringValueForKey:@"ReplyNick" defaultValue:@""] retain];
        AddTime=[[dic getStringValueForKey:@"AddTime" defaultValue:@""] retain];
        UserHdpiPhoto=[[dic getStringValueForKey:@"UserHdpiPhoto" defaultValue:@""] retain];
        UserMdpiPhoto=[[dic getStringValueForKey:@"UserMdpiPhoto" defaultValue:@""] retain];
        UserLdpiPhoto=[[dic getStringValueForKey:@"UserLdpiPhoto" defaultValue:@""] retain];
        
    }
    return self;
}
+(reply*)replyWithJsonDictionary:(NSDictionary*)dic{
    return [[[reply alloc] initWithJsonDictionary:dic] autorelease];
}
@end
