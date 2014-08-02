//
//  buttonCell.m
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "buttonCell.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
@implementation buttonCell
@synthesize CommentNumText,TransmitNumText,PraiseNumText,delegate;
@synthesize cellIndexPath;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(IBAction)comment:(id)sender{
    if ([delegate respondsToSelector:@selector(didComment:indexPath:)]) {
        [delegate didComment:self indexPath:cellIndexPath];
    }
}
-(IBAction)praise:(id)sender{
    if ([delegate respondsToSelector:@selector(didPraise:indexPath:)]) {
        [delegate didPraise:self indexPath:cellIndexPath];
    }
}
-(IBAction)reply:(id)sender{
    if ([delegate respondsToSelector:@selector(didReply:indexPath:)]) {
        [delegate didReply:self indexPath:cellIndexPath];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCellIndexPath:(NSIndexPath *)IndexPath{
     cellIndexPath=[IndexPath retain];
}
-(void)setCommentNumText:(NSString *)text{
    if(![text isEqualToString:CommentNumText]){
        CommentNumText=[text copy];
        [CommentNum setTitle:CommentNumText forState:UIControlStateNormal ];
    }
}
-(void)setTransmitNumText:(NSString *)text{
    if(![text isEqualToString:TransmitNumText]){
        TransmitNumText=[text copy];
        [TransmitNum setTitle:TransmitNumText forState:UIControlStateNormal ];
    }
}
-(void)setPraiseNumText:(NSString *)text{
    if(![text isEqualToString:PraiseNumText]){
        PraiseNumText=[text copy];
        [PraiseNum setTitle:PraiseNumText forState:UIControlStateNormal ];
    }
}
@end
