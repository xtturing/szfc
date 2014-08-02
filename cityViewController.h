//
//  cityViewController.h
//  房伴
//
//  Created by tao xu on 13-8-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableView;
    NSArray *city;
    NSString *chooseCity;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;
-(id)initWithAreaList:(NSArray*)list chooseCity:(NSString*)choose;
-(void)SetParentView:(UIViewController *)viewController;
@end
