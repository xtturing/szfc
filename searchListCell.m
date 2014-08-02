//
//  searchListCell.m
//  szfc
//
//  Created by tao xu on 13-7-30.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "searchListCell.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
@implementation searchListCell
@synthesize BuildNameText,AreaNameText,PriceAverageText,AgioNameText,MinPayText,MaxRepayText,LdpiPhotoUrl;
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

-(void)setBuildNameText:(NSString *)text{
    if(![text isEqualToString:BuildNameText]){
        BuildNameText=[text copy];
        BuildName.text=BuildNameText;
    }
}
-(void)setAreaNameText:(NSString *)text{
    if(![text isEqualToString:AreaNameText]){
        AreaNameText=[text copy];
        AreaName.text=AreaNameText;
    }
}
-(void)setPriceAverageText:(NSString *)text{
    if(![text isEqualToString:PriceAverageText]){
        PriceAverageText=[text copy];
        PriceAverage.text=[NSString stringWithFormat:@"%@元/平米",PriceAverageText];
    }
}
-(void)setAgioNameText:(NSString *)text{
    if(![text isEqualToString:AgioNameText]){
        AgioNameText=[text copy];
        AgioName.text=AgioNameText;
    }
}
-(void)setMinPayText:(NSString *)text{
    if(![text isEqualToString:MinPayText]){
        MinPayText=[text copy];
        MinPay.text=[NSString stringWithFormat:@"最低首付：%@万",MinPayText];
    }
}
-(void)setMaxRepayText:(NSString *)text{
    if(![text isEqualToString:MaxRepayText]){
        MaxRepayText=[text copy];
        MaxRepay.text=[NSString stringWithFormat:@"最高月供：%@元",MaxRepayText];
    }
}
-(void)setLdpiPhotoUrl:(NSString *)url{
    CALayer * layer = [LdpiPhoto layer];  
    [layer setMasksToBounds:YES];  
    [layer setCornerRadius:6.0];  
    [layer setBorderWidth:1.0];  
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    if(url.length>0){
        if(![url isEqualToString:LdpiPhotoUrl]){
            LdpiPhotoUrl=[url copy];              
            [LdpiPhoto setImageWithURL:[NSURL URLWithString:LdpiPhotoUrl]];
            
        } 
    }

}
  
@end
