//
//  commentCell.m
//  szfc
//
//  Created by tao xu on 13-8-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "commentCell.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
@implementation commentCell
@synthesize ReplyNickText,ReplyIntrText,AddTimeText,UserLdpiPhotoUrl;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
