//
//  myFriendViewController.m
//  szfc
//
//  Created by tao xu on 13-8-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "myFriendViewController.h"
#import "myFriendCell.h"
@interface myFriendViewController ()

@end

@implementation myFriendViewController
@synthesize tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我的好友";
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];  
        backButton.frame = CGRectMake(0.0, 0.0, 36.0, 30.0);  
        [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];  
        [backButton setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted];  
        [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];  
        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
        temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
        self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
        [temporaryBarButtonItem release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
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

- (void)backAction:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES]; 
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myFriendCellIdentifier = @"myFriendCellIdentifier";
    static BOOL nibsRegistered = NO;
    
    if (!nibsRegistered) {
        
        UINib *nib = [UINib nibWithNibName:@"myFriendCell" bundle:nil];
        
        [self.tableView registerNib:nib forCellReuseIdentifier:myFriendCellIdentifier];
        
        nibsRegistered = YES;
        
    }
    myFriendCell *cell = (myFriendCell *)[self.tableView dequeueReusableCellWithIdentifier:myFriendCellIdentifier];
    if (cell==nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"myFriendCell" owner:self options:nil]lastObject];
        
    }
    UIButton *button = [ UIButton buttonWithType:UIButtonTypeCustom ];
    CGRect frame = CGRectMake( 0.0 , 0.0 ,65, 20 );
    
    button. frame = frame;
    //    [button addTarget:self action:@selector(showPopover:)forControlEvents:UIControlEventTouchUpInside]; 
    [button setImage:[UIImage imageNamed:@"cancel_foucs.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"cancel_foucs_hover.png"] forState:UIControlStateHighlighted];
    //    [button addTarget:self action:@selector(showPopover:)forControlEvents:UIControlEventTouchUpInside]; 
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
    button.center=view.center;
    [view addSubview:button];
    cell. accessoryView = view;
    
    return cell;
    
    
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    return 60;
    
} 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
