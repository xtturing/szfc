//
//  hotTableViewController.h
//  房伴
//
//  Created by tao xu on 13-8-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
#import "dataHttpManager.h"
#import "buttonCell.h"
@interface hotTableViewController  :PullRefreshTableViewController<dataHttpDelegate,buttonCellDelegate>{
    UITableView *tableView;
    NSArray *friendMessageList;
    dataHttpManager *dataManager;
    NSString *userCode;
    int PageSize;
    int TotalSize;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;
@property (nonatomic,retain) NSString *userCode;
-(void)SetParentView:(UIViewController *)viewController;

@end
