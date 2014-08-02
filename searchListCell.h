//
//  searchListCell.h
//  szfc
//
//  Created by tao xu on 13-7-30.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchListCell : UITableViewCell{
    IBOutlet UILabel* BuildName;
    IBOutlet UILabel* AreaName;
    IBOutlet UILabel* PriceAverage;
    IBOutlet UILabel* AgioName;
    IBOutlet UILabel* MinPay;
    IBOutlet UILabel* MaxRepay;
    
    IBOutlet UIImageView* LdpiPhoto;
}
@property (nonatomic,copy) NSString *BuildNameText;
@property (nonatomic,copy) NSString *AreaNameText;
@property (nonatomic,copy) NSString *PriceAverageText;
@property (nonatomic,copy) NSString *AgioNameText;
@property (nonatomic,copy) NSString *MinPayText;
@property (nonatomic,copy) NSString *MaxRepayText;

@property (nonatomic,copy) NSString *LdpiPhotoUrl;
@end
