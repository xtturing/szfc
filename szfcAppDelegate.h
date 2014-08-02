//
//  szfcAppDelegate.h
//  szfc
//
//  Created by tao xu on 13-7-22.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface szfcAppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic,strong) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BaseViewController *tabBarController;
@property (nonatomic,retain) UIImageView *splashViewController;

@end
