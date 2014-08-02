//
//  KRShare.m
//  KRShareKit
//
//  Created by 519968211 on 13-1-9.
//  Copyright (c) 2013年 519968211. All rights reserved.
//

#import "KRShare.h"
#import "KRShareConstants.h"

@protocol KRSH;


static KRShare *instance;

@implementation KRShare

@synthesize userID;
@synthesize accessToken;
@synthesize expirationDate;
@synthesize refreshToken;
@synthesize ssoCallbackScheme;
@synthesize delegate;
@synthesize appKey;
@synthesize appSecret;
@synthesize appRedirectURI;
@synthesize shareTarget;

#pragma mark - Memory management

/**
 * @description 初始化构造函数，返回采用默认sso回调地址构造的KRShare对象
 * @param _appKey: 分配给第三方应用的appkey
 * @param _appSecrect: 分配给第三方应用的appsecrect
 * @param _appRedirectURI: 微博开放平台中授权设置的应用回调页
 * @return KRShare对象
 */


+ (id)sharedInstanceWithTarget:(KRShareTarget)target
{
    if (instance == nil)
    {
        instance = [[[self class] alloc] init];
    }
    
    instance.shareTarget = target;
    
    [instance getAuthorData];

    return instance;
}

- (void)getAuthorData
{
    NSDictionary *KRShareAuthInfo;
    
    if(shareTarget == KRShareTargetSinablog)
    {
        appKey = kSinaWeiboAppKey;
        appSecret = kSinaWeiboAppSecret;
        appRedirectURI = kSinaWeiboAppRedirectURI;
        KRShareAuthInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"KRShareAuthData-Sina"];
    }
    else if(shareTarget == KRShareTargetTencentblog)
    {
        appKey = kTencentWeiboAppKey;
        appSecret = kTencentWeiboAppSecret;
        appRedirectURI = kTencentWeiboAppRedirectURI;
        KRShareAuthInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"KRShareAuthData-Tencent"];
    }
    else if(shareTarget == KRShareTargetDoubanblog)
    {
        appKey = kDoubanBroadAppKey;
        appSecret = kDoubanBroadAppSecret;
        appRedirectURI = kDoubanBroadAppRedirectURI;
        KRShareAuthInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"KRShareAuthData-Douban"];
    }
    else
    {
        appKey = kRenrenBroadAppKey;
        appSecret = kRenrenBroadAppSecret;
        appRedirectURI = kRenrenBroadAppRedirectURI;
        KRShareAuthInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"KRShareAuthData-Renren"];
    }
    
    
    
    if ([KRShareAuthInfo objectForKey:@"AccessTokenKey"] && [KRShareAuthInfo objectForKey:@"ExpirationDateKey"] && [KRShareAuthInfo objectForKey:@"UserIDKey"])
    {
        accessToken = [KRShareAuthInfo objectForKey:@"AccessTokenKey"];
        expirationDate = [KRShareAuthInfo objectForKey:@"ExpirationDateKey"];
        userID = [KRShareAuthInfo objectForKey:@"UserIDKey"];
    }
    else{
        accessToken = nil;
        expirationDate = nil;
        userID = nil;
    }
}

- (id)initWithAppKey:(NSString *)_appKey appSecret:(NSString *)_appSecrect
      appRedirectURI:(NSString *)_appRedirectURI
         andDelegate:(id<KRShareDelegate>)_delegate
{
    return [self initWithAppKey:_appKey appSecret:_appSecrect appRedirectURI:_appRedirectURI ssoCallbackScheme:nil andDelegate:_delegate];
}


/**
 * @description 初始化构造函数，返回采用默认sso回调地址构造的KRShare对象
 * @param _appKey: 分配给第三方应用的appkey
 * @param _appSecrect: 分配给第三方应用的appsecrect
 * @param _ssoCallbackScheme: sso回调地址，此值应与URL Types中定义的保持一致
 *            若为nil,则初始化为默认格式 KRSharesso.your_app_key;
 * @param _appRedirectURI: 微博开放平台中授权设置的应用回调页
 * @return KRShare对象
 */
