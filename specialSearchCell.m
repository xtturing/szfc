//
//  specialSearchCell.m
//  szfc
//
//  Created by tao xu on 13-7-27.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "specialSearchCell.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
@implementation specialSearchCell
@synthesize AgioNameText,AreaNameText,BuildNameText,DecNameText,PriceAverageText,LdpiPhotourl,LocalRangeText;
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
-(void)setAgioNameText:(NSString *)text{
    if(![text isEqualToString:AgioNameText]){
        AgioNameText=[text copy];
        AgioName.text=AgioNameText;
    }
}
-(void)setAreaNameText:(NSString *)text{
    if(![text isEqualToString:AreaNameText]){
        AreaNameText=[text copy];
        AreaName.text=AreaNameText;
    }
}
-(void)setBuildNameText:(NSString *)text{
    if(![text isEqualToString:BuildNameText]){
        BuildNameText=[text copy];
        BuildName.text=BuildNameText;
    }
}
-(void)setDecNameText:(NSString *)text{
    if(![text isEqualToString:DecNameText]){
        DecNameText=[text copy];
        DecName.text=DecNameText;
    }
}
-(void)setPriceAverageText:(NSString *)text{
    if(![text isEqualToString:PriceAverageText]){
        PriceAverageText=[text copy];
        PriceAverage.text=[NSString stringWithFormat:@"均价：%@ 元/平米",PriceAverageText];
    }
}
-(void)setLocalRangeText:(NSString *)text{
    if(![text isEqualToString:LocalRangeText]){
        LocalRangeText=[text copy];
        LocalRange.text=[NSString stringWithFormat:@"%@千米",LocalRangeText];
    }
}
-(void)setLdpiPhotourl:(NSString *)url{
    CALayer * layer = [LdpiPhoto layer];  
    [layer setMasksToBounds:YES];  
    [layer setCornerRadius:6.0];  
    [layer setBorderWidth:1.0];  
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    if(url.length>0){
        if(![url isEqualToString:LdpiPhotourl]){
            LdpiPhotourl=[url copy];              
            [LdpiPhoto setImageWithURL:[NSURL URLWithString:LdpiPhotourl]];
            
        } 
    }

}
@end
