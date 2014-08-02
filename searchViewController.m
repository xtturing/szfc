//
//  searchViewController.m
//  szfc
//
//  Created by tao xu on 13-7-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "searchViewController.h"
#import "PrettyKit.h"
#import "area.h"
#import "hint.h"
#import "mapViewController.h"
#import "cityViewController.h"
@interface searchViewController ()

@end
BMKMapManager* _mapManager;
@implementation searchViewController
@synthesize pickerView,searchStr,searchView,chooseCity,quyuStr,zongjiaStr,huxingStr,mianjiStr,kaifashangStr,wuyeStr,order;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.tabBarItem.title = @"房产搜索";// NSLocalizedString(@"First", @"First");
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"F649B9A24953A8A82CD79B2B3081125ABCA92CCC" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    specialSearch=[[specialSearchViewController alloc] initWithNibName:@"specialSearchViewController" bundle:nil];
//    specialSearch.view.frame=CGRectMake(0.0f,0.0f,searchView.frame.size.width, searchView.frame.size.height);
    [searchView addSubview:specialSearch.view];
    [specialSearch SetParentView:self];
    chooseCity=@"苏州市";
    quyuStr=@"0";
    zongjiaStr=@"1000";
    huxingStr=@"1100";
    mianjiStr=@"1200";
    kaifashangStr=@"1300";
    wuyeStr=@"1400";
    order=@"1";
    orderDetail=@"价格升序";
    searchStr=@"";
    dataManager=[[dataHttpManager alloc] initWithDelegate];
    dataManager.delegate=self;
    [dataManager start];
    //异步得到区域数据
    [dataManager getAreaList:2 father:1];
    
    /*
     初始化数据
     */
    //同步得到区域数据    
    pickerView=[[UIPickerView alloc] init];
    pickerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-265, 320, 216); 
    pickerView.dataSource=self;
    pickerView.delegate=self;
    pickerView.showsSelectionIndicator=YES;
    [pickerView setHidden:YES];
    [self.view addSubview:pickerView];
    cityLable = [UIButton buttonWithType:UIButtonTypeCustom];
    cityLable.frame=CGRectMake(0.0f, 0.0f, 57.0f, 30);
    [cityLable setBackgroundImage:[UIImage imageNamed:@"shishi_btn"] forState:UIControlStateNormal];
    cityLable.font=[UIFont systemFontOfSize:12];
    [cityLable setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [cityLable setTitleColor:[UIColor colorWithHex:0x6ac627] forState:UIControlStateHighlighted];
    [cityLable setTitle:chooseCity forState:UIControlStateNormal];
    [cityLable setTitle:chooseCity forState:UIControlStateHighlighted];
    cityLable.userInteractionEnabled=YES;
    
    
    UITapGestureRecognizer *tapGestureTel = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cityChange)]autorelease];
    
    [cityLable addGestureRecognizer:tapGestureTel];
    UIBarButtonItem *myButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cityLable];
    self.navigationItem.leftBarButtonItem = myButtonItem;  
    
    
    _searchBar = [[UISearchBar alloc] init];  
    _searchBar.placeholder=@"请输入楼盘名称"; 
    UITextField *searchField = [[_searchBar subviews] lastObject];
    searchField.font=[UIFont systemFontOfSize:14];
    _searchBar.delegate = self;  
    _searchBar.keyboardType = UIKeyboardTypeDefault;     
    for (UIView *view in _searchBar.subviews)
    {
        if ([view isKindOfClass:NSClassFromString
             (@"UISearchBarBackground")])
        {
            [view removeFromSuperview];
            break;
            
        }
    }
    [_searchBar setFrame:CGRectMake(0.0, 0.0, 200,self.navigationController.navigationBar.bounds.size.height)];
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:_searchBar]; 
    
    UIButton *map=[UIButton buttonWithType:UIButtonTypeCustom];
    map.frame=CGRectMake(0.0f, 0.0f, 35.0f, 30);
    [map setBackgroundImage:[UIImage imageNamed:@"map"] forState:UIControlStateNormal];
    [map setBackgroundImage:[UIImage imageNamed:@"map_hover"] forState:UIControlStateHighlighted];
    UITapGestureRecognizer *tapGesturemap = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mapSearch)]autorelease];
    
    [map addGestureRecognizer:tapGesturemap];
    UIBarButtonItem *mapItem=[[UIBarButtonItem alloc] initWithCustomView:map];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:mapItem,menuButton, nil]; 
    // Do any additional setup after loading the view from its nib.
}
-(void)mapSearch{
    mapViewController *map=[[mapViewController alloc] initWithNibName:@"mapViewController" bundle:nil];
    [self.navigationController pushViewController:map animated:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    pickerView.dataSource=Nil;
    pickerView.delegate=nil;
    pickerView=nil;
    searchStr=nil;
    searchView=nil;
    chooseCity=nil;
    quyuStr=nil;
    zongjiaStr=nil;
    huxingStr=nil;
    mianjiStr=nil;
    kaifashangStr=nil;
    wuyeStr=nil;
    order=nil;
    requirement=nil;
    city=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark SearchBar Delegate Methods
- (void)doSearch:(UISearchBar *)searchBar{  
    
    [dataManager getBuildList:1 size:10 area:quyuStr price:zongjiaStr hu:huxingStr sqm:mianjiStr dev:kaifashangStr pro:wuyeStr key:searchStr order:order];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
	searchBar.showsCancelButton = YES;
	for(id cc in [searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
	return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.text = @"";
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
	searchBar.showsCancelButton = NO;
//	searchBar.text = @"";
    
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    searchStr =[searchText retain];
    NSLog(@"%@",searchStr);
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[searchBar resignFirstResponder];
    searchBar.showsSearchResultsButton=YES;
    [self doSearch:searchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[searchBar resignFirstResponder];
}
-(void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{  
   [self doSearch:searchBar];
}
-(IBAction)chooseType:(id)sender{
    UIButton *button=(UIButton *)sender;
    Index=button.tag;
    requirement=[[NSArray alloc] init];
    if(Index==0){
        requirement =[dataManager getAreaListSynchronous:3 father:2];
    }else if (Index==1) {
        requirement=[dataManager getHintList:10];
    }else if (Index==2) {
        requirement=[dataManager getHintList:11];
    }else if (Index==3) {
        requirement=[dataManager getHintList:12];
    }else if (Index==4) {
        requirement =[dataManager getHintList:13];
    }else {
        requirement=[dataManager getHintList:14];
    }
    
    //点击后删除之前的PickerView
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIPickerView class]]) {
            [self ViewAnimation:pickerView willHidden:YES];
        }
    }
    [self ViewAnimation:pickerView willHidden:NO];
    [pickerView reloadAllComponents];
    
}
-(void)orderPick{
    Index=6;
    requirement=[[NSArray alloc] initWithObjects:@"价格升序", @"优惠额度降序",@"收藏热度降序",@"交房日期升序",nil];
    //点击后删除之前的PickerView
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIPickerView class]]) {
            [self ViewAnimation:pickerView willHidden:YES];
        }
    }
    [self ViewAnimation:pickerView willHidden:NO];
    [pickerView reloadAllComponents];
}
-(void)animationFinished{  
    NSLog(@"动画结束!");  
} 
- (void)ViewAnimation:(UIView*)view willHidden:(BOOL)hidden {
    
    [UIView animateWithDuration:0.3 animations:^{
        if (hidden) {
            view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, 320, 216);
        } else {
            [view setHidden:hidden];
            view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-265, 320, 216);
        }
    } completion:^(BOOL finished) {
        [view setHidden:hidden];
    }];
}

