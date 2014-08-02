//
//  replyCell.m
//  房伴
//
//  Created by tao xu on 13-8-26.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "replyCell.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
@implementation replyCell
@synthesize ReplyNickText,ReplyIntrText,AddTimeText,UserLdpiPhotoUrl,AtNickText,delegate;
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
    if ([delegate respondsToSelector:@selector(didReply:indexPath:)]) {
        [delegate didReply:self indexPath:cellIndexPath];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setAtNickText:(NSString *)text{
    if(![text isEqualToString:AtNickText]){
        AtNickText=[text copy];
        AtNick.text=AtNickText;
    }
}
-(void)setAddTimeText:(NSString *)text{
    if(![text isEqualToString:AddTimeText]){
        AddTimeText=[text copy];
        AddTime.text=AddTimeText;
    }
}
-(void)setReplyNickText:(NSString *)text{
    if(![text isEqualToString:ReplyNickText]){
        ReplyNickText=[text copy];
        ReplyNick.text=ReplyNickText;
    }
}
-(void)setReplyIntrText:(NSString *)text{
    if(![text isEqualToString:ReplyIntrText]){
        ReplyIntrText=[text copy];
        ReplyIntr.text=ReplyIntrText;
    }
}
-(void)setUserLdpiPhotoUrl:(NSString *)url{
    CALayer * layer = [UserLdpiPhoto layer];  
    [layer setMasksToBounds:YES];  
    [layer setCornerRadius:6.0];  
    [layer setBorderWidth:1.0];  
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    if(url.length>0){
        if(![url isEqualToString:UserLdpiPhotoUrl]){
            UserLdpiPhotoUrl=[url copy];              
            [UserLdpiPhoto setImageWithURL:[NSURL URLWithString:UserLdpiPhotoUrl]];
            
        } 
    }
    
}

@end
