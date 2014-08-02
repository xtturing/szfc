//
//  friendMessageViewController.m
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "friendMessageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "userCell.h"
#import "reply.h"
#import "replyCell.h"
#import "writeMessageViewController.h"
#import "loginViewController.h"
@interface friendMessageViewController ()

@end

@implementation friendMessageViewController
@synthesize tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithInfoDetail:(infoDetail *)info{
    self = [super initWithNibName:@"friendMessageViewController" bundle:nil];
    if (self) {
        infoD=[info retain];
        PageSize=10;
        dataManager=[[dataHttpManager alloc] initWithDelegate];
        dataManager.delegate=self;
        [dataManager start];        
        [dataManager getReplyList:1 size:PageSize info:infoD.Code];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title=@"动态详情";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];  
    backButton.frame = CGRectMake(0.0, 0.0, 36.0, 30.0);  
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];  
    [backButton setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted];  
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
    [temporaryBarButtonItem release];
    UIButton *button= 
    [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, 36.0,30.0); 
    [button setImage:[UIImage imageNamed:@"collect3.png"] forState:UIControlStateNormal];  
    [button setImage:[UIImage imageNamed:@"collect_hover3.png"] forState:UIControlStateHighlighted];  
    [button addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];  
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
    infoD=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc{
    [super dealloc];
    [tableView release];
    [infoD release];
}
- (void)backAction:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES]; 
}
- (void)detailAction:(id)sender {  
    if(![dataManager logIn]){
        loginViewController *login=[[loginViewController alloc] initIsLogin:YES];
        [self presentModalViewController:login animated:YES];
    }
    
}
-(void)didGetAuthInfo:(NSString *)code userName:(NSString *)userName nikeName:(NSString *)nikeName phone:(NSString *)phone photo:(NSString *)photo{
    [dataManager postCollectBuildCode:infoD.Code userCode:code ];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"suckEffect";
    animation.subtype = kCATransitionFromTop;
    [[self.view layer] addAnimation:animation forKey:@"animation"];
}
-(void)didGetReplyList:(NSArray *)replyList Total:(int)Total{
    replyArray=replyList;
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([replyArray count]+4);
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==0){
        static NSString *userCellIdentifier = @"userCellIdentifier";
        static BOOL nibsRegistered = NO;
        
        if (!nibsRegistered) {
            
            UINib *nib = [UINib nibWithNibName:@"userCell" bundle:nil];
            
            [self.tableView registerNib:nib forCellReuseIdentifier:userCellIdentifier];
            
            nibsRegistered = YES;
            
        }
        userCell *cell = (userCell *)[self.tableView dequeueReusableCellWithIdentifier:userCellIdentifier];
        if (cell==nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"userCell" owner:self options:nil]lastObject];
            
        }
        cell.NickNameText=infoD.NickName;
        cell.UserLdpiPhotoUrl=infoD.UserLdpiPhoto;
        cell.AddTimeText=infoD.AddTime;
        UIButton *button = [ UIButton buttonWithType:UIButtonTypeCustom ];
        CGRect frame = CGRectMake( 0.0 , 0.0 ,65, 20 );
        
        button. frame = frame;
        //    [button addTarget:self action:@selector(showPopover:)forControlEvents:UIControlEventTouchUpInside]; 
        [button setImage:[UIImage imageNamed:@"foucs.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"foucs_hover.png"] forState:UIControlStateHighlighted];
        //    [button addTarget:self action:@selector(showPopover:)forControlEvents:UIControlEventTouchUpInside]; 
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
        button.center=view.center;
        [view addSubview:button];
        cell. accessoryView = view;
        return cell;
    }else if (indexPath.row==1||indexPath.row==2) {
        static NSString *reuseIdetify = @"SvTableViewCell";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if(indexPath.row==1){
            UIFont *font = [UIFont systemFontOfSize:12]; 
            cell.textLabel.font=font;
            cell.textLabel.textColor=[UIColor darkGrayColor];
            cell.textLabel.textAlignment=UITextAlignmentLeft;
            cell.textLabel.numberOfLines = 0; 
            cell.textLabel.opaque=NO;
            cell.textLabel.text =infoD.InfoIntr;
        }else {
            CGRect frame = CGRectMake( cell.center.x-150 , cell.center.y-80 ,cell.frame.size.width, 160 );
            UIImageView *view=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"21.jpg"]];
            view.frame=frame;
            cell. accessoryView = view;
        }
        
        return cell;
    }else if (indexPath.row==3) {
        static NSString *buttonCellIdentifier = @"buttonCellIdentifier";
        static BOOL nibsRegistered = NO;
        
        if (!nibsRegistered) {
            
            UINib *nib = [UINib nibWithNibName:@"buttonCell" bundle:nil];
            
            [self.tableView registerNib:nib forCellReuseIdentifier:buttonCellIdentifier];
            
            nibsRegistered = YES;
            
        }
        buttonCell *cell = (buttonCell *)[self.tableView dequeueReusableCellWithIdentifier:buttonCellIdentifier];
        if (cell==nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"buttonCell" owner:self options:nil]lastObject];
            
        }
        cell.delegate=self;
        cell.cellIndexPath=indexPath;
        cell.CommentNumText=[NSString stringWithFormat:@"%@",infoD.CommentNum];
        cell.TransmitNumText=[NSString stringWithFormat:@"%@",infoD.TransmitNum];
        cell.PraiseNumText=[NSString stringWithFormat:@"%@",infoD.PraiseNum];
        return cell;
    }else {
        reply *r=[replyArray objectAtIndex:(indexPath.row-4)];
        static NSString *replyCellIdentifier = @"replyCellIdentifier";
        static BOOL nibsRegistered = NO;
        
        if (!nibsRegistered) {
            
            UINib *nib = [UINib nibWithNibName:@"replyCell" bundle:nil];
            
            [self.tableView registerNib:nib forCellReuseIdentifier:replyCellIdentifier];
            
            nibsRegistered = YES;
            
        }
        replyCell *cell = (replyCell *)[self.tableView dequeueReusableCellWithIdentifier:replyCellIdentifier];
        if (cell==nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"replyCell" owner:self options:nil]lastObject];
            
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.ReplyNickText=r.ReplyNick;
        if([r.IsReply intValue]==0){            
            cell.AtNickText=@"";
        }else {            
            cell.AtNickText=[NSString stringWithFormat:@"回复@%@",r.AtNick];
        }
        cell.ReplyIntrText=r.ReplyIntr;
        cell.AddTimeText=r.AddTime;
        cell.UserLdpiPhotoUrl=r.UserLdpiPhoto;
        return cell; 
            
        
        
    }
    
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    if(indexPath.row==0){
        return 60;
    }else if (indexPath.row==1) {
        return [infoD.InfoIntr length];
    }else if (indexPath.row==2) {
        return 160;
    }else if (indexPath.row==3) {
        return 30;
    }else {
        return 80;
    }
    
} 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row>3){
        reply *r=[replyArray objectAtIndex:(indexPath.row-4)];
        writeMessageViewController *write=[[writeMessageViewController alloc] initWithSendReply:r.ReplyNick atUser:r.AtUser infoCode:infoD.Code type:1];
        [self.navigationController pushViewController:write animated:YES];
    }
}
//评论
-(void)didComment:(buttonCell *)commentCell indexPath:(NSIndexPath *)indexPath{
    writeMessageViewController *write=[[writeMessageViewController alloc] initWithSendReply:infoD.NickName atUser:@"" infoCode:infoD.Code type:0];
    [self.navigationController pushViewController:write animated:YES];
}
//转发
-(void)didPraise:(buttonCell *)commentCell indexPath:(NSIndexPath *)indexPath{
    
}
//赞
-(void)didReply:(buttonCell *)commentCell indexPath:(NSIndexPath *)indexPath{
    
}
- (void)refresh {
    if(PageSize+10>TotalSize){
        PageSize=TotalSize;
    }else {                
        PageSize=PageSize+10;
    }
    [dataManager getReplyList:1 size:PageSize info:infoD.Code];
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
}

- (void)addItem{
    // Add a new time
    
    //没有更多内容了
    //    self.hasMore = NO;
    
    
    [self stopLoading];
}
@end
