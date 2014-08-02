//
//  centreViewController.h
//  szfc
//
//  Created by tao xu on 13-7-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "dataHttpManager.h"
@interface centreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate,dataHttpDelegate>{
    UITableView *tableView;
    UIView *loadingView;
    UIView *loginView;
    BOOL _isFeedbackSent;
    dataHttpManager *dataManager;    
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;
@property (nonatomic,retain) IBOutlet UIView *loadingView;
@property (nonatomic,retain) IBOutlet UIView *loginView;
@property (nonatomic,retain) IBOutlet UIImageView *headerImage;
@property (nonatomic,retain) IBOutlet UILabel *userName;
@property (nonatomic,retain) IBOutlet UILabel *logNumber;
@property (nonatomic,retain) IBOutlet UILabel *funNumber;
@property (nonatomic,retain) IBOutlet UILabel *collectNumber;
@property (retain, nonatomic) NSArray *toRecipients;
@property (retain, nonatomic) NSArray *ccRecipients;
@property (retain, nonatomic) NSArray *bccRecipients;

+ (BOOL)isAvailable;
-(IBAction)login:(id)sender;
-(IBAction)registerUser:(id)sender;
-(IBAction)fun:(id)sender;
-(IBAction)message:(id)sender;
-(IBAction)collect:(id)sender;
@end
