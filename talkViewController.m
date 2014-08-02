//
//  talkViewController.m
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "talkViewController.h"
#import "talkCell.h"
#import "message.h"
#import "talkDetailViewController.h"
@interface talkViewController ()

@end

@implementation talkViewController
@synthesize tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        PageSize=10;
        dataManager=[[dataHttpManager alloc] initWithDelegate];
        dataManager.delegate=self;
        [dataManager start];
        [dataManager getMsgList:1 size:PageSize type:@"2002" user:@"" code:@""];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title=@"每日一说";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];  
    backButton.frame = CGRectMake(0.0, 0.0, 36.0, 30.0);  
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];  
    [backButton setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted];  
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
    [temporaryBarButtonItem release];
    
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
    mssageList=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc{
    [super dealloc];
    [tableView release];
    [mssageList release];
}
- (void)backAction:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES]; 
}
-(void)didGetMsgList:(NSArray *)msgList Total:(int)Total{
    mssageList=[msgList retain];
    TotalSize=Total;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [mssageList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    message *m=[mssageList objectAtIndex:indexPath.section];
    static NSString *talkCellIdentifier = @"talkCellIdentifier";
    static BOOL nibsRegistered = NO;
    
    if (!nibsRegistered) {
        
        UINib *nib = [UINib nibWithNibName:@"talkCell" bundle:nil];
        
        [self.tableView registerNib:nib forCellReuseIdentifier:talkCellIdentifier];
        
        nibsRegistered = YES;
        
    }
    talkCell *cell = (talkCell *)[self.tableView dequeueReusableCellWithIdentifier:talkCellIdentifier];
    if (cell==nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"talkCell" owner:self options:nil]lastObject];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.MsgIntrText=m.MsgIntr;
    cell.MsgHdpiPhotoUrl=m.MsgHdpiPhoto;
    return cell; 
    
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    return 150;
    
} 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    message *m=[mssageList objectAtIndex:indexPath.section];
    messageDetail *detail=[dataManager getMessageDetail:m.Id  user:@""];
    if(detail){
        talkDetailViewController *talk=[[talkDetailViewController alloc] initWithMsgDetail:detail];
        [self.navigationController pushViewController:talk animated:YES];
    }    
}
-(UIView *)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    message *m=[mssageList objectAtIndex:section];
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeCustom];  
    backButton.frame = CGRectMake(self.tableView.center.x-58, 5.0, 115.0, 20.0);  
    [backButton setBackgroundImage:[UIImage imageNamed:@"bg1.png"] forState:UIControlStateNormal];  
    [backButton setFont:[UIFont systemFontOfSize:12]]; 
    [backButton setTitle:m.AddTime forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIView *sectionview=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width,30)]autorelease];
    [sectionview addSubview:backButton];
    return sectionview;
}
- (void)refresh {
    if(PageSize+10>TotalSize){
        PageSize=TotalSize;
    }else {                
        PageSize=PageSize+10;
    }
    [dataManager getMsgList:1 size:PageSize type:@"2002" user:@"" code:@""];
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
}

- (void)addItem{
    // Add a new time
    
    //没有更多内容了
    //    self.hasMore = NO;
    
   
    
    [self stopLoading];
}
@end
