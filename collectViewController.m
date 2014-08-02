//
//  collectViewController.m
//  szfc
//
//  Created by tao xu on 13-7-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "collectViewController.h"
#import "collectCell.h"
#import "messageViewController.h"
#import "commentViewController.h"
#import "logViewController.h"
@interface collectViewController ()

@end

@implementation collectViewController
@synthesize tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
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
    [backButton setTitle:@"我的动态" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithHex:0x6ac627] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
    [temporaryBarButtonItem release];
    UIButton *addButton = 
//    [UIButton buttonWithType:UIButtonTypeRoundedRect];  
//    addButton.frame = CGRectMake(0.0, 0.0, 60.0,30.0);  
//    [addButton setTitle:@"我的日志" forState:UIControlStateNormal];
//    addButton.titleLabel.textColor=[UIColor colorWithHex:0x3D89BF];
//    addButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [UIButton buttonWithType:UIButtonTypeCustom];  
    addButton.frame = CGRectMake(0.0, 0.0, 58.0, 30.0);  
    [addButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal]; 
    [addButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateHighlighted]; 
    [addButton setFont:[UIFont systemFontOfSize:12]];
    [addButton setTitle:@"我的日志" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor colorWithHex:0x6ac627] forState:UIControlStateHighlighted];

    [addButton addTarget:self action:@selector(logAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];  
    addBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.rightBarButtonItem=addBarButtonItem;  
    [addBarButtonItem release];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
     self.tableView.backgroundColor = [UIColor colorWithHex:0xf0f1f4];
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

- (void)commentAction:(id)sender {  
    commentViewController *comment=[[commentViewController alloc] initWithNibName:@"commentViewController" bundle:nil];
    [self.navigationController pushViewController:comment animated:YES];
}
- (void)logAction:(id)sender {  
    logViewController *log=[[logViewController alloc] initWithNibName:@"logViewController" bundle:nil];
    [self.navigationController pushViewController:log animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *collectCellIdentifier = @"collectCellIdentifier";
    static BOOL nibsRegistered = NO;
    
    if (!nibsRegistered) {
        
        UINib *nib = [UINib nibWithNibName:@"collectCell" bundle:nil];
        
        [self.tableView registerNib:nib forCellReuseIdentifier:collectCellIdentifier];
        
        nibsRegistered = YES;
        
    }
    collectCell *cell = (collectCell *)[self.tableView dequeueReusableCellWithIdentifier:collectCellIdentifier];
    if (cell==nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"collectCell" owner:self options:nil]lastObject];
        
    }
    
    
    return cell;    
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    return 160;
    
} 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    messageViewController *message=[[messageViewController alloc] initWithNibName:@"messageViewController" bundle:nil];
    [self.navigationController pushViewController:message animated:YES];
    
}


@end