- (id)initWithAppKey:(NSString *)_appKey appSecret:(NSString *)_appSecrect
      appRedirectURI:(NSString *)_appRedirectURI
   ssoCallbackScheme:(NSString *)_ssoCallbackScheme
         andDelegate:(id<KRShareDelegate>)_delegate
{
    if ((self = [super init]))
    {
        self.appKey = _appKey;
        self.appSecret = _appSecrect;
        self.appRedirectURI = _appRedirectURI;
        self.delegate = _delegate;
        
        if (!_ssoCallbackScheme)
        {
            _ssoCallbackScheme = [NSString stringWithFormat:@"KRSharesso.%@://", self.appKey];
        }
        self.ssoCallbackScheme = _ssoCallbackScheme;
        
        requests = [[NSMutableSet alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
    delegate = nil;
    
    for (KRShareRequest* _request in requests)
    {
        _request.krShare = nil;
    }
    
    [request disconnect];
    [request release], request = nil;
    [userID release], userID = nil;
    [accessToken release], accessToken = nil;
    [expirationDate release], expirationDate = nil;
    [appKey release], appKey = nil;
    [appSecret release], appSecret = nil;
    [appRedirectURI release], appRedirectURI = nil;
    [ssoCallbackScheme release], ssoCallbackScheme = nil;
    
    [super dealloc];
}


- (void)storeAuthData
{
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              accessToken, @"AccessTokenKey",
                              expirationDate, @"ExpirationDateKey",
                              userID, @"UserIDKey",
                              refreshToken, @"refresh_token", nil];
    
    if(shareTarget == KRShareTargetSinablog)
    {
        [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"KRShareAuthData-Sina"];
    }
    else if(shareTarget == KRShareTargetTencentblog)
    {
        [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"KRShareAuthData-Tencent"];
    }
    else if(shareTarget == KRShareTargetDoubanblog)
    {
        [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"KRShareAuthData-Douban"];
    }
    else if(shareTarget == KRShareTargetRenrenblog)
    {
        [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"KRShareAuthData-Renren"];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

/**
 * @description 清空认证信息
 */
- (void)removeAuthData
{
    self.accessToken = nil;
    self.userID = nil;
    self.expirationDate = nil;
    
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSString *url;
    if(shareTarget == KRShareTargetSinablog)
    {
        url = @"https://open.weibo.cn";
    }
    else if(shareTarget == KRShareTargetTencentblog)
    {
        url = @"https://open.t.qq.com";
    }
    else if(shareTarget == KRShareTargetDoubanblog)
    {
        url = @"https://www.douban.com";
    }
    else
    {
        url = @"https://graph.renren.com";
    }

    
    NSArray* KRShareCookies = [cookies cookiesForURL:
                                 [NSURL URLWithString:url]];
    
    for (NSHTTPCookie* cookie in KRShareCookies)
    {
        [cookies deleteCookie:cookie];
    }
}

#pragma mark - Private methods

- (void)requestAccessTokenWithAuthorizationCode:(NSString *)code
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            self.appKey, @"client_id",
                            self.appSecret, @"client_secret",
                            @"authorization_code", @"grant_type",
                            self.appRedirectURI, @"redirect_uri",
                            code, @"code", nil];
    [request disconnect];
    [request release], request = nil;
    
    NSString *AccessTokenURL;
    
    if(shareTarget == KRShareTargetSinablog)
    {
        AccessTokenURL = kSinaWeiboWebAccessTokenURL;
    }
    else if(shareTarget == KRShareTargetTencentblog)
    {
        AccessTokenURL = kTencentWeiboWebAccessTokenURL;
    }
    else if(shareTarget == KRShareTargetDoubanblog)
    {
        AccessTokenURL = kDoubanBroadWebAccessTokenURL;
    }
    else
    {
        AccessTokenURL = kRenrenBroadWebAccessTokenURL;
    }
    
    request = [[KRShareRequest requestWithURL:AccessTokenURL
                                     httpMethod:@"POST"
                                         params:params
                                       delegate:self] retain];
    
    [request connect];
}

- (void)requestDidFinish:(KRShareRequest *)_request
{
    [requests removeObject:_request];
    _request.krShare = nil;
}

- (void)requestDidFailWithInvalidToken:(NSError *)error
{
    if ([delegate respondsToSelector:@selector(krShare:accessTokenInvalidOrExpired:)])
    {
        [delegate krShare:self accessTokenInvalidOrExpired:error];
    }
}

- (void)notifyTokenExpired:(id<KRShareRequestDelegate>)requestDelegate
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"Token expired", NSLocalizedDescriptionKey, nil];
    
    NSString *SDKErrorDomain;
    if(shareTarget == KRShareTargetSinablog)
    {
        SDKErrorDomain = kSinaWeiboSDKErrorDomain;
    }
    else if(shareTarget == KRShareTargetTencentblog)
    {
        SDKErrorDomain = kTencentWeiboSDKErrorDomain;
    }
    else if(shareTarget == KRShareTargetDoubanblog)
    {
        SDKErrorDomain = kDoubanBroadSDKErrorDomain;
    }
    else
    {
        SDKErrorDomain = kRenrenBroadSDKErrorDomain;
    }

    NSError *error = [NSError errorWithDomain:SDKErrorDomain
                                         code:21315
                                     userInfo:userInfo];
    
    if ([delegate respondsToSelector:@selector(krShare:accessTokenInvalidOrExpired:)])
    {
        [delegate krShare:self accessTokenInvalidOrExpired:error];
    }
    
    if ([requestDelegate respondsToSelector:@selector(request:didFailWithError:)])
	{
		[requestDelegate request:nil didFailWithError:error];
	}
}

