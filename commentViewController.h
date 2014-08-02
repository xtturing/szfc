//
//  commentViewController.h
//  szfc
//
//  Created by tao xu on 13-8-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableView;
    UIButton *button;
    NSArray *collectArray;
    NSArray *myCommetArray;
    NSArray *commetMyArray;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;
@property (nonatomic,retain) NSArray *collectArray;
@property (nonatomic,retain) NSArray *myCommetArray;
@property (nonatomic,retain) NSArray *commetMyArray;
@end