#pragma mark - UIPopoverListViewDataSource
-(void)cityChange{
    cityViewController *ci=[[cityViewController alloc] initWithAreaList:city chooseCity:chooseCity];     
    [self.navigationController pushViewController:ci animated:YES]; 
    [ci SetParentView:self];
}
-(void)cityChanged:(NSString *)cityName{
    chooseCity=cityName;
    [cityLable setTitle:chooseCity forState:UIControlStateNormal];
    [cityLable setTitle:chooseCity forState:UIControlStateHighlighted];    
}
#pragma dataHttpManager
//异步得到区域数据
-(void)didGetAreaList:(NSArray*)areaList{
    city=areaList;
}
-(void)didGetBuildList:(NSArray *)buildList Total:(int)Total{
    if(buildList.count>0){
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.5f;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"cube";
        animation.subtype = kCATransitionFromRight;
        [[searchView layer] addAnimation:animation forKey:@"animation"];
        searchList=[[searchListViewController alloc] initWithBuildList:buildList detail:orderDetail total:Total] ;
//        searchList.view.frame=CGRectMake(0.0f,0.0f,searchView.frame.size.width, searchView.frame.size.height);
        [searchView addSubview:searchList.view];
        [searchList SetParentView:self];
    }else {
        specialSearch=[[specialSearchViewController alloc] initWithNibName:@"specialSearchViewController" bundle:nil];
//        specialSearch.view.frame=CGRectMake(0.0f,0.0f,searchView.frame.size.width, searchView.frame.size.height);
        [searchView addSubview:specialSearch.view];
        [specialSearch SetParentView:self];
    }
    
}
//继续添加
#pragma mark Picker Date Source Methods  

//返回显示的列数  
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView  
{  
    return 1;  
}  
//返回当前列显示的行数  
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component  
{  
   return [requirement count];
    
}  

#pragma mark Picker Delegate Methods  

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上  
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component  
{  
    if(Index==0){        
        area *a=[requirement objectAtIndex:row];
        return a.AreaName;
    }else if (Index==6) {
        return [requirement objectAtIndex:row];
    }
    else {
        hint *a=[requirement objectAtIndex:row];
        return a.HintName;
    }
}  
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    //点击后删除之前的PickerView
    [self.pickerView setHidden:YES];
    if(Index==0){
        area *a=[requirement objectAtIndex:row];
        quyuStr=[a.ID retain];
    }else if (Index==1) {
        hint *a=[requirement objectAtIndex:row];
        zongjiaStr=[a.TypeId retain];
    }else if (Index==2) {
        hint *a=[requirement objectAtIndex:row];
        huxingStr=[a.TypeId retain];
    }else if (Index==3) {
        hint *a=[requirement objectAtIndex:row];
        mianjiStr=[a.TypeId retain];
    }else if (Index==4) {
        hint *a=[requirement objectAtIndex:row];
        kaifashangStr=[a.TypeId retain];
    }else if (Index==6) {
        orderDetail=[requirement objectAtIndex:row];
        order=[[NSString stringWithFormat:@"%d",(row+1)] retain];
    }else {
        hint *a=[requirement objectAtIndex:row];
        wuyeStr=[a.TypeId retain];
    }
    [dataManager getBuildList:1 size:10 area:quyuStr price:zongjiaStr hu:huxingStr sqm:mianjiStr dev:kaifashangStr pro:wuyeStr key:searchStr order:order];
   
}
- (void)dealloc
{
    [requirement release];
    [city release];
    [chooseCity release];
    [cityLable release];
    [searchView release];
    [pickerView release];
    [searchStr release];
    [quyuStr release];
    [zongjiaStr release];
    [huxingStr release];
    [mianjiStr release];
    [kaifashangStr release];
    [wuyeStr release];
    [order release];
    [super dealloc];
}
@end
