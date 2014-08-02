//
//  detailParameterCell.m
//  szfc
//
//  Created by tao xu on 13-7-30.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "detailParameterCell.h"

@implementation detailParameterCell
@synthesize KindergartenText,JuniorSchoolText,MiddleSchoolText,SubWayText,TransitText,ElevatedText,LifeSupportText,ShopCenterText,ShopMallText,MedicalCenterText,DeveloperNameText,HouseNumText,ProTypeText,UnitDesignText,RoomRangeText, RoomRateText, SqmTypeText,FacadeStyleText,DecTypeText, DecNumText, ProCompanyText,ProFeeText,PriceTypeText,SaleIntrText,OverIntrText,OverDateText,RightYearText,FloorSpaceText,BuildSpaceText,PlotRateText,GreenRateText,ParkThanText;
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
-(void)setParkThanText:(NSString *)text{
    if(![text isEqualToString:ParkThanText]){
        ParkThanText=[text copy];
        ParkThan.text=ParkThanText;
    }
}
-(void)setGreenRateText:(NSString *)text{
    if(![text isEqualToString:GreenRateText]){
        GreenRateText=[text copy];
        GreenRate.text=GreenRateText;
    }
}
-(void)setPlotRateText:(NSString *)text{
    if(![text isEqualToString:PlotRateText]){
        PlotRateText=[text copy];
        PlotRate.text=PlotRateText;
    }
}
-(void)setBuildSpaceText:(NSString *)text{
    if(![text isEqualToString:BuildSpaceText]){
        BuildSpaceText=[text copy];
        BuildSpace.text=BuildSpaceText;
    }
}
-(void)setFloorSpaceText:(NSString *)text{
    if(![text isEqualToString:FloorSpaceText]){
        FloorSpaceText=[text copy];
        FloorSpace.text=FloorSpaceText;
    }
}
-(void)setRightYearText:(NSString *)text{
    if(![text isEqualToString:RightYearText]){
        RightYearText=[text copy];
        RightYear.text=RightYearText;
    }
}
-(void)setOverDateText:(NSString *)text{
    if(![text isEqualToString:OverDateText]){
        OverDateText=[text copy];
        OverDate.text=OverDateText;
    }
}
-(void)setOverIntrText:(NSString *)text{
    if(![text isEqualToString:OverIntrText]){
        OverIntrText=[text copy];
        OverIntr.text=OverIntrText;
    }
}
-(void)setSaleIntrText:(NSString *)text{
    if(![text isEqualToString:SaleIntrText]){
        SaleIntrText=[text copy];
        SaleIntr.text=SaleIntrText;
    }
}
-(void)setPriceTypeText:(NSString *)text{
    if(![text isEqualToString:PriceTypeText]){
        PriceTypeText=[text copy];
        PriceType.text=PriceTypeText;
    }
}
-(void)setProFeeText:(NSString *)text{
    if(![text isEqualToString:ProFeeText]){
        ProFeeText=[text copy];
        ProFee.text=ProFeeText;
    }
}
-(void)setProCompanyText:(NSString *)text{
    if(![text isEqualToString:ProCompanyText]){
        ProCompanyText=[text copy];
        ProCompany.text=ProCompanyText;
    }
}
-(void)setDecNumText:(NSString *)text{
    if(![text isEqualToString:DecNumText]){
        DecNumText=[text copy];
        DecNum.text=DecNumText;
    }
}
-(void)setDecTypeText:(NSString *)text{
    if(![text isEqualToString:DecTypeText]){
        DecTypeText=[text copy];
        DecType.text=DecTypeText;
    }
}
-(void)setFacadeStyleText:(NSString *)text{
    if(![text isEqualToString:FacadeStyleText]){
        FacadeStyleText=[text copy];
        FacadeStyle.text=FacadeStyleText;
    }
}
-(void)setSqmTypeText:(NSString *)text{
    if(![text isEqualToString:SqmTypeText]){
        SqmTypeText=[text copy];
        SqmType.text=SqmTypeText;
    }
}
-(void)setRoomRateText:(NSString *)text{
    if(![text isEqualToString:RoomRateText]){
        RoomRateText=[text copy];
        RoomRate.text=RoomRateText;
    }
}
-(void)setRoomRangeText:(NSString *)text{
    if(![text isEqualToString:RoomRangeText]){
        RoomRangeText=[text copy];
        RoomRange.text=RoomRangeText;
    }
}
-(void)setUnitDesignText:(NSString *)text{
    if(![text isEqualToString:UnitDesignText]){
        UnitDesignText=[text copy];
        UnitDesign.text=UnitDesignText;
    }
}
-(void)setProTypeText:(NSString *)text{
    if(![text isEqualToString:ProTypeText]){
        ProTypeText=[text copy];
        ProType.text=ProTypeText;
    }
}
-(void)setHouseNumText:(NSString *)text{
    if(![text isEqualToString:HouseNumText]){
        HouseNumText=[text copy];
        HouseNum.text=HouseNumText;
    }
}
-(void)setDeveloperNameText:(NSString *)text{
    if(![text isEqualToString:DeveloperNameText]){
        DeveloperNameText=[text copy];
        DeveloperName.text=DeveloperNameText;
    }
}
-(void)setMedicalCenterText:(NSString *)text{
    if(![text isEqualToString:MedicalCenterText]){
        MedicalCenterText=[text copy];
        MedicalCenter.text=MedicalCenterText;
    }
}
-(void)setShopMallText:(NSString *)text{
    if(![text isEqualToString:ShopMallText]){
        ShopMallText=[text copy];
        ShopMall.text=ShopMallText;
    }
}
-(void)setShopCenterText:(NSString *)text{
    if(![text isEqualToString:ShopCenterText]){
        ShopCenterText=[text copy];
        ShopCenter.text=ShopCenterText;
    }
}
-(void)setLifeSupportText:(NSString *)text{
    if(![text isEqualToString:LifeSupportText]){
        LifeSupportText=[text copy];
        LifeSupport.text=LifeSupportText;
    }
}
-(void)setElevatedText:(NSString *)text{
    if(![text isEqualToString:ElevatedText]){
        ElevatedText=[text copy];
        Elevated.text=ElevatedText;
    }
}
-(void)setTransitText:(NSString *)text{
    if(![text isEqualToString:TransitText]){
        TransitText=[text copy];
        Transit.text=TransitText;
    }
}
-(void)setSubWayText:(NSString *)text{
    if(![text isEqualToString:SubWayText]){
        SubWayText=[text copy];
        SubWay.text=SubWayText;
    }
}
-(void)setMiddleSchoolText:(NSString *)text{
    if(![text isEqualToString:MiddleSchoolText]){
        MiddleSchoolText=[text copy];
        MiddleSchool.text=MiddleSchoolText;
    }
}
-(void)setJuniorSchoolText:(NSString *)text{
    if(![text isEqualToString:JuniorSchoolText]){
        JuniorSchoolText=[text copy];
        JuniorSchool.text=JuniorSchoolText;
    }
}
-(void)setKindergartenText:(NSString *)text{
    if(![text isEqualToString:KindergartenText]){
        KindergartenText=[text copy];
        Kindergarten.text=KindergartenText;
    }
}
@end
