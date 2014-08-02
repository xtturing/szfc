//
//  logDetailViewController.h
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITTCalendarView.h"
@interface logDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ITTCalendarViewDelegate,UIActionSheetDelegate>{
    UITableView *tableView;
     ITTCalendarView *_calendarView;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;


@end
