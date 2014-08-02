//
//  friendMessageViewController.h
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
#import "infoDetail.h"
#import "dataHttpManager.h"
#import "buttonCell.h"
@interface friendMessageViewController : PullRefreshTableViewController<UITableViewDataSource,UITableViewDelegate,dataHttpDelegate,buttonCellDelegate>{
    UITableView *tableView;
    infoDetail *infoD;
    dataHttpManager *dataManager;
    NSArray *replyArray;
    int PageSize;
    int TotalSize;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;
-(id)initWithInfoDetail:(infoDetail *)info;
@end
