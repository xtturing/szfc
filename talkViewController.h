//
//  talkViewController.h
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
#import "dataHttpManager.h"
@interface talkViewController : PullRefreshTableViewController<UITableViewDataSource,UITableViewDelegate,dataHttpDelegate>{
    UITableView *tableView;
    dataHttpManager *dataManager;
    NSArray *mssageList;
    int PageSize;
    int TotalSize;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;
@end
