//
//  detailParameterCell.h
//  szfc
//
//  Created by tao xu on 13-7-30.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailParameterCell : UITableViewCell{
    IBOutlet UILabel* Kindergarten;
    IBOutlet UILabel* JuniorSchool;
    IBOutlet UILabel* MiddleSchool;
    IBOutlet UILabel* SubWay;
    IBOutlet UILabel* Transit;
    
    IBOutlet UILabel* Elevated;
    IBOutlet UILabel* LifeSupport;
    IBOutlet UILabel* ShopCenter;
    IBOutlet UILabel* ShopMall;
    IBOutlet UILabel* MedicalCenter;
    
    IBOutlet UILabel* DeveloperName;
    IBOutlet UILabel* HouseNum;
    IBOutlet UILabel* ProType;
    
    IBOutlet UILabel* UnitDesign;
    IBOutlet UILabel* RoomRange;
    IBOutlet UILabel* RoomRate;
    IBOutlet UILabel* SqmType;
    IBOutlet UILabel* FacadeStyle;
    
    IBOutlet UILabel* DecType;
    IBOutlet UILabel* DecNum;
    IBOutlet UILabel* ProCompany;
    IBOutlet UILabel* ProFee;
    IBOutlet UILabel* PriceType;
    
    IBOutlet UILabel* SaleIntr;
    IBOutlet UILabel* OverIntr;
    IBOutlet UILabel* OverDate;
    IBOutlet UILabel* RightYear;
    IBOutlet UILabel* FloorSpace;
    
    IBOutlet UILabel* BuildSpace;
    IBOutlet UILabel* PlotRate;
    IBOutlet UILabel* GreenRate;
    IBOutlet UILabel* ParkThan;
    
}
 @property(nonatomic,copy) NSString * KindergartenText;
 @property(nonatomic,copy) NSString * JuniorSchoolText;
 @property(nonatomic,copy) NSString * MiddleSchoolText;
 @property(nonatomic,copy) NSString * SubWayText;
 @property(nonatomic,copy) NSString * TransitText;

 @property(nonatomic,copy) NSString * ElevatedText;
 @property(nonatomic,copy) NSString * LifeSupportText;
 @property(nonatomic,copy) NSString * ShopCenterText;
 @property(nonatomic,copy) NSString * ShopMallText;
 @property(nonatomic,copy) NSString * MedicalCenterText;

 @property(nonatomic,copy) NSString * DeveloperNameText;
 @property(nonatomic,copy) NSString * HouseNumText;
 @property(nonatomic,copy) NSString * ProTypeText;


 @property(nonatomic,copy) NSString * UnitDesignText;
 @property(nonatomic,copy) NSString * RoomRangeText;
 @property(nonatomic,copy) NSString * RoomRateText;
 @property(nonatomic,copy) NSString * SqmTypeText;
 @property(nonatomic,copy) NSString * FacadeStyleText;

 @property(nonatomic,copy) NSString * DecTypeText;
 @property(nonatomic,copy) NSString * DecNumText;
 @property(nonatomic,copy) NSString * ProCompanyText;
 @property(nonatomic,copy) NSString * ProFeeText;
 @property(nonatomic,copy) NSString * PriceTypeText;

 @property(nonatomic,copy) NSString * SaleIntrText;
 @property(nonatomic,copy) NSString * OverIntrText;
 @property(nonatomic,copy) NSString * OverDateText;
 @property(nonatomic,copy) NSString * RightYearText;
 @property(nonatomic,copy) NSString * FloorSpaceText;

 @property(nonatomic,copy) NSString * BuildSpaceText;
 @property(nonatomic,copy) NSString * PlotRateText;
 @property(nonatomic,copy) NSString * GreenRateText;
 @property(nonatomic,copy) NSString * ParkThanText;

@end
