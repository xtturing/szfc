//
//  infoDetail.h
//  房伴
//
//  Created by tao xu on 13-8-19.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionaryAdditions.h"
@interface infoDetail : NSObject{
    NSString* Id;
    NSString* Code;
    NSString* InfoType;
    NSString* TypeName;
    NSString* InfoIntr;
    
    NSString* InfoHdpiPhoto;
    NSString* InfoMdpiPhoto;
    NSString* InfoLdpiPhoto;
    NSString* Address;
    NSString* CommentNum;
    
    NSString* TransmitNum;
    NSString* PraiseNum;
    NSString* IsPraise;
    NSString* AddTime;
    NSString* AddUser;
    
    NSString* NickName;
    NSString* UserHdpiPhoto;
    NSString* UserMdpiPhoto;
    NSString* UserLdpiPhoto;
}
@property (nonatomic, retain) NSString* Id;
@property (nonatomic, retain) NSString* Code;
@property (nonatomic, retain) NSString* InfoType;
@property (nonatomic, retain) NSString* TypeName;
@property (nonatomic, retain) NSString* InfoIntr;

@property (nonatomic, retain) NSString* InfoHdpiPhoto;
@property (nonatomic, retain) NSString* InfoMdpiPhoto;
@property (nonatomic, retain) NSString* InfoLdpiPhoto;
@property (nonatomic, retain) NSString* Address;
@property (nonatomic, retain) NSString* CommentNum;

@property (nonatomic, retain) NSString* TransmitNum;
@property (nonatomic, retain) NSString* PraiseNum;
@property (nonatomic, retain) NSString* IsPraise;
@property (nonatomic, retain) NSString* AddTime;
@property (nonatomic, retain) NSString* AddUser;

@property (nonatomic, retain) NSString* NickName;
@property (nonatomic, retain) NSString* UserHdpiPhoto;
@property (nonatomic, retain) NSString* UserMdpiPhoto;
@property (nonatomic, retain) NSString* UserLdpiPhoto;
-(infoDetail*)initWithJsonDictionary:(NSDictionary*)dic;
+(infoDetail*)infoDetailWithJsonDictionary:(NSDictionary*)dic;
@end
