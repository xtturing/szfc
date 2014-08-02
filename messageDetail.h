//
//  messageDetail.h
//  房伴
//
//  Created by tao xu on 13-8-26.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionaryAdditions.h"
@interface messageDetail : NSObject{
    NSString* Id;
    NSString* Code;
    NSString* MsgType;
    NSString* TypeName;
    NSString* BuildCode;
    
    NSString* BuildName;
    NSString* MsgIntr;
    NSString* MsgHdpiPhoto;
    NSString* MsgMdpiPhoto;
    NSString* MsgLdpiPhoto;
    
    NSString* Address;
    NSString* CommentNum;
    NSString* TransmitNum;
    NSString* PraiseNum;
    NSString* AddTime;
    
    NSString* AddUser;
    NSString* NickName;
    NSString* UserHdpiPhoto;
    NSString* UserMdpiPhoto;
    NSString* UserLdpiPhoto;
    
}
@property (nonatomic, retain)NSString* Id;
@property (nonatomic, retain)NSString* Code;
@property (nonatomic, retain)NSString* MsgType;
@property (nonatomic, retain)NSString* TypeName;
@property (nonatomic, retain)NSString* BuildCode;

@property (nonatomic, retain)NSString* BuildName;
@property (nonatomic, retain)NSString* MsgIntr;
@property (nonatomic, retain)NSString* MsgHdpiPhoto;
@property (nonatomic, retain)NSString* MsgMdpiPhoto;
@property (nonatomic, retain)NSString* MsgLdpiPhoto;

@property (nonatomic, retain)NSString* Address;
@property (nonatomic, retain)NSString* CommentNum;
@property (nonatomic, retain)NSString* TransmitNum;
@property (nonatomic, retain)NSString* PraiseNum;
@property (nonatomic, retain)NSString* AddTime;

@property (nonatomic, retain)NSString* AddUser;
@property (nonatomic, retain)NSString* NickName;
@property (nonatomic, retain)NSString* UserHdpiPhoto;
@property (nonatomic, retain)NSString* UserMdpiPhoto;
@property (nonatomic, retain)NSString* UserLdpiPhoto;
-(messageDetail*)initWithJsonDictionary:(NSDictionary*)dic;
+(messageDetail*)messageDetailWithJsonDictionary:(NSDictionary*)dic;

@end
