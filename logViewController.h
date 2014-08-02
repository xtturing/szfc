//
//  logViewController.h
//  szfc
//
//  Created by tao xu on 13-8-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMGridView.h"
@interface logViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MMGridViewDelegate,MMGridViewDataSource>{
    UITableView *tableView;
    UIButton *button;
    MMGridView *pictureView;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;

@end
