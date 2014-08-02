//
//  loginViewController.h
//  房伴
//
//  Created by tao xu on 13-8-29.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dataHttpManager.h"
@interface loginViewController : UIViewController<dataHttpDelegate>{
    NSMutableArray *_currentAccounts;
    dataHttpManager *dataManager;
    BOOL isLogin;
}
@property (retain, nonatomic) IBOutlet UIButton *dropButton;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (retain, nonatomic) IBOutlet UIButton *registerButton;
@property (retain, nonatomic) IBOutlet UIView *moveDownGroup;
@property (retain, nonatomic) IBOutlet UIView *account_box;
@property (retain, nonatomic) IBOutlet UITextField *userNumber;
@property (retain, nonatomic) IBOutlet UILabel *numberLabel;
@property (retain, nonatomic) IBOutlet UITextField *userPassword;
@property (retain, nonatomic) IBOutlet UILabel *passwordLabel;
@property (retain, nonatomic) IBOutlet UIImageView *userLargeHead;
@property (retain, nonatomic) IBOutlet UIView *userLargeHeadView;
- (IBAction)login:(id)sender;
- (IBAction)dropDown:(id)sender;
- (IBAction)backAction:(id)sender;
-(IBAction)registerUser:(id)sender;
-(IBAction)findPassword:(id)sender;
-(id)initIsLogin:(BOOL)isLog;
@end
