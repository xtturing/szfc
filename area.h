//
//  area.h
//  房伴
//
//  Created by tao xu on 13-8-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionaryAdditions.h"
@interface area : NSObject{
    NSString*  ID;
    NSString*  Code;
    NSString*  AreaName;
    NSString*  AreaInitial;
    NSString*  TypeName;
    NSString*  FatherName;
}

@property (nonatomic, retain) NSString*  ID;
@property (nonatomic, retain) NSString*  Code;
@property (nonatomic, retain) NSString*  AreaName;
@property (nonatomic, retain) NSString*  AreaInitial;
@property (nonatomic, retain) NSString*  TypeName;
@property (nonatomic, retain) NSString*  FatherName;


- (area*)initWithJsonDictionary:(NSDictionary*)dic;

+ (area*)areaWithJsonDictionary:(NSDictionary*)dic;
@end
