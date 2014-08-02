//
//  erweiView.m
//  szfc
//
//  Created by tao xu on 13-8-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "erweiView.h"
#import <QuartzCore/QuartzCore.h>
@interface erweiView()
- (void)defalutInit;
- (void)fadeIn;
- (void)fadeOut;
@end
@implementation erweiView
@synthesize shareView = _shareView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self defalutInit];
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

- (void)defalutInit
{
    self.clipsToBounds = TRUE;
    CGFloat xWidth = self.bounds.size.width;
    CGFloat yheight=self.bounds.size.height;
    _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, xWidth, yheight)];
    _shareView.layer.masksToBounds= YES;
    _shareView.layer.cornerRadius = 6.0;
    //    _shareView.layer.borderWidth = 1.0;
    _shareView.backgroundColor =[UIColor whiteColor];
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"20130805070008383_easyicon_net_48.png"]];
    image.frame= CGRectMake(5.0, 5.0, xWidth-10, yheight-10);
    [_shareView addSubview:image];
    [self addSubview:_shareView];
    _overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    [_overlayView addTarget:self
                     action:@selector(dismiss)
           forControlEvents:UIControlEventTouchUpInside];
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
    [_shareView removeFromSuperview];
}

@end
