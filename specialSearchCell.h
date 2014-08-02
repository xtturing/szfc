//
//  specialSearchCell.h
//  szfc
//
//  Created by tao xu on 13-7-27.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface specialSearchCell : UITableViewCell{
    IBOutlet UILabel *BuildName;
    IBOutlet UILabel *AreaName;
    IBOutlet UILabel *PriceAverage;
    IBOutlet UILabel *DecName;
    IBOutlet UILabel *LocalRange;
    IBOutlet UILabel *AgioName;
    IBOutlet UIImageView *LdpiPhoto;
}
@property (nonatomic,copy) NSString *BuildNameText;
@property (nonatomic,copy) NSString *AreaNameText;
@property (nonatomic,copy) NSString *PriceAverageText;
@property (nonatomic,copy) NSString *DecNameText;
@property (nonatomic,copy) NSString *LocalRangeText;
@property (nonatomic,copy) NSString *AgioNameText;
@property (nonatomic,copy) NSString *LdpiPhotourl;
@end
