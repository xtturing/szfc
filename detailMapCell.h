//
//  detailMapCell.h
//  szfc
//
//  Created by tao xu on 13-7-30.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface detailMapCell : UITableViewCell<BMKMapViewDelegate>{
    IBOutlet BMKMapView* _mapView;
    IBOutlet UILabel *address;
}
@property(nonatomic,assign) double lat;
@property(nonatomic,assign) double lon;
@property(nonatomic,retain) NSString *addressText;
@end
