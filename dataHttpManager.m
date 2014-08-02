//
//  dataHttpManager.m
//  房伴
//
//  Created by tao xu on 13-8-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "dataHttpManager.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "area.h"
#import "hint.h"
#import "agio.h"
#import "build.h"
#import "buildDetail.h"
#import "huType.h"
#import "nearby.h"
#import "info.h"
#import "reply.h"
#import "message.h"
#import "auth.h"
#import "loginViewController.h"
static dataHttpManager * instance=nil;
@implementation dataHttpManager
@synthesize requestQueue;
@synthesize delegate;
@synthesize Code,UserName,NickName,Phone,photo;
-(void)dealloc
{
    self.requestQueue = nil;
    [super dealloc];
}
//单例
+(dataHttpManager*)getInstance{
    @synchronized(self) {
        if (instance==nil) {
            instance=[[dataHttpManager alloc] initWithDelegate];
            [instance start];
        }
    }
    return instance;
}
//初始化
- (id)initWithDelegate {
    self = [super init];
    if (self) {
        requestQueue = [[ASINetworkQueue alloc] init];
        [requestQueue setDelegate:self];
        [requestQueue setRequestDidFailSelector:@selector(requestFailed:)];
        [requestQueue setRequestDidFinishSelector:@selector(requestFinished:)];
        [requestQueue setRequestWillRedirectSelector:@selector(request:willRedirectToURL:)];
		[requestQueue setShouldCancelAllRequestsOnFailure:NO];
        [requestQueue setShowAccurateProgress:YES];
        
    }
    
    return self;
}
#pragma mark - Methods
- (void)setGetUserInfo:(ASIHTTPRequest *)request withRequestType:(DataRequestType)requestType {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:requestType] forKey:REQUEST_TYPE];
    [request setUserInfo:dict];
    [dict release];
}

- (void)setPostUserInfo:(ASIFormDataRequest *)request withRequestType:(DataRequestType)requestType {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:requestType] forKey:REQUEST_TYPE];
    [request setUserInfo:dict];
    [dict release];
}

