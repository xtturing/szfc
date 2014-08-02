//
//  centreViewController.m
//  szfc
//
//  Created by tao xu on 13-7-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "centreViewController.h"
#import "addFriendViewController.h"
#import "myFriendViewController.h"
#import "personViewController.h"
#import "aboutViewController.h"
#import "funViewController.h"
#import "loginViewController.h"
#import "erweiView.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
@interface centreViewController (private)
- (NSString *) _platform;
- (NSString *) _platformString;
- (NSString*)_feedbackSubject;
- (NSString*)_feedbackBody;
- (NSString*)_appName;
- (NSString*)_appVersion;
- (NSString*)_selectedTopic;
- (NSString*)_selectedTopicToSend;

@end

@implementation centreViewController
@synthesize tableView,loadingView,loginView,headerImage,funNumber,logNumber,collectNumber,userName;
@synthesize toRecipients;
@synthesize ccRecipients;
@synthesize bccRecipients;

+ (BOOL)isAvailable
{
    if([MFMailComposeViewController class]){
        return YES;
    }
    return NO;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    dataManager=[[dataHttpManager alloc] initWithDelegate];
    dataManager.delegate=self;
    [dataManager start];
    [self viewHidden];
    [self.tableView reloadData];
}
-(void)viewHidden{
    if(![dataManager logIn]){
        self.loginView.hidden=NO;
        self.loadingView.hidden=YES;
    }else {
        self.loginView.hidden=YES;
        self.loadingView.hidden=NO;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *backButton =
    [UIButton buttonWithType:UIButtonTypeCustom];  
    backButton.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);  
    [backButton setImage:[UIImage imageNamed:@"20130805070003418_easyicon_net_118.png"] forState:UIControlStateNormal];  
    [backButton setImage:[UIImage imageNamed:@"20130805070003418_easyicon_net_118.png"] forState:UIControlStateSelected];  
    [backButton addTarget:self action:@selector(erweiAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
    [temporaryBarButtonItem release];
    UIButton *addButton =
    [UIButton buttonWithType:UIButtonTypeCustom];  
    addButton.frame = CGRectMake(0.0, 0.0, 35.0, 30.0); 
    [addButton setImage:[UIImage imageNamed:@"friend.png"] forState:UIControlStateNormal];  
     [addButton setImage:[UIImage imageNamed:@"friend_hover.png"] forState:UIControlStateHighlighted]; 
    [addButton addTarget:self action:@selector(addFriend:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];  
    addBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.rightBarButtonItem=addBarButtonItem;  
    [addBarButtonItem release];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xf0f1f4];
    self.toRecipients = [NSArray arrayWithObject:@"xtturing@gmail.com"];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    tableView.delegate = nil;
    tableView.dataSource = nil;
    tableView=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(_isFeedbackSent){
        [self dismissModalViewControllerAnimated:YES];
    }
}
- (void)dealloc {
    
    self.toRecipients = nil;
    self.ccRecipients = nil;
    self.bccRecipients = nil;
    [super dealloc];
}
-(void)isLogin:(BOOL)is{
    loginViewController *login=[[loginViewController alloc] initIsLogin:is];
    [self presentModalViewController:login animated:YES];
}
//登陆
-(IBAction)login:(id)sender {
    [self isLogin:YES];
}
-(IBAction)registerUser:(id)sender{
    [self isLogin:NO];
}
-(void)logOut{
    [dataManager logOut];
    [self viewHidden]; 
    [self.tableView reloadData];
}
//二维码
- (void)erweiAction:(id)sender {  
    erweiView *erwei = [[erweiView alloc] initWithFrame:CGRectMake(self.view.center.x-100, self.view.center.y-100, 200, 200)];
    erwei.autoresizesSubviews=YES;
    [erwei show];
    [erwei release];
    
}
-(IBAction)fun:(id)sender{
    funViewController *fun=[[funViewController alloc] initWithNibName:@"funViewController" bundle:nil];
    [self.navigationController pushViewController:fun animated:YES]; 
}
-(IBAction)message:(id)sender{

}
-(IBAction)collect:(id)sender{
    
}
- (void)addFriend:(id)sender { 
    if([dataManager logIn]){
        addFriendViewController *add=[[addFriendViewController alloc] initWithNibName:@"addFriendViewController" bundle:nil];
        [self.navigationController pushViewController:add animated:YES]; 
    }else {
        [self isLogin:YES];
    }    
}
-(void)didGetAuthInfo:(NSString *)code userName:(NSString *)userName nikeName:(NSString *)nikeName phone:(NSString *)phone photo:(NSString *)photo{
    self.userName.text=nikeName;
    CALayer * layer = [self.headerImage layer];  
    [layer setMasksToBounds:YES];  
    [layer setCornerRadius:6.0];  
    [layer setBorderWidth:1.0];  
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    if(photo.length>0){       
       [self.headerImage setImageWithURL:[NSURL URLWithString:photo]];     
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([dataManager logIn]){ 
        return 2;
    }else {
        return 1;
    }

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return 5;
    }else {
        if([dataManager logIn]){ 
             return 1;
        }
       
    }
   
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        static NSString *reuseIdetify = @"SvTableViewCell";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UIFont *font = [UIFont systemFontOfSize:14]; 
        cell.textLabel.font=font;
        if(indexPath.row==3){
            cell.textLabel.text =@"推送设置";
            UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            [switchview addTarget:self action:@selector(updateSwitchAtIndexPath:) forControlEvents:UIControlEventValueChanged];
            switchview.tag=indexPath.row;
            cell.accessoryView = switchview;
            [switchview release];
        }else {
            if(indexPath.row==0){            
                cell.textLabel.text =@"个人信息";
            }else if(indexPath.row==1){
                cell.textLabel.text =@"我的好友";
            }else if (indexPath.row==2) {
                cell.textLabel.text =@"意见反馈";
            }else if (indexPath.row==4) {
                cell.textLabel.text =@"关于团队";
            }
        }
        
        return cell;
    }else {
        if([dataManager logIn]){          
            static NSString *reuseIdetify = @"TableViewCell";
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdetify];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
            }
            cell.accessoryType=UITableViewCellAccessoryNone;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UIButton *backButton =
            [UIButton buttonWithType:UIButtonTypeCustom];  
            backButton.frame = CGRectMake(0.0, 0.0, 300.0, 37.0);  
            [backButton setBackgroundImage:[UIImage imageNamed:@"out.png"] forState:UIControlStateNormal]; 
            [backButton setBackgroundImage:[UIImage imageNamed:@"out.png"] forState:UIControlStateHighlighted]; 
            [backButton setFont:[UIFont systemFontOfSize:16]];
            [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [backButton setTitleColor:[UIColor colorWithHex:0x6ac627] forState:UIControlStateHighlighted];
            [backButton addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];  
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width-9, 40)];
            backButton.center=view.center;            
            
            [backButton setTitle:@"退出帐号" forState:UIControlStateNormal];
            
            [view addSubview:backButton];
            cell. accessoryView = view;
            return cell;
        }
    }
    
    return nil;        
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    if(indexPath.section==0){
        return 40;
    }else {
        if([dataManager logIn]){ 
            return 30;
        }
        
    }
    
} 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        if(indexPath.row==3){
            UISwitch *switchView=(UISwitch *)cell.accessoryView;
            if(![switchView isOn]){
                [switchView setOn:YES animated:YES];
                
            }else {
                [switchView setOn:NO animated:YES];
                
            }
        }else {
            if (indexPath.row==2) {
                [self nextDidPress];
            }else if (indexPath.row==4) {
                aboutViewController *about=[[aboutViewController alloc] initWithNibName:@"aboutViewController" bundle:nil];
                [self  presentModalViewController:about animated:YES]; 
            }else {
                if([dataManager logIn]){
                    if(indexPath.row==0){    
                        personViewController *person=[[personViewController alloc] initWithNibName:@"personViewController" bundle:nil];
                        [self.navigationController pushViewController:person animated:YES];           
                    }else if(indexPath.row==1){
                        myFriendViewController *my=[[myFriendViewController alloc] initWithNibName:@"myFriendViewController" bundle:nil];
                        [self.navigationController pushViewController:my animated:YES]; 
                    } 
                }else {
                    [self isLogin:YES];
                }
            }
            
        }

    }
        
}
- (IBAction)updateSwitchAtIndexPath:(id)sender {
    UISwitch *switchView = (UISwitch *)sender;
    if([switchView isOn]){
        
    }else {
        
    }
}
- (void)cancelDidPress:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)nextDidPress
{
    //    [_descriptionTextView resignFirstResponder];
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setToRecipients:self.toRecipients];
    [picker setCcRecipients:self.ccRecipients];  
    [picker setBccRecipients:self.bccRecipients];
    
    [picker setSubject:[self _feedbackSubject]];
    [picker setMessageBody:[self _feedbackBody] isHTML:NO];
    [self presentModalViewController:picker animated:YES];
    [picker release];
}


