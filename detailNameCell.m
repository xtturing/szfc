//
//  detailNameCell.m
//  szfc
//
//  Created by tao xu on 13-7-30.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "detailNameCell.h"

@implementation detailNameCell
@synthesize BuildNameText,AgioNameText,AreaNameText,DecTypeText,PriceAverageText,AddressText;
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
-(void)setDecTypeText:(NSString *)text{
    if(![text isEqualToString:DecTypeText]){
        DecTypeText=[text copy];
        DecType.text=DecTypeText;
    }
}
-(void)setPriceAverageText:(NSString *)text{
    if(![text isEqualToString:PriceAverageText]){
        PriceAverageText=[text copy];
        PriceAverage.text=PriceAverageText;
    }
}
-(void)setAddressText:(NSString *)text{
    if(![text isEqualToString:AddressText]){
        AddressText=[text copy];
        Address.text=AddressText;
    }
}
@end
