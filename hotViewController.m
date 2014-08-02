//
//  hotViewController.m
//  szfc
//
//  Created by tao xu on 13-7-31.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "hotViewController.h"
#import "everyTalkCell.h"

#import "loginViewController.h"
#import "talkViewController.h"
#import "recommendViewController.h"
#import "hotTableViewController.h"
#import "realTimeMessageViewController.h"
#import "writeMessageViewController.h"
@interface hotViewController ()

@end

@implementation hotViewController
@synthesize everyTalkView,friendMessageView;
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
    if(![dataManager logIn]){
        loginViewController *login=[[loginViewController alloc] initIsLogin:YES];
        [self presentModalViewController:login animated:YES];
    }else {
        hotTableViewController *hot=[[hotTableViewController alloc] initWithNibName:@"hotTableViewController" bundle:nil];
        hot.view.frame=CGRectMake(0.0f,0.0f,friendMessageView.frame.size.width, friendMessageView.frame.size.height);
        [friendMessageView addSubview:hot.view];
        [hot SetParentView:self];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *backButton =
    [UIButton buttonWithType:UIButtonTypeCustom];  
    backButton.frame = CGRectMake(0.0, 0.0, 58.0, 30.0);  
    [backButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];  
    [backButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateHighlighted]; 
    [backButton setFont:[UIFont systemFontOfSize:12]]; 
    [backButton setTitle:@"实时动态" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithHex:0x6ac627] forState:UIControlStateHighlighted];
 
    [backButton addTarget:self action:@selector(messgaeAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
    [temporaryBarButtonItem release];
    UIButton *addButton = 
    [UIButton buttonWithType:UIButtonTypeCustom];  
    addButton.frame = CGRectMake(0.0, 0.0, 35.0, 30.0); 
    [addButton setImage:[UIImage imageNamed:@"publish.png"] forState:UIControlStateNormal];  
    [addButton setImage:[UIImage imageNamed:@"publish_hover.png"] forState:UIControlStateHighlighted];  
    [addButton addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];  
    addBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.rightBarButtonItem=addBarButtonItem;  
    [addBarButtonItem release];
    UITapGestureRecognizer *tapGestureTel = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(everyTalk)]autorelease];
    
    [everyTalkView addGestureRecognizer:tapGestureTel];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    everyTalkView=nil;
    friendMessageView=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc{
    [super dealloc];
    [everyTalkView release];
    [friendMessageView release];
}
- (void)commentAction:(id)sender {  
    writeMessageViewController *write=[[writeMessageViewController alloc] initWithNibName:@"writeMessageViewController" bundle:nil];
    [self.navigationController pushViewController:write animated:YES];
}
- (void)messgaeAction:(id)sender {  
    realTimeMessageViewController *real=[[realTimeMessageViewController alloc] initWithNibName:@"realTimeMessageViewController" bundle:nil];
    [self.navigationController pushViewController:real animated:YES];
}
- (void)valueAction:(id)sender {  
    recommendViewController *recommend=[[recommendViewController alloc] initWithNibName:@"recommendViewController" bundle:nil];
    [self.navigationController pushViewController:recommend animated:YES];
}
-(void)everyTalk{
    talkViewController *talk=[[talkViewController alloc] initWithNibName:@"talkViewController" bundle:nil];
    [self.navigationController pushViewController:talk animated:YES];
}

@end
