//
//  messageDetailViewController.h
//  szfc
//
//  Created by tao xu on 13-8-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface messageDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>{
    UITableView *tableView;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;

@end
