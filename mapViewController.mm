//
//  mapViewController.m
//  szfc
//
//  Created by tao xu on 13-8-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "mapViewController.h"
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
@interface RouteAnnotation : BMKPointAnnotation
{
	int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
	int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end

@interface UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

@end

@implementation UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
	CGSize rotatedSize;
    
    rotatedSize.width = width;
    rotatedSize.height = height;
    
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	CGContextRotateCTM(bitmap, degrees * M_PI / 180);
	CGContextRotateCTM(bitmap, M_PI);
	CGContextScaleCTM(bitmap, -1.0, 1.0);
	CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

@end
@interface mapViewController ()

@end
BMKPointAnnotation* annotation;
@implementation mapViewController

@synthesize lat,lon,name,address;

- (NSString*)getMyBundlePath1:(NSString *)filename
{
	
	NSBundle * libBundle = MYBUNDLE ;
	if ( libBundle && filename ){
		NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
		return s;
	}
	return nil ;
}

-(void)setLat:(double)l{
    lat=l;
}
-(void)setLon:(double)l{
    lon=l;
}
-(void)setName:(NSString *)text{
    name=text;
}
-(void)setAddress:(NSString *)text{
    address=text;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];  
        backButton.frame = CGRectMake(0.0, 0.0, 36.0, 30.0);  
        [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];  
        [backButton setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];  
        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
        temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
        self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
        [temporaryBarButtonItem release];
        
        UISearchBar *searchBar = [[UISearchBar alloc] init];  
        searchBar.placeholder=@"请输入楼盘名称"; 
        UITextField *searchField = [[searchBar subviews] lastObject];
        searchField.font=[UIFont systemFontOfSize:14];
        searchBar.delegate = self;  
        searchBar.keyboardType = UIKeyboardTypeDefault;     
        for (UIView *view in searchBar.subviews)
        {
            if ([view isKindOfClass:NSClassFromString
                 (@"UISearchBarBackground")])
            {
                [view removeFromSuperview];
                break;
                
            }
        }
        [searchBar setFrame:CGRectMake(0.0, 0.0, 240,self.navigationController.navigationBar.bounds.size.height)];
        UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:searchBar]; 
        self.navigationItem.rightBarButtonItem = menuButton;   
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    _mapView.showsUserLocation = YES;
    // Do any additional setup after loading the view from its nib.
}
- (void)backAction:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES]; 
}


-(void) viewDidAppear:(BOOL)animated {
    // 添加一个PointAnnotation
    if(lat&&lon){
        annotation = [[[BMKPointAnnotation alloc]init] autorelease];
        
        coor.latitude = lat;
        coor.longitude = lon;
        annotation.coordinate = coor;
        
        annotation.title = name;
        annotation.subtitle = address;
        [_mapView addAnnotation:annotation];
        [_mapView setCenterCoordinate:coor animated:YES];
       
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _search.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
     _search.delegate = nil; // 不用时，置nil
    _mapView.showsUserLocation = NO;
}

#pragma mark -
#pragma mark implement BMKMapViewDelegate
- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
	BMKAnnotationView* view = nil;
	switch (routeAnnotation.type) {
		case 0:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 1:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 2:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 3:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 4:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"] autorelease];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
			view.annotation = routeAnnotation;
			
		}
			break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"] autorelease];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
			view.annotation = routeAnnotation;
        }
            break;
		default:
			break;
	}
	
	return view;
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[RouteAnnotation class]]) {
		return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
	}
	return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[[BMKPolylineView alloc] initWithOverlay:overlay] autorelease];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
	return nil;
}



- (void)onGetDrivingRouteResult:(BMKPlanResult*)result errorCode:(int)error
{
//    if (result != nil) {
//        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//        [_mapView removeAnnotations:array];
//        array = [NSArray arrayWithArray:_mapView.overlays];
//        [_mapView removeOverlays:array];
//        
//        // error 值的意义请参考BMKErrorCode
//        if (error == BMKErrorOk) {
//            BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
//            
//            // 添加起点
//            RouteAnnotation* item = [[RouteAnnotation alloc]init];
//            item.coordinate = result.startNode.pt;
//            item.title = @"起点";
//            item.type = 0;
//            [_mapView addAnnotation:item];
//            [item release];
//            
//            
//            // 下面开始计算路线，并添加驾车提示点
//            int index = 0;
//            int size = [plan.routes count];
//            for (int i = 0; i < 1; i++) {
//                BMKRoute* route = [plan.routes objectAtIndex:i];
//                for (int j = 0; j < route.pointsCount; j++) {
//                    int len = [route getPointsNum:j];
//                    index += len;
//                }
//            }
//            
//            BMKMapPoint* points = new BMKMapPoint[index];
//            index = 0;
//            for (int i = 0; i < 1; i++) {
//                BMKRoute* route = [plan.routes objectAtIndex:i];
//                for (int j = 0; j < route.pointsCount; j++) {
//                    int len = [route getPointsNum:j];
//                    BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
//                    memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
//                    index += len;
//                }
//                size = route.steps.count;
//                for (int j = 0; j < size; j++) {
//                    // 添加驾车关键点
//                    BMKStep* step = [route.steps objectAtIndex:j];
//                    item = [[RouteAnnotation alloc]init];
//                    item.coordinate = step.pt;
//                    item.title = step.content;
//                    item.degree = step.degree * 30;
//                    item.type = 4;
//                    [_mapView addAnnotation:item];
//                    [item release];
//                }
//                
//            }
//            
//            // 添加终点
//            item = [[RouteAnnotation alloc]init];
//            item.coordinate = result.endNode.pt;
//            item.type = 1;
//            item.title = @"终点";
//            [_mapView addAnnotation:item];
//            [item release];
//            
//            // 添加途经点
//            if (result.wayNodes) {
//                for (BMKPlanNode* tempNode in result.wayNodes) {
//                    item = [[RouteAnnotation alloc]init];
//                    item.coordinate = tempNode.pt;
//                    item.type = 5;
//                    item.title = tempNode.name;
//                    [_mapView addAnnotation:item];
//                    [item release];
//                }
//            }
//            
//            // 根究计算的点，构造并添加路线覆盖物
//            BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
//            [_mapView addOverlay:polyLine];
//            delete []points;
//            
//            [_mapView setCenterCoordinate:result.startNode.pt animated:YES];
//        }
//    }
}



// Override
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"paopaoclick");
}
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
	NSLog(@"start locate");
}

/**
 *用户位置更新后，会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
	if (userLocation != nil) {
		NSLog(@"%f %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
        gpsC.latitude=userLocation.coordinate.latitude;
        gpsC.longitude=userLocation.coordinate.longitude;
//        BMKPlanNode* start = [[[BMKPlanNode alloc]init] autorelease];
//        start.pt = coor;
//        BMKPlanNode* end = [[[BMKPlanNode alloc]init] autorelease];
//        end.pt=gpsC;
//        NSLog(@"%f,%f",gpsC.latitude,gpsC.longitude);
//        NSLog(@"%f,%f",coor.latitude,coor.longitude);
//        BOOL flag = [_search drivingSearch:nil  startNode:start endCity:nil endNode:end throughWayPoints:nil];
//        if (flag) {
//            NSLog(@"search success.");
//        }
//        else{
//            NSLog(@"search failed!");
//             
//        }
	}
	
}
/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop locate");
}
/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}




- (void)dealloc {
    [super dealloc];
    _mapView.showsUserLocation = NO;
    if (_mapView) {
        [_mapView release];
        _mapView = nil;
    }
    if (_search != nil) {
        [_search release];
        _search = nil;
    }
    
}

@end