- (void)logInDidCancel
{
    if ([delegate respondsToSelector:@selector(KRShareLogInDidCancel:)])
    {
        [delegate KRShareLogInDidCancel:self];
    }
}

- (void)logInDidFinishWithAuthInfo:(NSDictionary *)authInfo
{NSLog(@"auto:%@",authInfo);
    //新浪的比较特别，所以不在这个函数中获得access_token
    NSString *access_token = [authInfo objectForKey:@"access_token"];
    NSString *uid = [authInfo objectForKey:@"uid"];
    NSString *remind_in = [authInfo objectForKey:@"remind_in"];
    NSString *refresh_token = [authInfo objectForKey:@"refresh_token"];
    if(shareTarget == KRShareTargetTencentblog)
    {
        uid = [authInfo objectForKey:@"openid"];
        remind_in = [authInfo objectForKey:@"expires_in"];
    }
    
    else if(shareTarget == KRShareTargetDoubanblog)
    {
        uid = [authInfo objectForKey:@"douban_user_id"];
        remind_in = [authInfo objectForKey:@"expires_in"];
    }
    
    else if(shareTarget == KRShareTargetRenrenblog)
    {
        uid = [[authInfo objectForKey:@"user"] objectForKey:@"id"];
        remind_in = [authInfo objectForKey:@"expires_in"];
    }
    
    if (access_token && uid)
    {
        if (remind_in != nil)
        {
            int expVal = [remind_in intValue];
            if (expVal == 0)
            {
                self.expirationDate = [NSDate distantFuture];
            }
            else
            {
                self.expirationDate = [NSDate dateWithTimeIntervalSinceNow:expVal];
            }
        }
        
        self.accessToken = access_token;
        self.userID = uid;
        self.refreshToken = refresh_token;
        
        [self storeAuthData];
        
        if ([delegate respondsToSelector:@selector(KRShareDidLogIn:)])
        {
            [delegate KRShareDidLogIn:self];
        }
    }
}

