//
//  detailsViewController.m
//  szfc
//
//  Created by tao xu on 13-7-30.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "detailsViewController.h"
#import "detailNameCell.h"
#import "detailDynamicCell.h"
#import "detailParameterCell.h"
#import "detailMapCell.h"
#import "MMGridViewDefaultCell.h"
#import "commentView.h"
#import "calculatorViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "messageViewController.h"
#import "mapViewController.h"
#import "comparViewController.h"
#import "loginViewController.h"
@interface detailsViewController ()

@end

@implementation detailsViewController
@synthesize tableView;
-(id)initWithBuildDetail:(buildDetail*)buildDetail{
    self=[super initWithNibName:@"detailsViewController" bundle:Nil];
    if(self){        
        build=[buildDetail retain];
        
    }
    return self;
}
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
    dataManager=[[dataHttpManager alloc] initWithDelegate];
    dataManager.delegate=self;
    [dataManager start];

    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xf0f1f4];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    tableView.delegate = nil;
    tableView.dataSource = nil;
    tableView=nil;
    build=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc{
    [super dealloc];
    [tableView release];
    [build release];
}
- (IBAction)backAction:(id)sender {  
    [self dismissModalViewControllerAnimated:YES]; 
}

- (IBAction)collect:(id)sender{
    if(![dataManager logIn]){
        loginViewController *login=[[loginViewController alloc] initIsLogin:YES];
        [self presentModalViewController:login animated:YES];
    }
    
}
-(IBAction)share:(id)sender{
    NSString *number = @"400";// 此处读入电话号码
    
    // NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
    
    
    
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
//    NSString *phoneNum = @"//222232";// 电话号码  
//    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];  
//    if (!phoneCallWebView) {  
//        phoneCallWebView =[[UIWebView alloc] init];// 这个webView只是一个后台的View 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的  
//    }   
//    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]]; 
}
-(IBAction)calculator:(id)sender{
//    calculatorViewController *calculator=[[calculatorViewController alloc] initWithNibName:@"calculatorViewController" bundle:nil];
//    [self presentModalViewController: calculator animated:YES];
}
-(IBAction)comment:(id)sender{
    CGFloat xWidth = self.view.bounds.size.width - 40.0f;
    CGFloat yHeight = self.view.bounds.size.height-100.0f;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    commentView *comment = [[commentView alloc] initWithFrame:CGRectMake(20, yOffset, xWidth, yHeight)];
    comment.autoresizesSubviews=YES;
    [comment show];
    [comment release];
}
//地图
-(void)showMap{
    
}
//更多动态
-(void)showDynamic{
    messageViewController *message=[[messageViewController alloc] initWithNibName:@"messageViewController" bundle:nil];
    [self.navigationController pushViewController:message animated:YES];
}
-(void)didGetAuthInfo:(NSString *)code userName:(NSString *)userName nikeName:(NSString *)nikeName phone:(NSString *)phone photo:(NSString *)photo{
    [dataManager postCollectBuildCode:build.Code userCode:code ];
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
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==0){
        return 3;
    }else {
        return 30;
    }
}
-(UIView *)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{

    UILabel *label=[[[UILabel alloc]init] autorelease];
    label.frame=CGRectMake(10, 5, 280, 20);
    label.font=[UIFont systemFontOfSize:14];
    label.textAlignment=UITextAlignmentLeft;
    if (section==1) {
        label.text=@"楼盘动态";
        label.textColor=[UIColor darkTextColor];
    }
    else if (section==2) {
        label.text=@"户型对比";
        label.textColor=[UIColor redColor];
    }else if (section==3) {
        label.text=@"地图定位";
        label.textColor=[UIColor darkTextColor];
    }
    else if (section==4) {
        label.text=@"楼盘参数";
        label.textColor=[UIColor darkTextColor];
    }else {
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
    
    if(indexPath.section==0){
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle        reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad){
            EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(10, 0, scrollerView.bounds.size.width, scrollerView.bounds.size.height)
                                                                  ImageArray:[NSArray arrayWithObjects:@"21.jpg",@"22.jpg",@"23.jpg", nil]
                                                                  TitleArray:nil];
            scroller.delegate=self;
            [scrollerView addSubview:scroller];
            [scroller release];
        }else {
            EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(10, 0, scrollerView.bounds.size.width, scrollerView.bounds.size.height)
                                                                  ImageArray:[NSArray arrayWithObjects:@"21.jpg",@"22.jpg",@"23.jpg", nil]
                                                                  TitleArray:nil];
            scroller.delegate=self;
            [scrollerView addSubview:scroller];
            [scroller release];
        }
        cell.accessoryView=scrollerView;        
        return cell; 
    }else if (indexPath.section==1) {
        static NSString *detailNameCellIdentifier = @"detailNameCellIdentifier";
        static BOOL nibsRegistered = NO;
        
        if (!nibsRegistered) {
            
            UINib *nib = [UINib nibWithNibName:@"detailNameCell" bundle:nil];
            
            [self.tableView registerNib:nib forCellReuseIdentifier:detailNameCellIdentifier];
            
            nibsRegistered = YES;
            
        }
        detailNameCell *cell = (detailNameCell *)[self.tableView dequeueReusableCellWithIdentifier:detailNameCellIdentifier];
        if (cell==nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"detailNameCell" owner:self options:nil]lastObject];
            
        }
        cell.BuildNameText=build.BuildName;
        cell.AreaNameText=build.AreaName;
        cell.AgioNameText=build.AgioName;
        cell.AddressText=build.Address;
        cell.PriceAverageText=build.PriceAverage;
        cell.DecTypeText=build.DecType;
        return cell;
    }else if (indexPath.section==2) {
        static NSString *detailDynamicCellIdentifier = @"detailDynamicCellIdentifier";
        static BOOL nibsRegistered = NO;
        
        if (!nibsRegistered) {
            
            UINib *nib = [UINib nibWithNibName:@"detailDynamicCell" bundle:nil];
            
            [self.tableView registerNib:nib forCellReuseIdentifier:detailDynamicCellIdentifier];
            
            nibsRegistered = YES;
            
        }
        detailDynamicCell *cell = (detailDynamicCell *)[self.tableView dequeueReusableCellWithIdentifier:detailDynamicCellIdentifier];
        if (cell==nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"detailDynamicCell" owner:self options:nil]lastObject];
            
        }
        
        
        return cell;
    }else if (indexPath.section==3) {
        static NSString *CellIdentifier = @"typeCell";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle        reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        CGRect frame = CGRectMake(12.0f, 0.0f, self.tableView.frame.size.width-24,100.0f);
        pictureView= [[MMGridView alloc] initWithFrame:frame];
        pictureView.dataSource=self;
        pictureView.delegate=self;
        pictureView.cellMargin = 5;
        pictureView.numberOfRows =[[NSNumber numberWithFloat:(self.tableView.frame.size.width-24)/100.0] integerValue];
        pictureView.numberOfColumns=1;
        pictureView.layoutStyle = HorizontalLayout; 
        cell.accessoryView=pictureView;   
        return cell;
    }else if (indexPath.section==4) {
        static NSString *CellIdentifier = @"typeCell";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle        reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        mapViewController *map=[[mapViewController alloc] init];
        map.lat=[build.Latitude doubleValue];
        map.lon=[build.Longitude doubleValue];
        map.name=build.BuildName;
        map.address=build.Address;
        map.view.frame=CGRectMake(5, 5, self.tableView.frame.size.width-30, 190);
        cell.accessoryView=map.view;
        return cell;
    }else{
        static NSString *detailParameterCellIdentifier = @"detailParameterCellIdentifier";
        static BOOL nibsRegistered = NO;
        
        if (!nibsRegistered) {
            
            UINib *nib = [UINib nibWithNibName:@"detailParameterCell" bundle:nil];
            
            [self.tableView registerNib:nib forCellReuseIdentifier:detailParameterCellIdentifier];
            
            nibsRegistered = YES;
            
        }
        detailParameterCell *cell = (detailParameterCell *)[self.tableView dequeueReusableCellWithIdentifier:detailParameterCellIdentifier];
        if (cell==nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"detailParameterCell" owner:self options:nil]lastObject];
            
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
        
    }    
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    if(indexPath.section==0){
        return scrollerView.bounds.size.height;
    }else if (indexPath.section==1) {
        return 70;
    }else if (indexPath.section==2) {
        return 200;
    }else if (indexPath.section==3) {
        return 100;
    }else if (indexPath.section==4) {
        return 200;
    }else{
        return 645;
    }
    
} 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==4){
        messageViewController *message=[[messageViewController alloc] initWithNibName:@"messageViewController" bundle:nil];
        [self.navigationController pushViewController:message animated:YES];
    }else if (indexPath.row==6) {
        
    }else if (indexPath.row==10) {
        mapViewController *map=[[mapViewController alloc] initWithNibName:@"mapViewController" bundle:nil];
        [self.navigationController pushViewController:map animated:YES];
    }
}
#pragma - MMGridViewDataSource

