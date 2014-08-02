//
//  messageDetailViewController.m
//  szfc
//
//  Created by tao xu on 13-8-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "messageDetailViewController.h"
#import "shareViewController.h"
#import "loginViewController.h"
#import "commentView.h"
#import "commentCell.h"
@interface messageDetailViewController ()

@end

@implementation messageDetailViewController
@synthesize tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"官方消息";
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
    [button setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];  
    [button setImage:[UIImage imageNamed:@"more_hover.png"] forState:UIControlStateHighlighted];  
    [button addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];  
    addBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.rightBarButtonItem=addBarButtonItem;  
    [addBarButtonItem release];
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
- (void)commentAction:(id)sender {  
    CGFloat xWidth = self.view.bounds.size.width - 40.0f;
    CGFloat yHeight = self.view.bounds.size.height-100.0f;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    commentView *comment = [[commentView alloc] initWithFrame:CGRectMake(20, yOffset, xWidth, yHeight)];
    comment.autoresizesSubviews=YES;
    [comment show];
    [comment release];
}
- (void)moreAction:(id)sender {  
    // 创建时仅指定取消按钮
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@""  delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil];
    
    // 逐个添加按钮（比如可以是数组循环）
    [sheet addButtonWithTitle:@"公开到动态"];
    [sheet addButtonWithTitle:@"分享到新浪微博"];
    [sheet addButtonWithTitle:@"删除"];
    [sheet addButtonWithTitle:@"取消"];
    // 将取消按钮的index设置成我们刚添加的那个按钮，这样在delegate中就可以知道是那个按钮
    // NB - 这会导致该按钮显示时有黑色背景
    sheet.cancelButtonIndex = sheet.numberOfButtons-1; 
    sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [sheet showFromRect:self.view.bounds inView:self.view.window animated:YES];
    [sheet release]; 
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex)
    { return; }
    switch (buttonIndex)
    {
        case 0: {
//            if(![dataManager logIn]){
//                loginViewController *login=[[loginViewController alloc] initIsLogin:YES];
//                [self presentModalViewController:login animated:YES];
//            }
            break;
        }
        case 1: {
            shareViewController *share=[[shareViewController alloc] initWithNibName:@"shareViewController" bundle:nil];
            [self.navigationController pushViewController:share animated:YES];
            break;
        }
        case 2: {
            NSLog(@"Item C Selected");
            break;
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row<3){
        static NSString *reuseIdetify = @"SvTableViewCell";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if(indexPath.row==0){
            
            UIFont *font = [UIFont systemFontOfSize:14]; 
            cell.textLabel.font=font;
            cell.textLabel.textAlignment=UITextAlignmentLeft;
            cell.textLabel.numberOfLines = 0; 
            cell.textLabel.opaque=NO;
            cell.textLabel.text =@"    中海8号公馆，76平米样板房全新上市，最高1万抵4万，稀缺房源，抢购从速";        
            
        }else if (indexPath.row==1) {
            CGRect frame = CGRectMake( cell.center.x-150 , cell.center.y-80 ,320, 160 );
            UIImageView *view=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"21.jpg"]];
            view.frame=frame;
            cell. accessoryView = view;
        }else{
            UIFont *font = [UIFont systemFontOfSize:12]; 
            cell.textLabel.font=font;
            cell.textLabel.textColor=[UIColor darkGrayColor];
            cell.textLabel.textAlignment=UITextAlignmentLeft;
            cell.textLabel.numberOfLines = 0; 
            cell.textLabel.opaque=NO;
            cell.textLabel.text =@"    中海8号公馆，76平米样板房全新上市，最高1万抵4万，稀缺房源，抢购从速,中海8号公馆，76平米样板房全新上市，最高1万抵4万，稀缺房源，抢购从速,中海8号公馆，76平米样板房全新上市，最高1万抵4万，稀缺房源，抢购从速,中海8号公馆，76平米样板房全新上市，最高1万抵4万，稀缺房源，抢购从速"; 
        }
        return cell;
    }else {
        static NSString *commentCellIdentifier = @"commentCellIdentifier";
        static BOOL nibsRegistered = NO;
        
        if (!nibsRegistered) {
            
            UINib *nib = [UINib nibWithNibName:@"commentCell" bundle:nil];
            
            [self.tableView registerNib:nib forCellReuseIdentifier:commentCellIdentifier];
            
            nibsRegistered = YES;
            
        }
        commentCell *cell = (commentCell *)[self.tableView dequeueReusableCellWithIdentifier:commentCellIdentifier];
        if (cell==nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"commentCell" owner:self options:nil]lastObject];
            
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell; 
    }
    
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    if(indexPath.row==0){
        return 60;
    }else if (indexPath.row==1) {
        return 160;
    }else if (indexPath.row==2) {
        return 120;
    }else {
        return 60;
    }
    
} 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
