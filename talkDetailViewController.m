//
//  talkDetailViewController.m
//  房伴
//
//  Created by tao xu on 13-8-26.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "talkDetailViewController.h"
#import "shareViewController.h"
#import "loginViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface talkDetailViewController ()

@end

@implementation talkDetailViewController
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithMsgDetail:(messageDetail *)msg{
    self = [super initWithNibName:@"talkDetailViewController" bundle:nil];
    if (self) {
        // Custom initialization
        msgDetail=[msg retain];
        dataManager=[[dataHttpManager alloc] initWithDelegate];
        dataManager.delegate=self;
        [dataManager start];
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
    self.tableView.backgroundColor = [UIColor colorWithHex:0xf0f1f4];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    tableView.delegate = nil;
    tableView.dataSource = nil;
    tableView=nil;
    msgDetail=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc{
    [super dealloc];
    [tableView release];
    [msgDetail release];
}
- (void)backAction:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES]; 
}
- (void)moreAction:(id)sender {  
    // 创建时仅指定取消按钮
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@""  delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil];
    
    // 逐个添加按钮（比如可以是数组循环）
    [sheet addButtonWithTitle:@"收藏"];
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
            if(![dataManager logIn]){
                loginViewController *login=[[loginViewController alloc] initIsLogin:YES];
                [self presentModalViewController:login animated:YES];
            }
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
-(void)didGetAuthInfo:(NSString *)code userName:(NSString *)userName nikeName:(NSString *)nikeName phone:(NSString *)phone photo:(NSString *)photo{
    [dataManager postCollectBuildCode:msgDetail.Code userCode:code ];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"suckEffect";
    animation.subtype = kCATransitionFromTop;
    [[self.view layer] addAnimation:animation forKey:@"animation"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"SvTableViewCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if(indexPath.row==0){
        CGRect frame = CGRectMake( cell.center.x-145 , cell.center.y-75 ,cell.frame.size.width-30, 150 );
        UIImageView *view=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"21.jpg"]];
        view.frame=frame;
        cell. accessoryView = view;        
    }else {
        UIFont *font = [UIFont systemFontOfSize:12]; 
        cell.textLabel.font=font;
        cell.textLabel.textColor=[UIColor darkGrayColor];
        cell.textLabel.textAlignment=UITextAlignmentLeft;
        cell.textLabel.numberOfLines = 0; 
        cell.textLabel.opaque=NO;
        cell.textLabel.text =msgDetail.MsgIntr;
    }
    
    return cell;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    if(indexPath.row==0){
        return 160;
    }else {
        return [msgDetail.MsgIntr length];
    }
    
} 
-(UIView *)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeCustom];  
    backButton.frame = CGRectMake(self.tableView.center.x-58, 5.0, 115.0, 20.0);  
    [backButton setBackgroundImage:[UIImage imageNamed:@"bg1.png"] forState:UIControlStateNormal];  
    [backButton setFont:[UIFont systemFontOfSize:12]]; 
    [backButton setTitle:msgDetail.AddTime forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIView *sectionview=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width,30)]autorelease];
    [sectionview addSubview:backButton];
    return sectionview;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
