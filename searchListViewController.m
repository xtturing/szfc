//
//  searchListViewController.m
//  szfc
//
//  Created by tao xu on 13-7-30.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "searchListViewController.h"
#import "searchListCell.h"
#import "detailsViewController.h"
#import "build.h"
#import "specialSearchViewController.h"
#import "searchViewController.h"
@interface searchListViewController ()

@end

@implementation searchListViewController
@synthesize tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(id)initWithBuildList:(NSArray*)list detail:(NSString *)detailText total:(int)total{
    self=[super initWithNibName:@"searchListViewController" bundle:Nil];
    if(self){
        searchBuildList=[list retain];
        detail=detailText;
        PageSize=10;
        TotalSize=total;
        dataManager=[[dataHttpManager alloc] initWithDelegate];
        dataManager.delegate=self;
        [dataManager start];
    }
    return self;
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
    searchBuildList=nil;
    tableView=nil;
    searchBuildList=nil;
    detail=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc{
    [super dealloc];
    [tableView release];
    [searchBuildList release];
    [detail release];
}
- (void)backAction:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES]; 
    
}
-(void)SetParentView:(UIViewController *)viewController{
    
    [self setParentViewController:viewController];
    
}
-(void)didGetBuildDetail:(buildDetail *)buildDetail{
    detailsViewController *details=[[[detailsViewController alloc] initWithBuildDetail:buildDetail] autorelease];
    [self presentModalViewController:details animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    if(indexPath.row==0){
        return 40;
    }else {
        return 90;
    }
    
} 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([searchBuildList count]+1);
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *reuseIdetify = @"SvTableViewCell";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdetify];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UIFont *font = [UIFont systemFontOfSize:13]; 
        cell.textLabel.font=font;
        cell.backgroundColor=[UIColor whiteColor];
        cell.textLabel.text =@"筛选楼盘";
        cell.detailTextLabel.text=detail;
        cell.detailTextLabel.font=[UIFont systemFontOfSize:10];
        cell.detailTextLabel.textColor=[UIColor darkGrayColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom]; 
        button.frame = CGRectMake( 0.0 , 0.0 ,65, 30 );
        [button setTitle: @"热门楼盘" forState:UIControlStateNormal];
        [button setFont:font];
        [button setTitle:@"热门楼盘" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHex:0x6ac627] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(showSpecia) forControlEvents:UIControlEventTouchUpInside];  
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        button.center=view.center;
        [view addSubview:button];
        cell. accessoryView = view;

        return cell;
    }else {
        build *b=[searchBuildList objectAtIndex:(indexPath.row-1)];
        static NSString *searchListCellIdentifier = @"searchListCellIdentifier";
        static BOOL nibsRegistered = NO;
        
        if (!nibsRegistered) {
            
            UINib *nib = [UINib nibWithNibName:@"searchListCell" bundle:nil];
            
            [self.tableView registerNib:nib forCellReuseIdentifier:searchListCellIdentifier];
            
            nibsRegistered = YES;
            
        }
        searchListCell *cell = (searchListCell *)[self.tableView dequeueReusableCellWithIdentifier:searchListCellIdentifier];
        if (cell==nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"searchListCell" owner:self options:nil]lastObject];
            
        }
        cell.BuildNameText=b.BuildName;
        cell.AreaNameText=b.AreaName;
        cell.AgioNameText=b.AgioName;
        cell.MinPayText=b.MinPay;
        cell.MaxRepayText=b.MaxRepay;
        cell.PriceAverageText=b.PriceAverage;
        cell.LdpiPhotoUrl=b.LdpiPhoto;
        
        return cell;
    }    
}
-(void)showSpecia{
   
    searchViewController *search=(searchViewController*)self.parentViewController;
    specialSearchViewController *specialSearch=[[specialSearchViewController alloc] initWithNibName:@"specialSearchViewController" bundle:nil];
    specialSearch.view.frame=CGRectMake(0.0f,0.0f,search.searchView.frame.size.width, search.searchView.frame.size.height);
    [search.searchView addSubview:specialSearch.view];
    [specialSearch SetParentView:search];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"cube";
    animation.subtype = kCATransitionFromRight;
    [[search.searchView layer] addAnimation:animation forKey:@"animation"];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
        searchViewController *search=(searchViewController*)self.parentViewController;
        [search orderPick];
    } else {
        build *b=[searchBuildList objectAtIndex:(indexPath.row-1)];
        [dataManager getBuildDetail:[b.ID intValue]];   
    }
     
}
- (void)refresh {
    if(PageSize+10>TotalSize){
        PageSize=TotalSize;
    }else {                
        PageSize=PageSize+10;
    }
    searchViewController *search=(searchViewController*)self.parentViewController;
    [dataManager getBuildList:1 size:PageSize area:search.quyuStr price:search.zongjiaStr hu:search.huxingStr sqm:search.mianjiStr dev:search.kaifashangStr pro:search.wuyeStr key:search.searchStr order:search.order];
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
}
-(void)didGetBuildList:(NSArray *)buildList Total:(int)Total{
    TotalSize=Total;
    searchBuildList=buildList;
    [self.tableView reloadData];
}
- (void)addItem{
    // Add a new time
       
    //没有更多内容了
//    self.hasMore = NO;    
    
    [self stopLoading];
}

@end