- (void)logInDidFailWithErrorInfo:(NSDictionary *)errorInfo
{
    NSString *error_code = [errorInfo objectForKey:@"error_code"];
    if ([error_code isEqualToString:@"21330"])
    {
        [self logInDidCancel];
    }
    else
    {
        if ([delegate respondsToSelector:@selector(krShare:logInDidFailWithError:)])
        {
            NSString *error_description = [errorInfo objectForKey:@"error_description"];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                      errorInfo, @"error",
                                      error_description, NSLocalizedDescriptionKey, nil];
            
            NSString *SDKErrorDomain;
            if(shareTarget == KRShareTargetSinablog)
            {
                SDKErrorDomain = kSinaWeiboSDKErrorDomain;
            }
            else if(shareTarget == KRShareTargetTencentblog)
            {
                SDKErrorDomain = kTencentWeiboSDKErrorDomain;
            }
            else if(shareTarget == KRShareTargetDoubanblog)
            {
                SDKErrorDomain = kDoubanBroadSDKErrorDomain;
            }
            else
            {
                SDKErrorDomain = kRenrenBroadSDKErrorDomain;
            }
            
            NSError *error = [NSError errorWithDomain:SDKErrorDomain
                                                 code:[error_code intValue]
                                             userInfo:userInfo];
            [delegate krShare:self logInDidFailWithError:error];
        }
        
    }
}

#pragma mark - Validation

/**
 * @description 判断是否登录
 * @return YES为已登录；NO为未登录
 */
- (BOOL)isLoggedIn
{
    return userID && accessToken && expirationDate;
}

/**
 * @description 判断登录是否过期
 * @return YES为已过期；NO为未为期
 */
- (BOOL)isAuthorizeExpired
{
    NSDate *now = [NSDate date];
    return ([now compare:expirationDate] == NSOrderedDescending);
}


/**
 * @description 判断登录是否有效，当已登录并且登录未过期时为有效状态
 * @return YES为有效；NO为无效
 */
- (BOOL)isAuthValid
{
    return ([self isLoggedIn] && ![self isAuthorizeExpired]);
}

#pragma mark - LogIn / LogOut

/**
 * @description 登录入口，当初始化KRShare对象完成后直接调用此方法完成登录
 */
- (void)logIn
{
    if ([self isAuthValid])
    {
        if ([delegate respondsToSelector:@selector(KRShareDidLogIn:)])
        {
            [delegate KRShareDidLogIn:self];
        }
    }
    else
    {
        ssoLoggingIn = NO;
        
        // open sina weibo app
        UIDevice *device = [UIDevice currentDevice];
        if ([device respondsToSelector:@selector(isMultitaskingSupported)] &&
            [device isMultitaskingSupported])
        {
            NSDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    self.appKey, @"client_id",
                                    self.appRedirectURI, @"redirect_uri",
                                    self.ssoCallbackScheme, @"callback_uri", nil];
            
            // 先用iPad微博打开
            NSString *appAuthBaseURL = kSinaWeiboAppAuthURL_iPad;
            if (KRShareIsDeviceIPad())
            {
                NSString *appAuthURL = [KRShareRequest serializeURL:appAuthBaseURL
                                                               params:params httpMethod:@"GET"];
                ssoLoggingIn = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appAuthURL]];
            }
            
            // 在用iPhone微博打开
            if (!ssoLoggingIn)
            {
                appAuthBaseURL = kSinaWeiboAppAuthURL_iPhone;
                NSString *appAuthURL = [KRShareRequest serializeURL:appAuthBaseURL
                                                               params:params httpMethod:@"GET"];
                ssoLoggingIn = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appAuthURL]];
            }
        }
        
        if (!ssoLoggingIn)
        {
            // open authorize view
            
            NSDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    self.appKey, @"client_id",
                                    @"code", @"response_type",
                                    self.appRedirectURI, @"redirect_uri",
                                    @"mobile", @"display", nil];
            
            KRShareAuthorizeView *authorizeView = [[KRShareAuthorizeView alloc] initWithAuthParams:params
                delegate:self];
            [authorizeView show];
            [authorizeView release];
        }
    }
}

/**
 * @description 退出方法，需要退出时直接调用此方法
 */
- (void)logOut
{
    [self removeAuthData];
    
    if ([delegate respondsToSelector:@selector(KRShareDidLogOut:)])
    {
        [delegate KRShareDidLogOut:self];
    }
}

