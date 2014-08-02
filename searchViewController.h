//
//  searchViewController.h
//  szfc
//
//  Created by tao xu on 13-7-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "dataHttpManager.h"
#import "searchListViewController.h"
#import "specialSearchViewController.h"
#import "BMapKit.h"
@interface searchViewController : UIViewController<UISearchBarDelegate,MBProgressHUDDelegate,UIPickerViewDelegate,UIPickerViewDataSource,BMKGeneralDelegate,dataHttpDelegate>
{
    MBProgressHUD *HUD;
    IBOutlet UIView *searchView;
    specialSearchViewController *specialSearch;
    searchListViewController *searchList;
    UIPickerView *pickerView;
    UISearchBar *_searchBar;
    UIButton *cityLable;
    
    NSArray *requirement;
    NSArray *city;
    
    NSInteger Index;
    
    NSString *searchStr;
    NSString *chooseCity;
    NSString *quyuStr;
    NSString *zongjiaStr;
    NSString *huxingStr;
    NSString *mianjiStr;
    NSString *kaifashangStr;
    NSString *wuyeStr;
    NSString *order;
    
    NSString *orderDetail;
    dataHttpManager *dataManager;
    
}
@property (nonatomic,retain) NSString *searchStr;
@property (nonatomic,retain) NSString *chooseCity;
@property (nonatomic,retain) NSString *quyuStr;
@property (nonatomic,retain) NSString *zongjiaStr;
@property (nonatomic,retain) NSString *huxingStr;
@property (nonatomic,retain) NSString *mianjiStr;
@property (nonatomic,retain) NSString *kaifashangStr;
@property (nonatomic,retain) NSString *wuyeStr;
@property (nonatomic,retain) NSString *order;
@property (nonatomic,retain) IBOutlet UIView *searchView;
@property (nonatomic,retain) UIPickerView *pickerView;
-(IBAction)chooseType:(id)sender;
-(void)orderPick;
-(void)cityChanged:(NSString *)cityName;
@end
