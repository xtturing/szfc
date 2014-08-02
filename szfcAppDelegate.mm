//
//  szfcAppDelegate.m
//  szfc
//
//  Created by tao xu on 13-7-22.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "szfcAppDelegate.h"
#import "searchViewController.h"
#import "collectViewController.h"
#import "centreViewController.h"
@implementation szfcAppDelegate
@synthesize window;
@synthesize tabBarController;
@synthesize splashViewController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{ 
    NSTimer *timer;
    UIImage *d=nil;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad){
        d=[UIImage imageNamed:@"启动页1024.png"];
        
    }else {
        if([[UIScreen mainScreen] bounds].size.height==568){
            d=[UIImage imageNamed:@"启动页568.png"];
        }else{
            d=[UIImage imageNamed:@"启动页480.png"];
        }
        
        
    }
    CGSize size = CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    if (UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    [d drawInRect:CGRectMake(0.0f, 0.0f,[[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    splashViewController=[[UIImageView alloc]initWithImage:image];//这里logo是你的启动图片    
    [self.window addSubview:splashViewController];
    //添加其他操作
    [splashViewController release];
    timer=[NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(logo) userInfo:nil repeats:NO];
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)logo
{
    //添加你的控制代码
    [splashViewController removeFromSuperview];
    [[UIApplication sharedApplication] setStatusBarHidden:NO]; 
    [self.tabBarController setSelectedIndex:1];
    [self.tabBarController addCenterButtonWithImage:[UIImage imageNamed:@"redian.png"] highlightImage:[UIImage imageNamed:@"redian_hover.png"] index:0];
    [self.tabBarController addCenterButtonWithImage:[UIImage imageNamed:@"search.png"] highlightImage:[UIImage imageNamed:@"search_hover.png"] index:1];
    [self.tabBarController addCenterButtonWithImage:[UIImage imageNamed:@"collect.png"] highlightImage:[UIImage imageNamed:@"collect_hover.png"] index:2];
    [self.tabBarController addCenterButtonWithImage:[UIImage imageNamed:@"set.png"] highlightImage:[UIImage imageNamed:@"set_hover.png"] index:3];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.tabBarController;
    //加载新的视图
}

- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}
@end
