//
//  buildDetail.h
//  房伴
//
//  Created by tao xu on 13-8-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionaryAdditions.h"
#import "huType.h"
@interface buildDetail : NSObject{
    NSString* Id;
    NSString* Code;
    NSString* BuildName;
    NSString* AgioType;
    NSString* AgioName;
    NSString* BuildPhone;
    
    NSString* CityName;
    NSString* AreaName;
    NSString* Kindergarten;
    NSString* JuniorSchool;
    NSString* MiddleSchool;
    
    NSString* SubWay;
    NSString* Transit;
    NSString* Elevated;
    NSString* LifeSupport;
    NSString* ShopCenter;
    
    
    NSString* ShopMall;
    NSString* MedicalCenter;
    NSString* DeveloperType;
    NSString* DeveloperName;
    NSString* HouseScale;
    
    NSString* HouseNum;
    NSString* UnitDesign;
    NSString* RoomRange;
    NSString* RoomRate;
    NSString* SqmType;
    
    NSString* FacadeStyle;
    NSString* DecType;
    NSString* DecNum;
    NSString* ProType;
    NSString* ProCompany;
    
    NSString* ProFee;
    NSString* PriceAverage;
    NSString* PriceType;
    NSString* MinPayment;
    NSString* MaxPayment;
    
    NSString* SaleIntr;
    NSString* OverIntr;
    NSString* OverDate;
    NSString* Address;
    NSString* Latitude;
    
    NSString* Longitude;
    NSString* RightYear;
    NSString* FloorSpace;
    NSString* BuildSpace;
    NSString* PlotRate;
    
    NSString* GreenRate;
    NSString* ParkThan;
    NSString* FavNum;
    NSArray* huTypeList;
}
@property (nonatomic, retain) NSString* Id;
@property (nonatomic, retain) NSString* Code;
@property (nonatomic, retain) NSString* BuildName;
@property (nonatomic, retain) NSString* AgioType;
@property (nonatomic, retain) NSString* AgioName;
@property (nonatomic, retain) NSString* BuildPhone;

@property (nonatomic, retain) NSString* CityName;
@property (nonatomic, retain) NSString* AreaName;
@property (nonatomic, retain) NSString* Kindergarten;
@property (nonatomic, retain) NSString* JuniorSchool;
@property (nonatomic, retain) NSString* MiddleSchool;

@property (nonatomic, retain) NSString* SubWay;
@property (nonatomic, retain) NSString* Transit;
@property (nonatomic, retain) NSString* Elevated;
@property (nonatomic, retain) NSString* LifeSupport;
@property (nonatomic, retain) NSString* ShopCenter;


@property (nonatomic, retain) NSString* ShopMall;
@property (nonatomic, retain) NSString* MedicalCenter;
@property (nonatomic, retain) NSString* DeveloperType;
@property (nonatomic, retain) NSString* DeveloperName;
@property (nonatomic, retain) NSString* HouseScale;

@property (nonatomic, retain) NSString* HouseNum;
@property (nonatomic, retain) NSString* UnitDesign;
@property (nonatomic, retain) NSString* RoomRange;
@property (nonatomic, retain) NSString* RoomRate;
@property (nonatomic, retain) NSString* SqmType;

@property (nonatomic, retain) NSString* FacadeStyle;
@property (nonatomic, retain) NSString* DecType;
@property (nonatomic, retain) NSString* DecNum;
@property (nonatomic, retain) NSString* ProType;
@property (nonatomic, retain) NSString* ProCompany;

@property (nonatomic, retain) NSString* ProFee;
@property (nonatomic, retain) NSString* PriceAverage;
@property (nonatomic, retain) NSString* PriceType;
@property (nonatomic, retain) NSString* MinPayment;
@property (nonatomic, retain) NSString* MaxPayment;

@property (nonatomic, retain) NSString* SaleIntr;
@property (nonatomic, retain) NSString* OverIntr;
@property (nonatomic, retain) NSString* OverDate;
@property (nonatomic, retain) NSString* Address;
@property (nonatomic, retain) NSString* Latitude;

@property (nonatomic, retain) NSString* Longitude;
@property (nonatomic, retain) NSString* RightYear;
@property (nonatomic, retain) NSString* FloorSpace;
@property (nonatomic, retain) NSString* BuildSpace;
@property (nonatomic, retain) NSString* PlotRate;

@property (nonatomic, retain) NSString* GreenRate;
@property (nonatomic, retain) NSString* ParkThan;
@property (nonatomic, retain) NSString* FavNum;
@property (nonatomic, retain) NSArray* huTypeList;

-(buildDetail*)initWithJsonDictionary:(NSDictionary*)dic;
+(buildDetail*)buildDetailWithJsonDictionary:(NSDictionary*)dic;
@end
