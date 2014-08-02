//
//  writelogViewController.h
//  szfc
//
//  Created by tao xu on 13-8-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteView.h"
@interface writelogViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>{
    BOOL _shouldPostImage;
    
}
@property (retain, nonatomic) IBOutlet UIImageView *theImageView;
@property (retain, nonatomic) IBOutlet UIImageView *TVBackView;
@property (retain, nonatomic) IBOutlet NoteView *noteView;

- (IBAction)alarmAction:(id)sender;
@end
