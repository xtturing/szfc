//
//  MMGridViewLogCell.h
//  szfc
//
//  Created by tao xu on 13-8-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MMGridViewCell.h"

@interface MMGridViewLogCell : MMGridViewCell{
    UILabel *textLabel;
    UILabel *detailLabel;
    UILabel *timeLabel;
    UIImageView *image;
    UIView *backgroundView;
}

@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, retain) UILabel *detailLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) UIView *backgroundView;
@end
