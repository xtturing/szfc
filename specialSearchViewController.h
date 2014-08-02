//
//  specialSearchViewController.h
//  房伴
//
//  Created by tao xu on 13-8-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PullRefreshTableViewController.h"
#import "dataHttpManager.h"
@interface specialSearchViewController :PullRefreshTableViewController<dataHttpDelegate,CLLocationManagerDelegate>{
    UITableView *tableView;
    NSArray  *agioBuildList;
    dataHttpManager *dataManager;
    CLLocationManager *locationManager;
    int PageSize;
    int TotalSize;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;
@property(retain,nonatomic) NSString *lat;
@property(retain,nonatomic) NSString *lon;
-(void)SetParentView:(UIViewController *)viewController;
@end
