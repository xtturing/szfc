//
//  searchListViewController.h
//  szfc
//
//  Created by tao xu on 13-7-30.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
#import "dataHttpManager.h"
#import <QuartzCore/QuartzCore.h>
@interface searchListViewController :PullRefreshTableViewController<dataHttpDelegate>{
    UITableView *tableView;
    NSArray *searchBuildList;
    dataHttpManager *dataManager;
    NSString *detail;
    int PageSize;
    int TotalSize;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;
-(void)SetParentView:(UIViewController *)viewController;
-(id)initWithBuildList:(NSArray*)list detail:(NSString *)detailText total:(int) total;
@end
