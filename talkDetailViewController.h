//
//  talkDetailViewController.h
//  房伴
//
//  Created by tao xu on 13-8-26.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "messageDetail.h"
#import "dataHttpManager.h"
@interface talkDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,dataHttpDelegate>{
    UITableView *tableView;
    dataHttpManager *dataManager;
    messageDetail *msgDetail;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;
-(id)initWithMsgDetail:(messageDetail *)msg;
@end
