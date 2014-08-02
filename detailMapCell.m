//
//  detailMapCell.m
//  szfc
//
//  Created by tao xu on 13-7-30.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "detailMapCell.h"

BMKPointAnnotation* annotation;
@implementation detailMapCell
@synthesize lat,lon,addressText;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _mapView.delegate = self;
        if (annotation == nil) {
            annotation = [[[BMKPointAnnotation alloc]init] autorelease];
            
            CLLocationCoordinate2D coor;
            coor.latitude = self.lat;
            coor.longitude = self.lon;
            annotation.coordinate = coor;
            
            annotation.title = @"test";
            annotation.subtitle = @"此Annotation可拖拽!";
            [_mapView addAnnotation:annotation];
            [_mapView setCenterCoordinate:coor animated:YES];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setLat:(double)l{
    lat=l;
}
-(void)setLon:(double)l{
    lon=l;
}
-(void)setAddressText:(NSString *)text{
    address.text=text;
}
-(void) viewDidAppear:(BOOL)animated {
        // 添加一个PointAnnotation
    if (annotation == nil) {
        annotation = [[[BMKPointAnnotation alloc]init] autorelease];
        
        CLLocationCoordinate2D coor;
        coor.latitude = self.lat;
        coor.longitude = self.lon;
        annotation.coordinate = coor;
        
        annotation.title = @"test";
        annotation.subtitle = @"此Annotation可拖拽!";
        [_mapView addAnnotation:annotation];
        [_mapView setCenterCoordinate:coor animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
#pragma mark -
#pragma mark implement BMKMapViewDelegate

// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"renameMark";
	
    // 检查是否有重用的缓存
    BMKAnnotationView* newAnnotation = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    if (newAnnotation == nil) {
        newAnnotation = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease];
        // 设置颜色
		((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
        // 从天上掉下效果
		((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;
        // 设置可拖拽
		((BMKPinAnnotationView*)newAnnotation).draggable = YES;
		return newAnnotation;
    }
    
	return nil;
}

// Override
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"paopaoclick");
}
//- (void)dealloc {
//    [super dealloc];
//    if (_mapView) {
//        [_mapView release];
//        _mapView = nil;
//    }
//}
@end
