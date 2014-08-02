//
//  collectViewController.h
//  szfc
//
//  Created by tao xu on 13-7-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface collectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableView;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;

@end