- (NSURL*)generateURL:(NSString*)baseURL params:(NSDictionary*)params {
	if (params) {
		NSMutableArray* pairs = [NSMutableArray array];
		for (NSString* key in params.keyEnumerator) {
			NSString* value = [params objectForKey:key];
			NSString* escaped_value = (NSString *)CFURLCreateStringByAddingPercentEscapes(
																						  kCFAllocatorDefault, /* allocator */
																						  (CFStringRef)value,
																						  NULL, /* charactersToLeaveUnescaped */
																						  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																						  kCFStringEncodingUTF8);
            
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
			[escaped_value release];
		}
		
		NSString* query = [pairs componentsJoinedByString:@"&"];
		NSString* url = [NSString stringWithFormat:@"%@?%@", baseURL, query];
		return [NSURL URLWithString:url];
	} else {
		return [NSURL URLWithString:baseURL];
	}
}
#pragma mark - Http Operate
//获取当前区域列表
-(void)getAreaList:(int)type father:(int)father{
    NSString *t = [NSString stringWithFormat:@"%d",type];
    NSString *f = [NSString stringWithFormat:@"%d",father];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:  t, @"type", f,  @"father",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/find/get_area_list.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"url=%@",url);
    [self setGetUserInfo:request withRequestType:AAGetAreaList];
    [requestQueue addOperation:request];
    [request release];
}
//同步获取到当前区域列表
-(NSArray *)getAreaListSynchronous:(int)type father:(int)father{
    NSString *t = [NSString stringWithFormat:@"%d",type];
    NSString *f = [NSString stringWithFormat:@"%d",father];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:  t, @"type",f,  @"father",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/find/get_area_list.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSLog(@"url=%@",url);
    [request startSynchronous];
    NSError *error = [request error];
    if(!error) {
        NSString * responseString = [request responseString];
        SBJsonParser    *parser     = [[SBJsonParser alloc] init];    
        id  returnObject = [parser objectWithString:responseString];
        [parser release];
        if ([returnObject isKindOfClass:[NSDictionary class]]) {
            NSString *errorString = [returnObject  objectForKey:@"IsOk"];
            if ([errorString intValue]==0 ) {
                
                NSLog(@"数据错误!");
            }
        }
        NSArray *arr= [(NSDictionary*)returnObject objectForKey:@"AreaList"];
        NSMutableArray  *statuesArr = [[NSMutableArray alloc]initWithCapacity:0];
        for (id item in arr) {
            area *sts = [area areaWithJsonDictionary:item];
            [statuesArr addObject:sts];
        }
       return statuesArr;
    }
    return nil;
}
//同步获取到查询条件列表
-(NSArray *)getHintList:(int)father{
    NSString *f = [NSString stringWithFormat:@"%d",father];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:f,  @"father",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/common/get_hint_list.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSLog(@"url=%@",url);
    [request startSynchronous];
    NSError *error = [request error];
    if(!error) {
        NSString * responseString = [request responseString];
        SBJsonParser    *parser     = [[SBJsonParser alloc] init];    
        id  returnObject = [parser objectWithString:responseString];
        [parser release];
        if ([returnObject isKindOfClass:[NSDictionary class]]) {
            NSString *errorString = [returnObject  objectForKey:@"IsOk"];
            if ([errorString intValue]==0) {
                
                NSLog(@"数据错误!");
            }
        }
        NSArray *arr= [(NSDictionary*)returnObject objectForKey:@"HintList"];
        NSMutableArray  *hintArr = [[NSMutableArray alloc] initWithCapacity:0];
        for (id item in arr) {
            hint *sts = [hint hintWithJsonDictionary:item];
            [hintArr addObject:sts];
        }
        
        return hintArr;
    }
    return nil;
}
//获取特价房源列表
-(void)getAgioList:(int)page size:(int)size lat:(double)lat lon:(double)lon{
    NSString *p = [NSString stringWithFormat:@"%d",page];
    NSString *s = [NSString stringWithFormat:@"%d",size];
    NSString *la = [NSString stringWithFormat:@"%f",lat];
    NSString *lo = [NSString stringWithFormat:@"%f",lon];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:  p, @"page", s,  @"size",la,  @"lat", lo,  @"lon",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/find/get_agio_list.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"url=%@",url);
    [self setGetUserInfo:request withRequestType:AAGetAgioList];
    [requestQueue addOperation:request];
    [request release];
}
//获取查询结果
-(void)getBuildList:(int)page size:(int)size area:(NSString*)area price:(NSString*)price hu:(NSString*)hu sqm:(NSString*)sqm dev:(NSString*)dev pro:(NSString*)pro key:(NSString*)key order:(NSString*)order{
    NSString *p = [NSString stringWithFormat:@"%d",page];
    NSString *s = [NSString stringWithFormat:@"%d",size];
    NSString *a = [NSString stringWithFormat:@"%@",area];
    NSString *pri = [NSString stringWithFormat:@"%@",price];
    NSString *h = [NSString stringWithFormat:@"%@",hu];
    NSString *sq = [NSString stringWithFormat:@"%@",sqm];
    NSString *d = [NSString stringWithFormat:@"%@",dev];
    NSString *pr = [NSString stringWithFormat:@"%@",pro];
    NSString *k = [NSString stringWithFormat:@"%@",key];
    NSString *o = [NSString stringWithFormat:@"%@",order];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:  p, @"page", s,  @"size",a,  @"area", pri,  @"price",h,  @"hu",sq,  @"sqm",d,  @"dev",pr,  @"pro",k,  @"key",o,  @"order",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/find/get_build_list.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"url=%@",url);
    [self setGetUserInfo:request withRequestType:AAGetBuildist];
    [requestQueue addOperation:request];
    [request release];
}
//获取房产详情
-(void)getBuildDetail:(int)index{
    NSString *t = [NSString stringWithFormat:@"%d",index];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:  t, @"id",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/find/get_build_detail.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"url=%@",url);
    [self setGetUserInfo:request withRequestType:AAGetBuildDetail];
    [requestQueue addOperation:request];
    [request release];
}
//同步获取周边同户型楼盘
-(NSArray *)getNearbyList:(int)page size:(int)size index:(int)index hu:(int)hu{
    NSString *p = [NSString stringWithFormat:@"%d",page];
    NSString *s = [NSString stringWithFormat:@"%d",size];
    NSString *i = [NSString stringWithFormat:@"%d",index];
    NSString *h = [NSString stringWithFormat:@"%d",hu];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:p,  @"page",s,  @"size",i,  @"id",h,  @"hu",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/find/get_nearby_list.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSLog(@"url=%@",url);
    [request startSynchronous];
    NSError *error = [request error];
    if(!error) {
        NSString * responseString = [request responseString];
        SBJsonParser    *parser     = [[SBJsonParser alloc] init];    
        id  returnObject = [parser objectWithString:responseString];
        [parser release];
        if ([returnObject isKindOfClass:[NSDictionary class]]) {
            NSString *errorString = [returnObject  objectForKey:@"IsOk"];
            if ([errorString intValue]==0 ) {
                
                NSLog(@"数据错误!");
            }
        }
        NSArray *arr= [(NSDictionary*)returnObject objectForKey:@"NearbyList"];
        NSMutableArray  *nearbyArr = [[NSMutableArray alloc] initWithCapacity:0];
        for (id item in arr) {
            nearby *sts = [nearby nearbyWithJsonDictionary:item];
            [nearbyArr addObject:sts];
        }
        
        return nearbyArr;
    }
    return nil;
}
//提交收藏的楼盘
-(void)postCollectBuildCode:(NSString *)code userCode:(NSString*)user{
    NSString *c = [NSString stringWithFormat:@"%@",code];
    NSString *u = [NSString stringWithFormat:@"%@",user];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:  c, @"code",u, @"user",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/find/collect_build.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"url=%@",url);
    [self setGetUserInfo:request withRequestType:AACollectBuild];
    [requestQueue addOperation:request];
    [request release];
}
//获取好友动态
-(void)getInfoList:(int )page size:(int)size user:(NSString* )code{
    NSString *p = [NSString stringWithFormat:@"%d",page];
    NSString *s = [NSString stringWithFormat:@"%d",size];
    NSString *c = [NSString stringWithFormat:@"%@",code];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:  p, @"page",s, @"size",c, @"user",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/info/get_info_list.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"url=%@",url);
    [self setGetUserInfo:request withRequestType:AAGetInfoList];
    [requestQueue addOperation:request];
    [request release];
}
//查看好友动态的详情信息
-(infoDetail *)getInfoDetail:(NSString *)infoId user:(NSString *)user{
    NSString *p = [NSString stringWithFormat:@"%@",infoId];
    NSString *s = [NSString stringWithFormat:@"%@",user];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:p,  @"id",s,  @"user",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/info/get_info_detail.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSLog(@"url=%@",url);
    [request startSynchronous];
    NSError *error = [request error];
    if(!error) {
        NSString * responseString = [request responseString];
        SBJsonParser    *parser     = [[SBJsonParser alloc] init];    
        id  returnObject = [parser objectWithString:responseString];
        [parser release];
        if ([returnObject isKindOfClass:[NSDictionary class]]) {
            NSString *errorString = [returnObject  objectForKey:@"IsOk"];
            if ([errorString intValue]==0 ) {
                
                NSLog(@"数据错误!");
            }
        }
        infoDetail *info=[infoDetail infoDetailWithJsonDictionary:returnObject];
        return info;
    }
    return nil;
}
//回复列表
-(void)getReplyList:(int )page size:(int)size info:(NSString* )code{
    NSString *p = [NSString stringWithFormat:@"%d",page];
    NSString *s = [NSString stringWithFormat:@"%d",size];
    NSString *c = [NSString stringWithFormat:@"%@",code];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:  p, @"page",s, @"size",c, @"code",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/info/get_reply_list.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"url=%@",url);
    [self setGetUserInfo:request withRequestType:AAGetReplyList];
    [requestQueue addOperation:request];
    [request release];
}
//获取每日一说或者是官方楼盘的消息列表
-(void)getMsgList:(int )page size:(int)size type:(NSString* )type user:(NSString *)user code:(NSString *)code{
    NSString *p = [NSString stringWithFormat:@"%d",page];
    NSString *s = [NSString stringWithFormat:@"%d",size];
    NSString *t = [NSString stringWithFormat:@"%@",type];
    NSString *u = [NSString stringWithFormat:@"%@",user];
    NSString *c = [NSString stringWithFormat:@"%@",code];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:  p, @"page",s, @"size",t, @"type",u, @"user",c, @"build",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/info/get_msg_list.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"url=%@",url);
    [self setGetUserInfo:request withRequestType:AAGetMsgList];
    [requestQueue addOperation:request];
    [request release];
}
//获取每日一说或者是官方楼盘的详情信息
-(messageDetail *)getMessageDetail:(NSString *)msgId user:(NSString *)user{
    NSString *p = [NSString stringWithFormat:@"%@",msgId];
    NSString *s = [NSString stringWithFormat:@"%@",user];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:p,  @"id",s,  @"user",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/info/get_msg_detail.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSLog(@"url=%@",url);
    [request startSynchronous];
    NSError *error = [request error];
    if(!error) {
        NSString * responseString = [request responseString];
        SBJsonParser    *parser     = [[SBJsonParser alloc] init];    
        id  returnObject = [parser objectWithString:responseString];
        [parser release];
        if ([returnObject isKindOfClass:[NSDictionary class]]) {
            NSString *errorString = [returnObject  objectForKey:@"IsOk"];
            if ([errorString intValue]==0) {
                
                NSLog(@"数据错误!");
            }
        }
        messageDetail *info=[messageDetail messageDetailWithJsonDictionary:returnObject];
        return info;
    }
    return nil;
}
//发表动态
-(void)sendInfo:(NSString *)user intr:(NSString *)intr photo:(UIImage *)image address:(NSString *)address lat:(NSString *)lat lon:(NSString *)lon{
    NSString *u = [NSString stringWithFormat:@"%@",user];
    NSString *i = [NSString stringWithFormat:@"%@",intr];
    NSString *a = [NSString stringWithFormat:@"%@",address];
    NSString *l = [NSString stringWithFormat:@"%@",lat];
    NSString *o = [NSString stringWithFormat:@"%@",lon];
    
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:  u, @"user",i, @"intr",a, @"address",l, @"lat",o, @"lon",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/info/send_info.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    if(image){
        UIImage *img = [self scaleToSize:image size:CGSizeMake(300,300)]; 
        [request setData:UIImagePNGRepresentation(img) forKey:@"photo"];
    }
    NSLog(@"url=%@",url);
    [self setPostUserInfo:request withRequestType:AASendInfo];
    [requestQueue addOperation:request];
    [request release];

}
//进行回复
-(void)sendReply:(NSString *)user infoCode:(NSString *)code reply:(int)reply toUser:(NSString *)at intr:(NSString *)intr photo:(UIImage *)image address:(NSString *)address    lat:(NSString *)lat lon:(NSString *)lon{
    NSString *u = [NSString stringWithFormat:@"%@",user];
    NSString *c = [NSString stringWithFormat:@"%@",code];
    NSString *r = [NSString stringWithFormat:@"%d",reply];
    NSString *a = [NSString stringWithFormat:@"%@",at];
    NSString *i = [NSString stringWithFormat:@"%@",intr];
    NSString *ad = [NSString stringWithFormat:@"%@",address];
    NSString *l = [NSString stringWithFormat:@"%@",lat];
    NSString *o = [NSString stringWithFormat:@"%@",lon];
    
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:  u, @"user",c, @"code",r, @"reply",a, @"at",i, @"intr",ad, @"address",l, @"lat",o, @"lon",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/info/send_reply.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    if(image){
        UIImage *img = [self scaleToSize:image size:CGSizeMake(300,300)]; 
        [request setData:UIImagePNGRepresentation(img) forKey:@"photo"];
    }
    NSLog(@"url=%@",url);
    [self setPostUserInfo:request withRequestType:AASendReply];
    [requestQueue addOperation:request];
    [request release];
}
//继续添加

