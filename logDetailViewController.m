//
//  logDetailViewController.m
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "logDetailViewController.h"
#import "ITTBaseDataSourceImp.h"
#import "shareViewController.h"
@interface logDetailViewController ()

@end

@implementation logDetailViewController
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
    self.navigationItem.title=@"工业园区印象城";
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
    //    [UIButton buttonWithType:UIButtonTypeRoundedRect];  
    //    addButton.frame = CGRectMake(0.0, 0.0, 60.0,30.0);  
    //    [addButton setTitle:@"评论" forState:UIControlStateNormal];
    //    addButton.titleLabel.textColor=[UIColor colorWithHex:0x3D89BF];
    //    addButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0.0, 0.0, 36.0, 36.0);  
    [addButton setImage:[UIImage imageNamed:@"2013080506361710_easyicon_net_48.png"] forState:UIControlStateNormal];  
    [addButton setImage:[UIImage imageNamed:@"2013080506361710_easyicon_net_48.png"] forState:UIControlStateSelected];  
    [addButton addTarget:self action:@selector(showCalendar:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];  
    addBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.rightBarButtonItem=addBarButtonItem;  
    [addBarButtonItem release];
    
    UIButton *button= 
    [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, 36.0,30.0); 
    [button setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];  
    [button setImage:[UIImage imageNamed:@"more_hover.png"] forState:UIControlStateHighlighted];  
    [button addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *moreBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];  
    moreBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.rightBarButtonItem=moreBarButtonItem;  
    [moreBarButtonItem release];
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
//    [_calendarView hide];
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
- (void)moreAction:(id)sender {  
    // 创建时仅指定取消按钮
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@""  delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil];
    
    // 逐个添加按钮（比如可以是数组循环）
    [sheet addButtonWithTitle:@"公开到动态"];
    [sheet addButtonWithTitle:@"分享到新浪微博"];
    [sheet addButtonWithTitle:@"提醒"];
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
            _calendarView = [ITTCalendarView viewFromNib];
            ITTBaseDataSourceImp *dataSource = [[ITTBaseDataSourceImp alloc] init];
            _calendarView.date = [NSDate dateWithTimeIntervalSinceNow:2*24*60*60];    
            _calendarView.dataSource = dataSource;
            _calendarView.delegate = self;
            _calendarView.frame = CGRectMake(8, 40, 309, 410);
            _calendarView.allowsMultipleSelection = YES;
            [_calendarView showInView:self.view];
            [dataSource release];
            break;
        }
    }
}

- (IBAction)showCalendar:(id)sender 
{
    if (_calendarView.appear) 
    {
        [_calendarView hide];        
    }
    else
    {
        [_calendarView showInView:self.view];
    }
}
- (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate 
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formate];
	NSString *str = [formatter stringFromDate:date];
	[formatter release];
	return str;
}
- (void)calendarViewDidSelectDay:(ITTCalendarView*)calendarView calDay:(ITTCalDay*)calDay
{
    NSArray *selectedDates = calendarView.selectedDateArray;
    if (calendarView.allowsMultipleSelection) 
    {
        for (NSDate *date in selectedDates) 
        {
            NSLog(@"selected date %@", [self stringFromFomate:date formate:@"yyyy-MM-dd"]);
        }        
    }
    else
    {
        ITTDINFO(@"selected date %@", [self stringFromFomate:calendarView.selectedDate formate:@"yyyy-MM-dd"]);        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
        
        UIFont *font = [UIFont systemFontOfSize:12]; 
        cell.textLabel.font=font;
        cell.textLabel.textAlignment=UITextAlignmentLeft;
        cell.textLabel.numberOfLines = 0; 
        cell.textLabel.opaque=NO;
        cell.textLabel.text =@"2013-01-10  08:12";     
        cell.textLabel.textColor=[UIColor colorWithHex:0x3D89BF];
        
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
        cell.textLabel.text =@"上周天气还算过得去，虽然算不上很凉爽，但也算不上很热，郁闷的是，明天开始又要上升到35度了，唉，夏天，怎么才能轻松地渡过呢。 这两天还有点小忙，几天没做美食了，天气热，出门真难受呢，今天好不容易空一点，做点骨头汤给小熊喝吧"; 
    }
    return cell;
    
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    if(indexPath.row==0){
        return 30;
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
