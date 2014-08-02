//
//  messageViewController.m
//  szfc
//
//  Created by tao xu on 13-8-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "messageViewController.h"
#import "messageCell.h"
#import "detailsViewController.h"
#import "messageDetailViewController.h"
@interface messageViewController ()

@end

@implementation messageViewController
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
    self.navigationItem.title=@"中海8号公馆";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];  
    backButton.frame = CGRectMake(0.0, 0.0, 36.0, 30.0);  
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];  
    [backButton setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted]; 
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
    [temporaryBarButtonItem release];
    UIButton *addButton = 
    [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0.0, 0.0, 58.0, 30.0);  
    [addButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];  
    [addButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateHighlighted]; 
    [addButton setFont:[UIFont systemFontOfSize:12]];
    [addButton setTitle:@"楼盘详情" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor colorWithHex:0x6ac627] forState:UIControlStateHighlighted];
    [addButton addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];  
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

- (void)backAction:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES]; 
}
- (void)detailAction:(id)sender {  
    detailsViewController *details=[[[detailsViewController alloc] initWithNibName:@"detailsViewController" bundle:nil] autorelease];
    [self  presentModalViewController:details  animated:YES];
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
    static NSString *messageCellIdentifier = @"messageCellIdentifier";
    static BOOL nibsRegistered = NO;
    
    if (!nibsRegistered) {
        
        UINib *nib = [UINib nibWithNibName:@"messageCell" bundle:nil];
        
        [self.tableView registerNib:nib forCellReuseIdentifier:messageCellIdentifier];
        
        nibsRegistered = YES;
        
    }
    messageCell *cell = (messageCell *)[self.tableView dequeueReusableCellWithIdentifier:messageCellIdentifier];
    if (cell==nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"messageCell" owner:self options:nil]lastObject];
        
    }
    
    
    return cell;    
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    return 80;
    
} 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    messageDetailViewController *message=[[messageDetailViewController alloc] initWithNibName:@"messageDetailViewController" bundle:nil];
    [self.navigationController pushViewController:message animated:YES];
}

@end
