//
//  dataHttpManager.h
//  房伴
//
//  Created by tao xu on 13-8-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "StringUtil.h"
#import "NSStringAdditions.h"
#import "buildDetail.h"
#import "infoDetail.h"
#import "messageDetail.h"
#define HTTP_URL              @"http://www.szlife360.com/villa"
#define REQUEST_TYPE          @"requestType"

typedef enum {
    AAGetAreaList = 0,           //获取当前区域列表
    AAGetHintList,              //获取搜索页面的其他查询条件
    AAGetAgioList,             //获取特价房源列表
    AAGetBuildist,//获取查询结果
    AAGetBuildDetail,//获取房产详情
    AACollectBuild,//提交收藏的房屋
    AAGetInfoList,//获取好友动态
    AAGetReplyList,//回复列表
    AAGetMsgList,//获取每日一说或者是官方楼盘的消息列表
    AASendInfo,//发表动态
    AASendReply,//进行回复
    //继续添加
    
}DataRequestType;


@class ASINetworkQueue;


//Delegate
@protocol dataHttpDelegate <NSObject>
@optional
//获取到当前区域列表
-(void)didGetAreaList:(NSArray*)areaList;
//获取到特价房源列表
-(void)didGetAgioList:(NSArray*)agioList Total:(int)Total;
//获取到查询结果
-(void)didGetBuildList:(NSArray*)buildList Total:(int)Total;
//获取房产详情
-(void)didGetBuildDetail:(buildDetail*)buildDetail;
//获取好友动态
-(void)didGetInfoList:(NSArray *)infoList Total:(int)Total;
//回复列表
-(void)didGetReplyList:(NSArray *)replyList Total:(int)Total;
//获取每日一说或者是官方楼盘的消息列表
-(void)didGetMsgList:(NSArray *)msgList Total:(int)Total;
//获取登陆的用户信息
-(void)didGetAuthInfo:(NSString *)code userName:(NSString *)userName nikeName:(NSString *)nikeName phone:(NSString *)phone photo:(NSString *)photo; 
//继续添加
@end


@interface dataHttpManager : NSObject{
    ASINetworkQueue *requestQueue;
    id<dataHttpDelegate> delegate;
    NSString *Code;
    NSString *UserName;
    NSString *NickName;
    NSString *Phone;
    NSString *photo;
}
@property (nonatomic, retain) NSString *Code;
@property (nonatomic, retain) NSString *UserName;
@property (nonatomic, retain) NSString *NickName;
@property (nonatomic, retain) NSString *Phone;
@property (nonatomic, retain) NSString *photo;
@property (nonatomic,retain) ASINetworkQueue *requestQueue;
@property (nonatomic,assign) id<dataHttpDelegate> delegate;
+(dataHttpManager*)getInstance;
- (id)initWithDelegate;

- (BOOL)isRunning;
- (void)start;
- (void)pause;
- (void)resume;
- (void)cancel;
//获取当前区域列表
-(void)getAreaList:(int)type father:(int)father;
//同步获取到当前区域列表
-(NSArray *)getAreaListSynchronous:(int)type father:(int)father;
//同步获取到查询条件列表
-(NSArray *)getHintList:(int)father;
//获取特价房源列表
-(void)getAgioList:(int)page size:(int)size lat:(double)lat lon:(double)lon;
//获取查询结果
-(void)getBuildList:(int)page size:(int)size area:(NSString*)area price:(NSString*)price hu:(NSString*)hu sqm:(NSString*)sqm dev:(NSString*)dev pro:(NSString*)pro key:(NSString*)key order:(NSString*)order;
//获取房产详情
-(void)getBuildDetail:(int)index;
//同步获取周边同户型楼盘
-(NSArray *)getNearbyList:(int)page size:(int)size index:(int)index hu:(int)hu;
//提交收藏的楼盘
-(void)postCollectBuildCode:(NSString *)code userCode:(NSString*)user;
//获取好友动态
-(void)getInfoList:(int )page size:(int)size user:(NSString* )code;
//查看好友动态的详情信息
-(infoDetail *)getInfoDetail:(NSString *)infoId user:(NSString *)user;
//回复列表
-(void)getReplyList:(int )page size:(int)size info:(NSString* )code;
//获取每日一说或者是官方楼盘的消息列表
-(void)getMsgList:(int )page size:(int)size type:(NSString* )type user:(NSString *)user code:(NSString *)code;
//获取每日一说或者是官方楼盘的详情信息
-(messageDetail *)getMessageDetail:(NSString *)msgId user:(NSString *)user;
//发表动态
-(void)sendInfo:(NSString *)user intr:(NSString *)intr photo:(UIImage *)image address:(NSString *)address lat:(NSString *)lat lon:(NSString *)lon;
//进行回复
-(void)sendReply:(NSString *)user infoCode:(NSString *)code reply:(int)reply toUser:(NSString *)at intr:(NSString *)intr photo:(UIImage *)image address:(NSString *)address    lat:(NSString *)lat lon:(NSString *)lon;
//判断是否已经登陆过
- (BOOL)logIn;
//退出登陆
- (void)logOut;
//登录验证用户
-(BOOL)loginCheck:(NSString *)phone password:(NSString *)password;
//注册新用户
-(BOOL)registerUser:(NSString *)phone password:(NSString *)password photo:(UIImage *)image; 
//继续添加
@end
