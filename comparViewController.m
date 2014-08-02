//
//  comparViewController.m
//  szfc
//
//  Created by tao xu on 13-8-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "comparViewController.h"
#import "comparParameterCell.h"
#import "comparCell.h"
#import <QuartzCore/QuartzCore.h>
@interface comparViewController ()

@end

@implementation comparViewController
@synthesize tableView,comparTable;
-(id)initWithBuild:(buildDetail*)buildDetail{
    self = [super initWithNibName:@"comparViewController" bundle:nil];
    if (self) {
        build=buildDetail;
    }
    return self;
}
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
    self.navigationItem.title=@"户型对比";
    chooseHuxing=@"二室二厅一卫";
    huxing=[[NSArray  alloc] initWithObjects:@"一室一厅一卫",@"二室二厅一卫",@"二室二厅二卫",@"三室二厅一卫",@"三室二厅二卫",@"四室以上",nil];
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];  
//    backButton.frame = CGRectMake(0.0, 0.0, 36.0, 30.0);  
//    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];  
//    [backButton setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted];  
//    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];  
//    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
//    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
//    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
//    [temporaryBarButtonItem release];
//    UIButton *addButton = 
//    //    [UIButton buttonWithType:UIButtonTypeRoundedRect];  
//    //    addButton.frame = CGRectMake(0.0, 0.0, 60.0,30.0);  
//    //    [addButton setTitle:@"楼盘详情" forState:UIControlStateNormal];
//    //    addButton.titleLabel.textColor=[UIColor colorWithHex:0x3D89BF];
//    //    addButton.titleLabel.font=[UIFont systemFontOfSize:12];
//    [UIButton buttonWithType:UIButtonTypeCustom];
//    addButton.frame = CGRectMake(0.0, 0.0, 58.0, 30.0);  
//    [addButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];  
//    [addButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateHighlighted]; 
//    [addButton setFont:[UIFont systemFontOfSize:12]];
//    [addButton setTitle:@"户型对比" forState:UIControlStateNormal];
//    [addButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
//    [addButton setTitleColor:[UIColor colorWithHex:0x6ac627] forState:UIControlStateHighlighted];
//    [addButton addTarget:self action:@selector(huxingChange) forControlEvents:UIControlEventTouchUpInside];  
//    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];  
//    addBarButtonItem.style = UIBarButtonItemStylePlain;  
//    self.navigationItem.rightBarButtonItem=addBarButtonItem;  
//    [addBarButtonItem release];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xf0f1f4];
    self.comparTable.dataSource=self;
    self.comparTable.delegate=self;
    self.comparTable.backgroundColor = [UIColor colorWithHex:0xf0f1f4];
    // 滑动的 Recognizer
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    //设置滑动方向
    [swipeleft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.tableView addGestureRecognizer:swipeleft];
    
    UISwipeGestureRecognizer *comparSwipeleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(comparSwipeleft:)];
    //设置滑动方向
    [comparSwipeleft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.comparTable addGestureRecognizer:comparSwipeleft];
    // 滑动的 Recognizer
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    //设置滑动方向
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.tableView addGestureRecognizer:swipeRight];
    UISwipeGestureRecognizer *comparSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(comparSwipeRight:)];
    //设置滑动方向
    [comparSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.comparTable addGestureRecognizer:comparSwipeRight];
    EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, scrollerView.bounds.size.width, scrollerView.bounds.size.height)
                                                          ImageArray:[NSArray arrayWithObjects:@"1.jpg",@"2.jpg",@"0.jpg", nil]
                                                          TitleArray:nil];
    scroller.delegate=self;
    [scrollerView addSubview:scroller];
    [scroller release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    tableView.delegate = nil;
    tableView.dataSource = nil;
    tableView=nil;
    comparTable.delegate = nil;
    comparTable.dataSource = nil;
    comparTable=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)backAction:(id)sender {  
    [self dismissModalViewControllerAnimated:YES]; 
}
- (IBAction)huxingChange:(id)sender {
//    CGFloat xWidth = self.view.bounds.size.width - 40.0f;
//    CGFloat yHeight = self.view.bounds.size.height-60.0f;
//    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
//    poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(20, yOffset, xWidth, yHeight)];
//    poplistview.delegate = self;
//    poplistview.datasource = self;
//    [poplistview setTitle:@"对比户型选择"];
//    poplistview.autoresizesSubviews=YES;
//    poplistview.listView.scrollEnabled = TRUE;
//    [poplistview show];
//    [poplistview release];
    comparTable.hidden=NO;

}
- (IBAction)swipeLeft:(id)sender {
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.7f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [[self.tableView layer] addAnimation:animation forKey:@"animation"];
   
}
- (IBAction)swipeRight:(id)sender{   
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.7f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [[self.tableView layer] addAnimation:animation forKey:@"animation"];
    
    
}
- (IBAction)comparSwipeleft:(id)sender {
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.7f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [[self.comparTable layer] addAnimation:animation forKey:@"animation"];
    
}
- (IBAction)comparSwipeRight:(id)sender{   
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.7f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [[self.comparTable layer] addAnimation:animation forKey:@"animation"];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
    
}
-(UIView *)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UILabel *label=[[[UILabel alloc]init] autorelease];
    label.frame=CGRectMake(10, 5, 280, 20);
    label.font=[UIFont systemFontOfSize:14];
    label.textAlignment=UITextAlignmentLeft;
    if (section==0) {
        label.text=@"户型评论";
        label.textColor=[UIColor darkTextColor];
    }
    else if (section==1) {
        label.text=@"楼盘参数";
        label.textColor=[UIColor darkTextColor];
    }
    else {
        label.text=@"";
    }
    
    label.backgroundColor=[UIColor clearColor];
    UIView *sectionview=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width,self.tableView.bounds.size.height)]autorelease];
    [sectionview addSubview:label];
    return sectionview;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.section==0) {
        static NSString *comparCellIdentifier = @"comparCellIdentifier";
        static BOOL nibsRegistered = NO;
        
        if (!nibsRegistered) {
            
            UINib *nib = [UINib nibWithNibName:@"comparCell" bundle:nil];
            
            [self.tableView registerNib:nib forCellReuseIdentifier:comparCellIdentifier];
            
            nibsRegistered = YES;
            
        }
        comparCell *cell = (comparCell *)[self.tableView dequeueReusableCellWithIdentifier:comparCellIdentifier];
        if (cell==nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"comparCell" owner:self options:nil]lastObject];
            
        }
        
        
        return cell;
    }
    else if (indexPath.section==1) {
        static NSString *comparParameterCellIdentifier = @"comparParameterCellIdentifier";
        static BOOL nibsRegistered = NO;
        
        if (!nibsRegistered) {
            
            UINib *nib = [UINib nibWithNibName:@"comparParameterCell" bundle:nil];
            
            [self.tableView registerNib:nib forCellReuseIdentifier:comparParameterCellIdentifier];
            
            nibsRegistered = YES;
            
        }
        comparParameterCell *cell = (comparParameterCell *)[self.tableView dequeueReusableCellWithIdentifier:comparParameterCellIdentifier];
        if (cell==nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"comparParameterCell" owner:self options:nil]lastObject];
            
        }
        cell.KindergartenText=build.Kindergarten;
        cell.JuniorSchoolText=build.JuniorSchool;
        cell.MiddleSchoolText=build.MiddleSchool;
        cell.SubWayText=build.SubWay;
        cell.TransitText=build.Transit;
        cell.ElevatedText=build.Elevated;
        cell.LifeSupportText=build.LifeSupport;
        cell.ShopCenterText=build.ShopCenter;
        cell.ShopMallText=build.ShopMall;
        cell.MedicalCenterText=build.MedicalCenter;
        cell.DeveloperNameText=build.DeveloperName;
        cell.HouseNumText=build.HouseNum;
        cell.ProTypeText=build.ProType;
        cell.UnitDesignText=build.UnitDesign;
        cell.RoomRangeText=build.RoomRange;
        cell.RoomRateText=build.RoomRate;
        cell.SqmTypeText=build.SqmType;
        cell.FacadeStyleText=build.FacadeStyle;
        cell.DecTypeText=build.DecType;
        cell.DecNumText=build.DecNum;
        cell.ProCompanyText=build.ProCompany;
        cell.ProFeeText=build.ProFee;
        cell.PriceTypeText=build.PriceType;
        cell.SaleIntrText=build.SaleIntr;
        cell.OverIntrText=build.OverIntr;
        cell.OverDateText=build.OverDate;
        cell.RightYearText=build.RightYear;
        cell.FloorSpaceText=build.FloorSpace;
        cell.BuildSpaceText=build.BuildSpace;
        cell.PlotRateText=build.PlotRate;
        cell.GreenRateText=build.GreenRate;
        cell.ParkThanText=build.ParkThan;
        
        return cell;
    }else {
        static NSString *reuseIdetify = @"SvTableViewCell";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdetify];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UIFont *font = [UIFont systemFontOfSize:14]; 
        cell.textLabel.font=font;
        cell.textLabel.text =@"基本参数";
        return cell;
    }
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    if (indexPath.section==0) {
        return 80;
    }else if (indexPath.section==1) {
        return 645;
    }else {
        return  30;
    }
    
} 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"SvTableViewCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;    
    if(indexPath.row==0){
        UIFont *font = [UIFont systemFontOfSize:14]; 
        cell.textLabel.font=font;
        cell.textLabel.text =@"已选户型";
    }else if (indexPath.row==1) {
        UIFont *font = [UIFont systemFontOfSize:18]; 
        cell.textLabel.font=font;
        cell.accessoryType =UITableViewCellAccessoryCheckmark;
        cell.textLabel.text =[NSString stringWithFormat:@"    %@",chooseHuxing];
    }else if (indexPath.row==2) {
        UIFont *font = [UIFont systemFontOfSize:14]; 
        cell.textLabel.font=font;
        cell.textLabel.text =@"所有户型";
    }else if (indexPath.row>2){
        UIFont *font = [UIFont systemFontOfSize:18]; 
        cell.textLabel.font=font;
        cell.textLabel.text =[NSString stringWithFormat:@"    %@",[huxing objectAtIndex:(indexPath.row-3)]];
    }
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return (huxing.count+3);
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    chooseHuxing=[huxing objectAtIndex:indexPath.row-3];
    NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:1 inSection:0];
    UITableViewCell *maincell = [popoverListView.listView cellForRowAtIndexPath:indexPathToInsert];
    [[maincell textLabel] setText:[NSString stringWithFormat:@"    %@",chooseHuxing]];
    [popoverListView.listView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPathToInsert] withRowAnimation:UITableViewRowAnimationFade];
    [popoverListView dismiss];
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
        return 40;
    }else if (indexPath.row==2) {
        return 40;
    }else {
        return 44;
    }
}

@end
