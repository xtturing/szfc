//
//  detailsViewController.h
//  szfc
//
//  Created by tao xu on 13-7-30.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EScrollerView.h"
#import "MMGridView.h"
#import "PrettyNavigationBar.h"
#import "dataHttpManager.h"
#import "buildDetail.h"
@interface detailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EScrollerViewDelegate,MMGridViewDelegate,MMGridViewDataSource,dataHttpDelegate>{
     UITableView *tableView;
    IBOutlet UIView *scrollerView;
    MMGridView *pictureView;
    dataHttpManager *dataManager;
    buildDetail *build;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;
- (IBAction)backAction:(id)sender;
- (IBAction)collect:(id)sender;
-(IBAction)share:(id)sender;
-(IBAction)calculator:(id)sender;
-(IBAction)comment:(id)sender;
-(id)initWithBuildDetail:(buildDetail*)buildDetail;
@end
