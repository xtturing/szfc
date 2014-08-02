//
//  talkCell.m
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "talkCell.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
@implementation talkCell
@synthesize MsgIntrText,MsgHdpiPhotoUrl;
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
-(void)setMsgIntrText:(NSString *)text{
    if(![text isEqualToString:MsgIntrText]){
        MsgIntrText=[text copy];
        MsgIntr.text=MsgIntrText;
    }
}
-(void)setMsgHdpiPhotoUrl:(NSString *)url{
    CALayer * layer = [MsgHdpiPhoto layer];  
    [layer setMasksToBounds:YES];  
    [layer setCornerRadius:6.0];  
    [layer setBorderWidth:1.0];  
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    if(url.length>0){
        if(![url isEqualToString:MsgHdpiPhotoUrl]){
            MsgHdpiPhotoUrl=[url copy];              
            [MsgHdpiPhoto setImageWithURL:[NSURL URLWithString:MsgHdpiPhotoUrl]];
            
        } 
    }
    
}@end