- (NSInteger)numberOfCellsInGridView:(MMGridView *)gridView
{
    return [build.huTypeList count];
}


- (MMGridViewCell *)gridView:(MMGridView *)gridView cellAtIndex:(NSUInteger)index
{
    MMGridViewDefaultCell *cell = [[[MMGridViewDefaultCell alloc] initWithFrame:CGRectNull] autorelease];
    huType *hu=[build.huTypeList objectAtIndex:index];
    cell.textLabel.text = hu.HuTypeName;
    UIFont *font = [UIFont systemFontOfSize:11]; 
    cell.textLabel.font=font;
    UIImage *d=[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",index%3]];
    CGSize size = CGSizeMake(100, 90);
    if (UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    [d drawInRect:CGRectMake(0, 0, 100, 90)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell.backgroundView.backgroundColor = [UIColor colorWithPatternImage:image];
    [d release];
    return cell;
}

// ----------------------------------------------------------------------------------

#pragma - MMGridViewDelegate

- (void)gridView:(MMGridView *)gridView didSelectCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
    [self didGridView:index];
}


- (void)gridView:(MMGridView *)gridView didDoubleTapCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
    [self didGridView:index];
}

-(void) didGridView:(NSUInteger)index{
    comparViewController *compar=[[comparViewController alloc] initWithBuild:build];
    [self presentModalViewController:compar animated:YES];
}

- (void)gridView:(MMGridView *)theGridView changedPageToIndex:(NSUInteger)index
{
    //    [self setupPageControl];
}

@end
