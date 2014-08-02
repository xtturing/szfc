//
//  commentView.m
//  szfc
//
//  Created by tao xu on 13-8-2.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "commentView.h"
#import "SysFunction.h"
#import <QuartzCore/QuartzCore.h>
@interface commentView()
- (void)defalutInit;
- (void)fadeIn;
- (void)fadeOut;
@end

@implementation commentView
@synthesize textView=_textView;
@synthesize commentView = _commentView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addShareView];
    }
    return self;
}
- (CGAffineTransform)getTransformMakeRotationByOrientation:(UIInterfaceOrientation)orientation  
{  
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    } 
    
}  

-(void)layoutSubviews{
    [super layoutSubviews];
    //（获取当前电池条动画改变的时间  
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;  
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    [UIView beginAnimations:nil context:nil];  
    [UIView setAnimationDuration:duration];  
    self.transform =[self getTransformMakeRotationByOrientation:orientation];  
    [UIView commitAnimations]; 
}


#pragma mark - SinaWeibo Delegate
- (void) addShareView
{
    self.clipsToBounds = TRUE;
    CGFloat xWidth = self.bounds.size.width;
    CGFloat yheight=self.bounds.size.height;
    _commentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, xWidth, yheight)];
    _commentView.layer.masksToBounds= YES;
    _commentView.layer.cornerRadius = 6.0;
    //    _commentView.layer.borderWidth = 1.0;
    _commentView.backgroundColor = [UIColor colorWithHex:0x3D89BF];
    [self addSubview:_commentView];
    
    UIButton *quXiaoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [quXiaoButton setFrame:CGRectMake(5, 5, 60, 30)];
    [quXiaoButton setTitle:@"取消" forState:UIControlStateNormal];
    [quXiaoButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [quXiaoButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_commentView addSubview:quXiaoButton];
    
    UIButton *fenXiangButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [fenXiangButton setFrame:CGRectMake(xWidth-65, 5, 60, 30)];
    [fenXiangButton setTitle:@"评论" forState:UIControlStateNormal];
    [fenXiangButton addTarget:self action:@selector(sendShare:) forControlEvents:UIControlEventTouchUpInside];
    [fenXiangButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_commentView addSubview:fenXiangButton];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(55, 5, xWidth-110, 30)]autorelease];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"我的评论";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:[[UIFont familyNames] objectAtIndex:0] size:16];
    [_commentView addSubview:label];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 40, xWidth-10, 120)];
    _textView.layer.cornerRadius = 6.0;
    [_textView becomeFirstResponder];
    [_textView setTextAlignment:UITextAlignmentLeft];
    [_textView setBackgroundColor:[UIColor whiteColor]];
    [_textView becomeFirstResponder];
    _textView.keyboardType = UIKeyboardTypeDefault;
    [_commentView addSubview:_textView];
    self.textView.text=@"#苏州房产搜索#这是我的评论";
    [self addSubview:_commentView];
    _overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    [_overlayView addTarget:self
                     action:@selector(dismiss)
           forControlEvents:UIControlEventTouchUpInside];
}

//发送按钮回调方法
- (void) sendShare:(UIButton*) sender
{

    
    [self dismiss];
}

#pragma mark - animations

- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}
- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [_overlayView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2.0f);
    [self fadeIn];
}

- (void)dismiss
{
    [self fadeOut];
    [_commentView removeFromSuperview];
}


@end
