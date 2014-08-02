//
//  buildDetail.m
//  房伴
//
//  Created by tao xu on 13-8-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "buildDetail.h"
#import "huType.h"
@implementation buildDetail
@synthesize Id,Code,BuildName,AgioType,AgioName,BuildPhone,CityName, AreaName,Kindergarten,JuniorSchool, MiddleSchool,SubWay,Transit,Elevated, LifeSupport,ShopCenter,ShopMall,MedicalCenter, DeveloperType, DeveloperName, HouseScale,HouseNum,UnitDesign, RoomRange,RoomRate,SqmType,FacadeStyle,DecType,DecNum,ProType,ProCompany,ProFee,PriceAverage, PriceType,MinPayment,MaxPayment,SaleIntr,OverIntr, OverDate, Address,Latitude,Longitude,RightYear,FloorSpace,BuildSpace,PlotRate,GreenRate,ParkThan,FavNum,huTypeList;

-(buildDetail*)initWithJsonDictionary:(NSDictionary*)dic{
    if (self = [super init]) {
        Id=[[dic getStringValueForKey:@"Id" defaultValue:@""] retain];
        Code=[[dic getStringValueForKey:@"Code" defaultValue:@""] retain];
        BuildName=[[dic getStringValueForKey:@"BuildName" defaultValue:@""] retain];
        AreaName=[[dic getStringValueForKey:@"AreaName" defaultValue:@""] retain];
        
        AgioType=[[dic getStringValueForKey:@"AgioType" defaultValue:@""] retain];
        AgioName=[[dic getStringValueForKey:@"AgioName" defaultValue:@""] retain];
        BuildPhone=[[dic getStringValueForKey:@"BuildPhone" defaultValue:@""] retain];
        CityName=[[dic getStringValueForKey:@"CityName" defaultValue:@""] retain];
        Kindergarten=[[dic getStringValueForKey:@"Kindergarten" defaultValue:@""] retain];
        
        JuniorSchool=[[dic getStringValueForKey:@"JuniorSchool" defaultValue:@""] retain];
        MiddleSchool=[[dic getStringValueForKey:@"MiddleSchool" defaultValue:@""] retain];
        SubWay=[[dic getStringValueForKey:@"SubWay" defaultValue:@""] retain];
        Transit=[[dic getStringValueForKey:@"Transit" defaultValue:@""] retain];
        Elevated=[[dic getStringValueForKey:@"Elevated" defaultValue:@""] retain];
        
        LifeSupport=[[dic getStringValueForKey:@"LifeSupport" defaultValue:@""] retain];
        ShopCenter=[[dic getStringValueForKey:@"ShopCenter" defaultValue:@""] retain];
        ShopMall=[[dic getStringValueForKey:@"ShopMall" defaultValue:@""] retain];
        MedicalCenter=[[dic getStringValueForKey:@"MedicalCenter" defaultValue:@""] retain];
        DeveloperType=[[dic getStringValueForKey:@"DeveloperType" defaultValue:@""] retain];
        
        DeveloperName=[[dic getStringValueForKey:@"DeveloperName" defaultValue:@""] retain];
        HouseScale=[[dic getStringValueForKey:@"HouseScale" defaultValue:@""] retain];
        HouseNum=[[dic getStringValueForKey:@"HouseNum" defaultValue:@""] retain];
        UnitDesign=[[dic getStringValueForKey:@"UnitDesign" defaultValue:@""] retain];
        RoomRange=[[dic getStringValueForKey:@"RoomRange" defaultValue:@""] retain];
        
        RoomRate=[[dic getStringValueForKey:@"RoomRate" defaultValue:@""] retain];
        SqmType=[[dic getStringValueForKey:@"SqmType" defaultValue:@""] retain];
        FacadeStyle=[[dic getStringValueForKey:@"FacadeStyle" defaultValue:@""] retain];
        DecType=[[dic getStringValueForKey:@"DecType" defaultValue:@""] retain];
        DecNum=[[dic getStringValueForKey:@"DecNum" defaultValue:@""] retain];
        
        ProType=[[dic getStringValueForKey:@"ProType" defaultValue:@""] retain];
        ProCompany=[[dic getStringValueForKey:@"ProCompany" defaultValue:@""] retain];
        ProFee=[[dic getStringValueForKey:@"ProFee" defaultValue:@""] retain];
        PriceAverage=[[dic getStringValueForKey:@"PriceAverage" defaultValue:@""] retain];
        PriceType=[[dic getStringValueForKey:@"PriceType" defaultValue:@""] retain];
        
        MinPayment=[[dic getStringValueForKey:@"MinPayment" defaultValue:@""] retain];
        MaxPayment=[[dic getStringValueForKey:@"MaxPayment" defaultValue:@""] retain];
        SaleIntr=[[dic getStringValueForKey:@"SaleIntr" defaultValue:@""] retain];
        OverIntr=[[dic getStringValueForKey:@"OverIntr" defaultValue:@""] retain];
        OverDate=[[dic getStringValueForKey:@"OverDate" defaultValue:@""] retain];
        
        Address=[[dic getStringValueForKey:@"Address" defaultValue:@""] retain];
        Latitude=[[dic getStringValueForKey:@"Latitude" defaultValue:@""] retain];
        Longitude=[[dic getStringValueForKey:@"Longitude" defaultValue:@""] retain];
        RightYear=[[dic getStringValueForKey:@"RightYear" defaultValue:@""] retain];
        FloorSpace=[[dic getStringValueForKey:@"FloorSpace" defaultValue:@""] retain];
        
        BuildSpace=[[dic getStringValueForKey:@"BuildSpace" defaultValue:@""] retain];
        PlotRate=[[dic getStringValueForKey:@"PlotRate" defaultValue:@""] retain];
        GreenRate=[[dic getStringValueForKey:@"GreenRate" defaultValue:@""] retain];
        ParkThan=[[dic getStringValueForKey:@"ParkThan" defaultValue:@""] retain];
        FavNum=[[dic getStringValueForKey:@"FavNum" defaultValue:@""] retain];
        huTypeList=[[NSArray alloc] init];
    }
	return self;
}
+(buildDetail*)buildDetailWithJsonDictionary:(NSDictionary*)dic{
      return [[[buildDetail alloc] initWithJsonDictionary:dic] autorelease];
}
-(void)dealloc{
    [Id release];[Code release];[BuildName release];[AgioType release];[AgioName release];[BuildPhone release];[CityName release];[ AreaName release];[Kindergarten release];[JuniorSchool release];[ MiddleSchool release];[SubWay release];[Transit release];[Elevated release];[ LifeSupport release];[ShopCenter release];[ShopMall release];[MedicalCenter release];[ DeveloperType release];[ DeveloperName release];[ HouseScale release];[HouseNum release];[UnitDesign release];[ RoomRange release];[RoomRate release];[SqmType release];[FacadeStyle release];[DecType release];[DecNum release];[ProType release];[ProCompany release];[ProFee release];[PriceAverage release];[ PriceType release];[MinPayment release];[MaxPayment release];[SaleIntr release];[OverIntr release];[ OverDate release];[ Address release];[Latitude release];[Longitude release];[RightYear release];[FloorSpace release];[BuildSpace release];[PlotRate release];[GreenRate release];[ParkThan release];[FavNum release];[huTypeList release];
         
    [super dealloc];
}
@end
