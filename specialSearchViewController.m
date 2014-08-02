//
//  specialSearchViewController.m
//  房伴
//
//  Created by tao xu on 13-8-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "specialSearchViewController.h"
#import "specialSearchCell.h"
#import "detailsViewController.h"
#import "agio.h"
@interface specialSearchViewController ()

@end

@implementation specialSearchViewController
@synthesize tableView,lat,lon;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //异步得到热门房源数据
         PageSize=10;
        dataManager=[[dataHttpManager alloc] initWithDelegate];
        dataManager.delegate=self;
        [dataManager start];        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter=0.5;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation]; // 开始定位
    }
    NSLog(@"GPS 启动");
    lat=@"33";
    lon=@"120";
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
    agioBuildList=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc{
    [super dealloc];
    [tableView release];
    [agioBuildList release];
}
-(void)SetParentView:(UIViewController *)viewController{
    
    [self setParentViewController:viewController];
    
}
// 定位成功时调用
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation 
{
    lat=[[NSString stringWithFormat:@"%.4f", newLocation.coordinate.latitude] retain];
    lon=[[NSString stringWithFormat:@"%.4f", newLocation.coordinate.longitude] retain];
    [dataManager getAgioList:1 size:PageSize lat:[lat doubleValue] lon:[lon doubleValue]];
    [locationManager stopUpdatingLocation];
}
// 定位失败时调用
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    [dataManager getAgioList:1 size:PageSize lat:[lat doubleValue] lon:[lon doubleValue]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([agioBuildList count]+1);
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *reuseIdetify = @"SvTableViewCell";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UIFont *font = [UIFont systemFontOfSize:13]; 
        cell.textLabel.font=font;
        cell.backgroundColor=[UIColor whiteColor];
        cell.textLabel.text =@"热门楼盘";
        return cell;
    }else {
        agio *a=[agioBuildList objectAtIndex:(indexPath.row-1)];
        static NSString *specialSearchCellIdentifier = @"specialSearchCellIdentifier";
        static BOOL nibsRegistered = NO;
        
        if (!nibsRegistered) {
            
            UINib *nib = [UINib nibWithNibName:@"specialSearchCell" bundle:nil];
            
            [self.tableView registerNib:nib forCellReuseIdentifier:specialSearchCellIdentifier];
            
            nibsRegistered = YES;
            
        }
        specialSearchCell *cell = (specialSearchCell *)[self.tableView dequeueReusableCellWithIdentifier:specialSearchCellIdentifier];
        if (cell==nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"specialSearchCell" owner:self options:nil]lastObject];
            
        }
        cell.AgioNameText=a.AgioName;
        cell.AreaNameText=a.AreaName;
        cell.BuildNameText=a.BuildName;
        cell.DecNameText=a.DecName;
        cell.PriceAverageText=a.PriceAverage;
        cell.LocalRangeText=a.LocalRange;
        cell.LdpiPhotourl=a.LdpiPhoto;
        return cell;
    }
    
    
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    if(indexPath.row==0){
        return 40;
    }else {
        return 75;
    }
    
} 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row>0){
        agio *a=[agioBuildList objectAtIndex:(indexPath.row-1)];
        [dataManager getBuildDetail:[a.ID intValue]];
    }   
}
-(void)didGetAgioList:(NSArray*)agioList Total:(int)Total{
    TotalSize=Total;
    agioBuildList=agioList;
    [self.tableView reloadData];
}
-(void)didGetBuildDetail:(buildDetail *)buildDetail{
    detailsViewController *details=[[[detailsViewController alloc] initWithBuildDetail:buildDetail] autorelease];
    [self presentModalViewController:details animated:YES];
}
- (void)refresh {
    if(PageSize+10>TotalSize){
        PageSize=TotalSize;
    }else {                
        PageSize=PageSize+10;
    }    
    [dataManager getAgioList:1 size:PageSize lat:[lat doubleValue] lon:[lon doubleValue]];
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
}

- (void)addItem{
    // Add a new time
    
    //没有更多内容了
    //    self.hasMore = NO;
    
    
    [self stopLoading];
}


@end