#pragma mark - Send request with token

/**
 * @description 微博API的请求接口，方法中自动完成token信息的拼接
 * @param url: 请求的接口
 * @param params: 请求的参数，如发微博所带的文字内容等
 * @param httpMethod: http类型，GET或POST
 * @param _delegate: 处理请求结果的回调的对象，KRShareRequestDelegate类
 * @return 完成实际请求操作的KRShareRequest对象
 */

- (KRShareRequest *)requestWithURL:(NSString *)url
                              params:(NSMutableDictionary *)params
                          httpMethod:(NSString *)httpMethod
                            delegate:(id<KRShareRequestDelegate>)_delegate
{
    if (params == nil)
    {
        params = [NSMutableDictionary dictionary];
    }
    
    if ([self isAuthValid])
    {
        
        [params setValue:self.accessToken forKey:@"access_token"];
            
        
        NSString *SDKDomain;
        if(shareTarget == KRShareTargetSinablog)
        {
            SDKDomain = kSinaWeiboSDKAPIDomain;
        }
        else if(shareTarget == KRShareTargetTencentblog)
        {
            SDKDomain = kTencentWeiboSDKAPIDomain;
        }
        else if(shareTarget == KRShareTargetDoubanblog)
        {
            SDKDomain = kDoubanBroadSDKAPIDomain;
        }
        else
        {
            SDKDomain = kRenrenBroadSDKAPIDomain;
        }

        
        NSString *fullURL = [SDKDomain stringByAppendingString:url];
        
        KRShareRequest *_request = [KRShareRequest requestWithURL:fullURL
                                                           httpMethod:httpMethod
                                                               params:params
                                                             delegate:_delegate];
        _request.krShare = self;
        [requests addObject:_request];
        if([delegate respondsToSelector:@selector(KRShareWillBeginRequest:)])
        {
            [delegate KRShareWillBeginRequest:request];
        }
        [_request connect];
        return _request;
    }
    else
    {
        //notify token expired in next runloop
        [self performSelectorOnMainThread:@selector(notifyTokenExpired:)
                               withObject:_delegate
                            waitUntilDone:NO];
        
        return nil;
    }
}

#pragma mark - KRShareAuthorizeView Delegate

- (void)authorizeView:(KRShareAuthorizeView *)authView didRecieveAuthorizationCode:(NSString *)code
{
    [self requestAccessTokenWithAuthorizationCode:code];
}

- (void)authorizeView:(KRShareAuthorizeView *)authView didFailWithErrorInfo:(NSDictionary *)errorInfo
{
    [self logInDidFailWithErrorInfo:errorInfo];
}

- (void)authorizeViewDidCancel:(KRShareAuthorizeView *)authView
{
    [self logInDidCancel];
}

#pragma mark - KRShareRequest Delegate

- (void)request:(KRShareRequest *)_request didFailWithError:(NSError *)error
{
    if (_request == request)
    {
        if ([delegate respondsToSelector:@selector(krShare:logInDidFailWithError:)])
        {
            [delegate krShare:self logInDidFailWithError:error];
        }
        
        [request release], request = nil;
    }
}

- (void)request:(KRShareRequest *)_request didFinishLoadingWithResult:(id)result
{
    if (_request == request)
    {
        [self logInDidFinishWithAuthInfo:result];
        [request release], request = nil;
    }
}

#pragma mark - Application life cycle

/**
 * @description 当应用从后台唤起时，应调用此方法，需要完成退出当前登录状态的功能
 */
- (void)applicationDidBecomeActive
{
    if (ssoLoggingIn)
    {
        // user open the app manually
        // clean sso login state
        ssoLoggingIn = NO;
        
        if ([delegate respondsToSelector:@selector(KRShareLogInDidCancel:)])
        {
            [delegate KRShareLogInDidCancel:self];
        }
    }
}

/**
 * @description sso回调方法，官方客户端完成sso授权后，回调唤起应用，应用中应调用此方法完成sso登录
 * @param url: 官方客户端回调给应用时传回的参数，包含认证信息等
 * @return YES
 */
