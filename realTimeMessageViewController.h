//
//  realTimeMessageViewController.h
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceViewController.h"
@interface realTimeMessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UITableView *tableView;
    UITextView  *_messageTextField;
    FaceViewController      *_phraseViewController;
}
@property (nonatomic,retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet FaceViewController   *phraseViewController;
@property (nonatomic, retain) IBOutlet UITextView *messageTextField;
-(IBAction)sendMessage_Click:(id)sender;
-(IBAction)showPhraseInfo:(id)sender;
-(IBAction)talkRoom:(id)sender;
@end