//压缩图片
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{    
    // 创建一个bitmap的context    
    // 并把它设置成为当前正在使用的context    
    UIGraphicsBeginImageContext(size);    
    // 绘制改变大小的图片    
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];    
    // 从当前context中创建一个改变大小后的图片    
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();    
    // 使当前的context出堆栈    
    UIGraphicsEndImageContext();    
    //返回新的改变大小后的图片    
    return scaledImage;    
}  
#pragma mark - Operate queue
- (BOOL)isRunning
{
	return ![requestQueue isSuspended];
}

- (void)start
{
	if( [requestQueue isSuspended] )
		[requestQueue go];
}

- (void)pause
{
	[requestQueue setSuspended:YES];
}

- (void)resume
{
	[requestQueue setSuspended:NO];
}

- (void)cancel
{
	[requestQueue cancelAllOperations];
}
#pragma mark - ASINetworkQueueDelegate
//失败
- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败:%@,%@,",request.responseString,[request.error localizedDescription]);
}

//成功
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSDictionary *userInformation = [request userInfo];
    DataRequestType requestType = [[userInformation objectForKey:REQUEST_TYPE] intValue];
    NSString * responseString = [request responseString];
    SBJsonParser    *parser     = [[SBJsonParser alloc] init];    
    id  returnObject = [parser objectWithString:responseString];
    [parser release];
    if ([returnObject isKindOfClass:[NSDictionary class]]) {
        NSString *errorString = [returnObject  objectForKey:@"IsOk"];
        if ([errorString intValue]==0) {
            
            NSLog(@"数据错误!");
        }
    }
    
    NSDictionary *userInfo = nil;
    NSArray *userArr = nil;
    if ([returnObject isKindOfClass:[NSDictionary class]]) {
        userInfo = (NSDictionary*)returnObject;
    }
    else if ([returnObject isKindOfClass:[NSArray class]]) {
        userArr = (NSArray*)returnObject;
    }
    else {
        return;
    }
    
    
    //获取当前区域列表
    if (requestType == AAGetAreaList) {
        NSArray *arr= [userInfo objectForKey:@"AreaList"];
        NSMutableArray  *statuesArr = [[NSMutableArray alloc]initWithCapacity:0];
        for (id item in arr) {
            area* sts = [area areaWithJsonDictionary:item];
            [statuesArr addObject:sts];
        }
        if ([delegate respondsToSelector:@selector(didGetAreaList:)]) {
            [delegate didGetAreaList:statuesArr];
        }
    }
    //获取特价房源列表
    if (requestType == AAGetAgioList) {
        NSArray *arr= [userInfo objectForKey:@"AgioList"];
        NSMutableArray  *statuesArr = [[NSMutableArray alloc]initWithCapacity:0];
        for (id item in arr) {
            agio* sts = [agio agioWithJsonDictionary:item];
            [statuesArr addObject:sts];
        }
        if ([delegate respondsToSelector:@selector(didGetAgioList:Total:)]) {
            [delegate didGetAgioList:statuesArr Total:[[userInfo objectForKey:@"Total"] intValue]];
        }
    }
    //获取查询结果
    if (requestType == AAGetBuildist) {
        NSArray *arr= [userInfo objectForKey:@"BuildList"];
        NSMutableArray  *statuesArr = [[NSMutableArray alloc]initWithCapacity:0];
        for (id item in arr) {
            build* sts = [build buildWithJsonDictionary:item];
            [statuesArr addObject:sts];
        }
        if ([delegate respondsToSelector:@selector(didGetBuildList:Total:)]) {
            [delegate didGetBuildList:statuesArr  Total:[[userInfo objectForKey:@"Total"] intValue]];
        }
    }
    //获取房产详情
    if (requestType == AAGetBuildDetail) {
        NSArray *arr= [userInfo objectForKey:@"HuList"];
        NSMutableArray  *statuesArr = [[NSMutableArray alloc]initWithCapacity:0];
        for (id item in arr) {
            huType* sts = [huType huTypeWithJsonDictionary:item];
            [statuesArr addObject:sts];
        }
        buildDetail *build=[buildDetail buildDetailWithJsonDictionary:userInfo];
        build.huTypeList=[statuesArr retain];
        NSLog(@"%@",build.BuildName);
        if ([delegate respondsToSelector:@selector(didGetBuildDetail:)]) {
            [delegate didGetBuildDetail:build];
        }
        
    }
    //提交收藏的房屋
    if (requestType == AACollectBuild) {
        
    }
    //获取好友动态
    if (requestType == AAGetInfoList) {
        NSArray *arr= [userInfo objectForKey:@"InfoList"];
        NSMutableArray  *statuesArr = [[NSMutableArray alloc]initWithCapacity:0];
        for (id item in arr) {
            info* sts = [info infoWithJsonDictionary:item];
            [statuesArr addObject:sts];
        }
        if ([delegate respondsToSelector:@selector(didGetInfoList:Total:)]) {
            [delegate didGetInfoList:statuesArr  Total:[[userInfo objectForKey:@"Total"] intValue]];
        }
    }
    //回复列表
    if(requestType == AAGetReplyList){
        NSArray *arr= [userInfo objectForKey:@"ReplyList"];
        NSMutableArray  *statuesArr = [[NSMutableArray alloc]initWithCapacity:0];
        for (id item in arr) {
            reply* sts = [reply replyWithJsonDictionary:item];
            [statuesArr addObject:sts];
        }
        if ([delegate respondsToSelector:@selector(didGetReplyList:Total:)]) {
            [delegate didGetReplyList:statuesArr Total:[[userInfo objectForKey:@"Total"] intValue]];
        }
    }
    //获取每日一说或者是官方楼盘的消息列表
    if(requestType == AAGetMsgList){
        NSArray *arr= [userInfo objectForKey:@"MsgList"];
        NSMutableArray  *statuesArr = [[NSMutableArray alloc]initWithCapacity:0];
        for (id item in arr) {
            message* sts = [message messageWithJsonDictionary:item];
            [statuesArr addObject:sts];
        }
        if ([delegate respondsToSelector:@selector(didGetMsgList:Total:)]) {
            [delegate didGetMsgList:statuesArr Total:[[userInfo objectForKey:@"Total"] intValue]];
        }
    }
    //提交收藏的房屋
    if (requestType == AASendInfo) {
        
    }
    //继续添加
    
    
    
}
//存储用户
- (void)storeAuthData
{
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              Code, @"Code",
                              UserName, @"UserName",NickName, @"NickName",Phone, @"Phone",photo,@"photo",nil];
    
     [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"AUTH"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
//获取用户
- (void)getAuthorData
{
    NSDictionary *AuthInfo;
    AuthInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"AUTH"];    
    if ([AuthInfo objectForKey:@"Code"] && [AuthInfo objectForKey:@"UserName"] &&  [AuthInfo objectForKey:@"Phone"])
    {
        Code = [AuthInfo objectForKey:@"Code"];
        UserName = [AuthInfo objectForKey:@"UserName"];
        NickName = [AuthInfo objectForKey:@"NickName"];
        Phone = [AuthInfo objectForKey:@"Phone"];
        photo=[AuthInfo objectForKey:@"photo"];
    }
    else{
        Phone = nil;
        NickName = nil;
        UserName = nil;
        Code = nil;
        photo=nil;
    }
}

