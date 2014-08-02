//
//  comparViewController.h
//  szfc
//
//  Created by tao xu on 13-8-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EScrollerView.h"
#import "UIPopoverListView.h"
#import "buildDetail.h"
@interface comparViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EScrollerViewDelegate,UIPopoverListViewDataSource, UIPopoverListViewDelegate>{
    UITableView *tableView;
    UITableView *comparTable;
    IBOutlet UIView *scrollerView;
    UIPopoverListView *poplistview;
    NSArray *huxing;
    NSString *chooseHuxing;
    buildDetail *build;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;
@property (nonatomic,retain) IBOutlet UITableView *comparTable;
- (IBAction)backAction:(id)sender;
-(IBAction)huxingChange:(id)sender ;
-(id)initWithBuild:(buildDetail*)buildDetail;
@end