- (BOOL)handleOpenURL:(NSURL *)url
{
    NSString *urlString = [url absoluteString];
    if ([urlString hasPrefix:self.ssoCallbackScheme])
    {
        if (!ssoLoggingIn)
        {
            // sso callback after user have manually opened the app
            // ignore the request
        }
        else
        {
            ssoLoggingIn = NO;
            
            if ([KRShareRequest getParamValueFromUrl:urlString paramName:@"sso_error_user_cancelled"])
            {
                if ([delegate respondsToSelector:@selector(KRShareLogInDidCancel:)])
                {
                    [delegate KRShareLogInDidCancel:self];
                }
            }
            else if ([KRShareRequest getParamValueFromUrl:urlString paramName:@"sso_error_invalid_params"])
            {
                if ([delegate respondsToSelector:@selector(KRShare:logInDidFailWithError:)])
                {
                    NSString *error_description = @"Invalid sso params";
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                              error_description, NSLocalizedDescriptionKey, nil];
                    NSString *SDKErrorDomain;
                    if(shareTarget == KRShareTargetSinablog)
                    {
                        SDKErrorDomain = kSinaWeiboSDKErrorDomain;
                    }
                    else if(shareTarget == KRShareTargetTencentblog)
                    {
                        SDKErrorDomain = kTencentWeiboSDKErrorDomain;
                    }
                    else if(shareTarget == KRShareTargetDoubanblog)
                    {
                        SDKErrorDomain = kDoubanBroadSDKErrorDomain;
                    }
                    else
                    {
                        SDKErrorDomain = kRenrenBroadSDKErrorDomain;
                    }

                    
                    NSError *error = [NSError errorWithDomain:SDKErrorDomain
                                                         code:kSinaWeiboSDKErrorCodeSSOParamsError
                                                     userInfo:userInfo];
                    [delegate krShare:self logInDidFailWithError:error];
                }
            }
            else if ([KRShareRequest getParamValueFromUrl:urlString paramName:@"error_code"])
            {
                NSString *error_code = [KRShareRequest getParamValueFromUrl:urlString paramName:@"error_code"];
                NSString *error = [KRShareRequest getParamValueFromUrl:urlString paramName:@"error"];
                NSString *error_uri = [KRShareRequest getParamValueFromUrl:urlString paramName:@"error_uri"];
                NSString *error_description = [KRShareRequest getParamValueFromUrl:urlString paramName:@"error_description"];
                
                NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                           error, @"error",
                                           error_uri, @"error_uri",
                                           error_code, @"error_code",
                                           error_description, @"error_description", nil];
                
                [self logInDidFailWithErrorInfo:errorInfo];
            }
            else
            {
                NSString *access_token = [KRShareRequest getParamValueFromUrl:urlString paramName:@"access_token"];
                NSString *expires_in = [KRShareRequest getParamValueFromUrl:urlString paramName:@"expires_in"];
                NSString *remind_in = [KRShareRequest getParamValueFromUrl:urlString paramName:@"remind_in"];
                NSString *uid = [KRShareRequest getParamValueFromUrl:urlString paramName:@"uid"];
                NSString *refresh_token = [KRShareRequest getParamValueFromUrl:urlString paramName:@"refresh_token"];
                
                NSMutableDictionary *authInfo = [NSMutableDictionary dictionary];
                if (access_token) [authInfo setObject:access_token forKey:@"access_token"];
                if (expires_in) [authInfo setObject:expires_in forKey:@"expires_in"];
                if (remind_in) [authInfo setObject:remind_in forKey:@"remind_in"];
                if (refresh_token) [authInfo setObject:refresh_token forKey:@"refresh_token"];
                if (uid) [authInfo setObject:uid forKey:@"uid"];
                
                [self logInDidFinishWithAuthInfo:authInfo];
            }
        }
    }
    return YES;
}

@end


BOOL KRShareIsDeviceIPad()
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return YES;
    }
#endif
    return NO;
}