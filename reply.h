//
//  reply.h
//  房伴
//
//  Created by tao xu on 13-8-19.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionaryAdditions.h"
@interface reply : NSObject{
    NSString* Id;
    NSString* Code;
    NSString* InfoCode;
    NSString* IsReply;
    NSString* AtUser;
    
    NSString* AtNick;
    NSString* ReplyIntr;
    NSString* ReplyHdpiPhoto;
    NSString* ReplyMdpiPhoto;
    NSString* ReplyLdpiPhoto;
    
    NSString* Address;
    NSString* ReplyUser;
    NSString* ReplyNick;
    NSString* AddTime;
    NSString* UserHdpiPhoto;
    
    NSString* UserMdpiPhoto;
    NSString* UserLdpiPhoto;
}
@property (nonatomic, retain) NSString* Id;
@property (nonatomic, retain) NSString* Code;
@property (nonatomic, retain) NSString* InfoCode;
@property (nonatomic, retain) NSString* IsReply;
@property (nonatomic, retain) NSString* AtUser;

@property (nonatomic, retain) NSString* AtNick;
@property (nonatomic, retain) NSString* ReplyIntr;
@property (nonatomic, retain) NSString* ReplyHdpiPhoto;
@property (nonatomic, retain) NSString* ReplyMdpiPhoto;
@property (nonatomic, retain) NSString* ReplyLdpiPhoto;

@property (nonatomic, retain) NSString* Address;
@property (nonatomic, retain) NSString* ReplyUser;
@property (nonatomic, retain) NSString* ReplyNick;
@property (nonatomic, retain) NSString* AddTime;
@property (nonatomic, retain) NSString* UserHdpiPhoto;

@property (nonatomic, retain) NSString* UserMdpiPhoto;
@property (nonatomic, retain) NSString* UserLdpiPhoto;
-(reply*)initWithJsonDictionary:(NSDictionary*)dic;
+(reply*)replyWithJsonDictionary:(NSDictionary*)dic;
@end
