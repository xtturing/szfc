//
//  mapViewController.h
//  szfc
//
//  Created by tao xu on 13-8-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface mapViewController : UIViewController<BMKMapViewDelegate,UISearchBarDelegate,BMKSearchDelegate>{
    IBOutlet BMKMapView* _mapView;
    BMKSearch* _search;
    CLLocationCoordinate2D gpsC;
    CLLocationCoordinate2D coor;
}
@property(nonatomic,assign) double lat;
@property(nonatomic,assign) double lon;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *address;
@end
