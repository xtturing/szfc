//
//  hotTableViewController.m
//  房伴
//
//  Created by tao xu on 13-8-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "hotTableViewController.h"
#import "friendMessageCell.h"
#import "recommendCell.h"
#import "friendMessageViewController.h"
#import "writeMessageViewController.h"
#import "info.h"
#import "infoDetail.h"
@interface hotTableViewController ()

@end

@implementation hotTableViewController
@synthesize tableView,userCode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        PageSize=10;
        dataManager=[[dataHttpManager alloc] initWithDelegate];
        dataManager.delegate=self;
        [dataManager start];
        [dataManager logIn];
        [self.tableView reloadData];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    
}
-(void)viewDidAppear:(BOOL)animated{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];   
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
    userCode=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc{
    [super dealloc];
    [userCode release];
    [tableView release];
}
-(void)didGetAuthInfo:(NSString *)code userName:(NSString *)userName nikeName:(NSString *)nikeName phone:(NSString *)phone photo:(NSString *)photo{
    self.userCode=code;
    [dataManager getInfoList:1 size:PageSize user:self.userCode];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ([friendMessageList count]+1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return 1;
    }else {
        return 2;
    }
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *recommendCellIdentifier = @"recommendCellIdentifier";
        static BOOL nibsRegistered = NO;
        
        if (!nibsRegistered) {
            
            UINib *nib = [UINib nibWithNibName:@"recommendCell" bundle:nil];
            
            [self.tableView registerNib:nib forCellReuseIdentifier:recommendCellIdentifier];
            
            nibsRegistered = YES;
            
        }
        recommendCell *cell = (recommendCell *)[self.tableView dequeueReusableCellWithIdentifier:recommendCellIdentifier];
        if (cell==nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"recommendCell" owner:self options:nil]lastObject];
            
        }
        
        
        return cell; 
    }else {
        
        info *i=[friendMessageList objectAtIndex:(indexPath.section-1)];
        if(indexPath.row==0){
            static NSString *friendMessageCellIdentifier = @"friendMessageCellIdentifier";
            static BOOL nibsRegistered = NO;
            
            if (!nibsRegistered) {
                
                UINib *nib = [UINib nibWithNibName:@"friendMessageCell" bundle:nil];
                
                [self.tableView registerNib:nib forCellReuseIdentifier:friendMessageCellIdentifier];
                
                nibsRegistered = YES;
                
            }
            friendMessageCell *cell = (friendMessageCell *)[self.tableView dequeueReusableCellWithIdentifier:friendMessageCellIdentifier];
            if (cell==nil) {
                
                cell = [[[NSBundle mainBundle] loadNibNamed:@"friendMessageCell" owner:self options:nil]lastObject];
                
            }
            cell.InfoIntrText=i.InfoIntr;        
            cell.AddTimeText=i.AddTime;
            cell.NickNameText=i.NickName;
            cell.UserLdpiPhotoUrl=i.UserLdpiPhoto;
            return cell; 

        }else {
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
            cell.CommentNumText=[NSString stringWithFormat:@"%@",i.CommentNum];
            cell.TransmitNumText=[NSString stringWithFormat:@"%@",i.TransmitNum];
            cell.PraiseNumText=[NSString stringWithFormat:@"%@",i.PraiseNum];
            return cell;

        }
    }
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    if (indexPath.section==0) {
        return 80;
    }else {
        if(indexPath.row==0){
            return 110;
        }else {
            return 30;
        }
        
    }
    
    
} 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        
    }else {
        info *i=[friendMessageList objectAtIndex:(indexPath.section-1)];
        infoDetail *info=[dataManager getInfoDetail:i.Id user:userCode];
        if(info){
            friendMessageViewController *message=[[friendMessageViewController alloc] initWithInfoDetail:info];
            [self.parentViewController.navigationController pushViewController:message animated:YES];
        }
        
    }
}
-(void)SetParentView:(UIViewController *)viewController{
    
    [self setParentViewController:viewController];
    
}
//评论
-(void)didComment:(buttonCell *)commentCell indexPath:(NSIndexPath *)indexPath{
    info *i=[friendMessageList objectAtIndex:(indexPath.section-1)];
    writeMessageViewController *write=[[writeMessageViewController alloc] initWithSendReply:i.NickName atUser:@"" infoCode:i.Code type:0];
    [self.parentViewController.navigationController  pushViewController:write animated:YES];
}
//转发
-(void)didPraise:(buttonCell *)commentCell indexPath:(NSIndexPath *)indexPath{

}
//赞
-(void)didReply:(buttonCell *)commentCell indexPath:(NSIndexPath *)indexPath{
    
}
-(void)didGetInfoList:(NSArray *)infoList Total:(int)Total{
    friendMessageList=infoList;
    TotalSize=Total;
    [self.tableView reloadData];
}
- (void)refresh {
    if(PageSize+10>TotalSize){
       PageSize=TotalSize;
    }else {                
       PageSize=PageSize+10;
    }
     [dataManager logIn];
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
}

- (void)addItem{
    // Add a new time
    
    //没有更多内容了
    //    self.hasMore = NO;
   
    [self stopLoading];
}


@end
