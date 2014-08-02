//
//  erweiView.h
//  szfc
//
//  Created by tao xu on 13-8-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface erweiView : UIView{
    UIView *_shareView; 
    UIControl   *_overlayView;
}
@property (strong, nonatomic) UIView *shareView;
- (void)show;
- (void)dismiss;
@end