/**
 * 判断是否登录
 * 
 */
- (BOOL)isLoggedIn
{
    return Code && UserName && NickName && Phone;
}
//登陆入口
- (BOOL)logIn{
    [self getAuthorData];
    if([self isLoggedIn]){
        if ([delegate respondsToSelector:@selector(didGetAuthInfo:userName:nikeName:phone:photo:)]) {
            [delegate didGetAuthInfo:Code userName:UserName nikeName:NickName phone:Phone photo:photo];
        }
        return YES;
    }else {
        return NO; 
    }
}
//退出登陆
- (void)logOut{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AUTH"];
}
//登录验证用户
-(BOOL)loginCheck:(NSString *)phone password:(NSString *)password{
    NSString *p = [NSString stringWithFormat:@"%@",phone];
    NSString *s = [NSString stringWithFormat:@"%@",password];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:p,  @"phone",s,  @"password",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/common/login_check.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSLog(@"url=%@",url);
    [request startSynchronous];
    NSError *error = [request error];
    if(!error) {
        NSString * responseString = [request responseString];
        SBJsonParser    *parser     = [[SBJsonParser alloc] init];    
        id  returnObject = [parser objectWithString:responseString];
        [parser release];
        if ([returnObject isKindOfClass:[NSDictionary class]]) {
            NSString *errorString = [returnObject  objectForKey:@"IsOk"];
            if ([errorString intValue]==0) {                
                NSLog(@"数据错误!");
                return NO;
            }else {
                Code=[returnObject  objectForKey:@"Code"];
                UserName=[returnObject  objectForKey:@"UserName"];
                NickName=[returnObject  objectForKey:@"NickName"];
                Phone=[returnObject  objectForKey:@"Phone"];
                photo=[returnObject  objectForKey:@"LdpiPhoto"];
                if ([delegate respondsToSelector:@selector(didGetAuthInfo:userName:nikeName:phone:photo:)]) {
                    [delegate didGetAuthInfo:Code userName:UserName nikeName:NickName phone:Phone photo:photo];
                }
                [self storeAuthData];
            }
        }
        
    }
    return YES;
}
//注册新用户
-(BOOL)registerUser:(NSString *)phone password:(NSString *)password photo:(UIImage *)image{
    NSString *p = [NSString stringWithFormat:@"%@",phone];
    NSString *s = [NSString stringWithFormat:@"%@",password];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:p,  @"phone",s,  @"password",nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"%@/common/register_user.aspx",HTTP_URL];
    NSURL  *url = [self generateURL:baseUrl params:params];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    if(image){
        UIImage *img = [self scaleToSize:image size:CGSizeMake(300,300)]; 
        [request setData:UIImagePNGRepresentation(img) forKey:@"photo"];
    }
    NSLog(@"url=%@",url);
    [request startSynchronous];
    NSError *error = [request error];
    if(!error) {
        NSString * responseString = [request responseString];
        SBJsonParser    *parser     = [[SBJsonParser alloc] init];    
        id  returnObject = [parser objectWithString:responseString];
        [parser release];
        if ([returnObject isKindOfClass:[NSDictionary class]]) {
            NSString *errorString = [returnObject  objectForKey:@"IsOk"];
            if ([errorString intValue]==0) {
                
                return NO;
            }else {
                [self loginCheck:phone password:password];
            }
            
        }
        
    }
    return YES;
}
//跳转
- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL {
    NSLog(@"请求将要跳转");
}

@end
