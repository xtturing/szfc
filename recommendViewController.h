//
//  recommendViewController.h
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
@interface recommendViewController : PullRefreshTableViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableView;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;

@end