- (void)textViewDidChange:(UITextView *)textView
{
    
    //Magic for updating Cell height
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}


-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if(result==MFMailComposeResultCancelled){
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
        //                                                        message:@"已取消提交邮件发送"
        //                                                       delegate:nil 
        //                                              cancelButtonTitle:nil 
        //                                              otherButtonTitles:@"确定", nil];
        //        [alert show];
        //        [alert release];
    }else if(result==MFMailComposeResultSent){
        _isFeedbackSent = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
                                                        message:@"邮件已提交发送"
                                                       delegate:nil 
                                              cancelButtonTitle:nil 
                                              otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
    }else if(result==MFMailComposeResultFailed){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
                                                        message:@"邮件提交发送失败"
                                                       delegate:nil 
                                              cancelButtonTitle:nil 
                                              otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
    }
    [controller dismissModalViewControllerAnimated:YES]; 
}


#pragma mark - Internal Info

//- (void)_updatePlaceholder
//{
//    if([_descriptionTextView.text length]>0){
//        _descriptionPlaceHolder.hidden = YES;
//    }else{
//        _descriptionPlaceHolder.hidden = NO;
//    }
//}

- (NSString*)_feedbackSubject
{
    return [NSString stringWithFormat:@"%@", [self _selectedTopicToSend], nil];
}

- (NSString*)_feedbackBody
{
    NSString *body = [NSString stringWithFormat:@"%@\n\n\n设备名称:\n%@\n\niOS版本:\n%@\n\n软件名称:\n%@ %@",
                      @"房产搜索iOS版意见反馈：",
                      [self _platformString],
                      [UIDevice currentDevice].systemVersion, 
                      [self _appName],
                      [self _appVersion], nil];
    
    return body;
}

- (NSString*)_selectedTopic
{
    return @"房产搜索iOS版意见反馈";
}

- (NSString*)_selectedTopicToSend
{
    return @"房产搜索iOS版意见反馈";
}

- (NSString*)_appName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:
            @"CFBundleDisplayName"];
}

- (NSString*)_appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

// Codes are from 
// http://stackoverflow.com/questions/448162/determine-device-iphone-ipod-touch-with-iphone-sdk
// Thanks for sss and UIBuilder
- (NSString *) _platform
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    return platform;
}

- (NSString *) _platformString
{
    NSString *platform = [self _platform];
    // NSLog(@"%@",platform);
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

@end
