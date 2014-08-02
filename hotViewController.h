//
//  hotViewController.h
//  szfc
//
//  Created by tao xu on 13-7-31.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dataHttpManager.h"
@interface hotViewController : UIViewController<dataHttpDelegate>{
    UIView *everyTalkView;
    UIView *friendMessageView;
    dataHttpManager *dataManager;
}
@property (nonatomic,retain) IBOutlet UIView *everyTalkView;
@property (nonatomic,retain) IBOutlet  UIView *friendMessageView;

@end
