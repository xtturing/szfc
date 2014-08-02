//
//  commentView.h
//  szfc
//
//  Created by tao xu on 13-8-2.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentView : UIView{
    UITextView *_textView;    
    UIView *_commentView;  
    UIControl  *_overlayView;
}
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIView *commentView;
- (void)show;
- (void)dismiss;
@end
