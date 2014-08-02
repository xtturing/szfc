//
//  MMGridViewLogCell.m
//  szfc
//
//  Created by tao xu on 13-8-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MMGridViewLogCell.h"

@implementation MMGridViewLogCell
@synthesize backgroundView,image,textLabel,detailLabel,timeLabel;
- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) {
        // Background view
        self.backgroundView = [[[UIView alloc] initWithFrame:CGRectNull] autorelease];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundView];
        UIImageView *up=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_plank_dow.png"]] autorelease ];
        up.frame=CGRectMake(0, 0, 150, 5);
        [self.backgroundView addSubview:up];
        UIImageView *among=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_plank_among.png"]] autorelease];
        among.frame=CGRectMake(0, 5, 150,151);
        [self.backgroundView addSubview:among];
        UIImageView *down=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_plank_down.png"]] autorelease];
        down.frame=CGRectMake(0, 156, 150, 34);
        [self.backgroundView addSubview:down];
        self.textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(9, 5, 120, 21)] autorelease];
        self.textLabel.textAlignment = UITextAlignmentLeft;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor orangeColor];
        self.textLabel.font = [UIFont systemFontOfSize:12];
        [self.backgroundView addSubview:self.textLabel];
        
        self.detailLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 30, 120, 120)] autorelease];
        self.detailLabel.textAlignment = UITextAlignmentLeft;
        self.detailLabel.numberOfLines=0;
        self.detailLabel.backgroundColor = [UIColor clearColor];
        self.detailLabel.textColor = [UIColor darkGrayColor];
        self.detailLabel.font = [UIFont systemFontOfSize:9];
        [self.backgroundView addSubview:self.detailLabel];
        
        self.timeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(40, 165, 100, 15)] autorelease];
        self.timeLabel.textAlignment = UITextAlignmentRight;
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.textColor = [UIColor colorWithHex:0x3D89BF];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        [self.backgroundView addSubview:self.timeLabel];
        image=[[[UIImageView alloc] initWithFrame:CGRectMake(9, 160, 30, 30)] autorelease];
        [self.backgroundView addSubview:image];
        [self addSubview:self.backgroundView];
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Background view
    self.backgroundView.frame = self.bounds;
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}


@end
