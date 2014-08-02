//
//  commentViewController.m
//  szfc
//
//  Created by tao xu on 13-8-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "commentViewController.h"
#import "commentCell.h"
#import <QuartzCore/QuartzCore.h>
@interface commentViewController ()

@end

@implementation commentViewController
@synthesize tableView,collectArray,commetMyArray,myCommetArray;
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
    collectArray=[[NSArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    myCommetArray=[[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"3", nil];
    commetMyArray=[[NSArray alloc] initWithObjects:@"1", nil];
    self.navigationItem.title=@"我的动态";
    UIButton *backButton =
    [UIButton buttonWithType:UIButtonTypeCustom];  
    backButton.frame = CGRectMake(0.0, 0.0, 58.0, 30.0);  
    [backButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal]; 
    [backButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateHighlighted]; 
    [backButton setFont:[UIFont systemFontOfSize:12]];
    [backButton setTitle:@"楼盘收藏" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithHex:0x6ac627] forState:UIControlStateHighlighted];
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)backAction:(id)sender {  
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"cube";
    animation.subtype = kCATransitionFromRight;
   [[self.navigationController.view layer] addAnimation:animation forKey:@"animation"];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)detailAction:(id)sender {  
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"cube";
    animation.subtype = kCATransitionFromRight;
    [[self.view layer] addAnimation:animation forKey:@"animation"];

    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        if(collectArray.count>2){
            return 4;
        }else {
            return (collectArray.count+1);
        }
    }else if (section==1) {
        if(myCommetArray.count>2){
            return 4;
        }else {
            return (myCommetArray.count+1);
        }
    }else {
        if(commetMyArray.count>2){
            return 4;
        }else {
            return (commetMyArray.count+1);
        }
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0||indexPath.row==3){
        static NSString *reuseIdetify = @"SvTableViewCell";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UIFont *font = [UIFont systemFontOfSize:12]; 
        cell.textLabel.font=font;
        cell.textLabel.textColor=[UIColor darkGrayColor];
        cell.textLabel.textAlignment=UITextAlignmentLeft;
        cell.textLabel.numberOfLines = 0; 
        cell.textLabel.opaque=NO;
        cell.backgroundColor=[UIColor whiteColor];
        if(indexPath.row==0){
            if(indexPath.section==0){
              cell.textLabel.text =[NSString stringWithFormat:@"我收藏的(%d)",collectArray.count];  
            }else if (indexPath.section==1) {
              cell.textLabel.text =[NSString stringWithFormat:@"我评论的(%d)",myCommetArray.count];
            }else {
               cell.textLabel.text =[NSString stringWithFormat:@"评论我的(%d)",commetMyArray.count];
            }
             cell.accessoryType=UITableViewCellAccessoryNone;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;      
        }else {
            cell.textLabel.textColor=[UIColor darkTextColor];
            cell.textLabel.textAlignment=UITextAlignmentCenter;
            cell.textLabel.text =@"查看更多";
            cell.selectionStyle=UITableViewCellSelectionStyleGray;  
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
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
        return 30;
    }else {
        if(indexPath.section==0){
            if(collectArray.count>2){
                if(indexPath.row==3){
                    return 30;
                }else {
                    return 80;
                }
            }else {
                return 80;
            }
        }else if (indexPath.section==1) {
            if(myCommetArray.count>2){
                if(indexPath.row==3){
                    return 30;
                }else {
                    return 80;
                }
            }else {
                return 80;
            }
        }else {
            if(commetMyArray.count>2){
                if(indexPath.row==3){
                    return 30;
                }else {
                    return 80;
                }
            }else {
                return 80;
            }
        }

    }
    
} 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
