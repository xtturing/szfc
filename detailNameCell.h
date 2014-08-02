//
//  detailNameCell.h
//  szfc
//
//  Created by tao xu on 13-7-30.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailNameCell : UITableViewCell{
    IBOutlet UILabel* BuildName;
    IBOutlet UILabel* AgioName;
    IBOutlet UILabel* AreaName;
    IBOutlet UILabel* DecType;
    IBOutlet UILabel* PriceAverage;
    IBOutlet UILabel* Address;
}
@property(nonatomic,copy) NSString *BuildNameText;
@property(nonatomic,copy) NSString *AgioNameText;
@property(nonatomic,copy) NSString *AreaNameText;
@property(nonatomic,copy) NSString *DecTypeText;
@property(nonatomic,copy) NSString *PriceAverageText;
@property(nonatomic,copy) NSString *AddressText;
@end
