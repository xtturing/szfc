//
//  shareViewController.h
//  房伴
//
//  Created by tao xu on 13-8-29.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRShare.h"
#import <CoreLocation/CoreLocation.h>
#import "CSqlite.h"
#import "NoteView.h"
@interface shareViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,CLLocationManagerDelegate,KRShareDelegate,KRShareRequestDelegate>{
    KRShare *_krShare;
    BOOL _shouldPostImage;
    NSString *sendType;
    CLLocationManager *locationManager;
    CSqlite *m_sqlite;
}
@property (retain, nonatomic)  UIImageView *theImageView;
@property (retain, nonatomic)  UIImageView *TVBackView;
@property (retain, nonatomic) IBOutlet NoteView *noteView;
@property(retain,nonatomic)IBOutlet UIView *buttonView;
@property (retain, nonatomic) IBOutlet UIButton *locationName;
@property(retain,nonatomic) UIImage *photo;
@property(retain,nonatomic) NSString *address;
@property(retain,nonatomic) NSString *lat;
@property(retain,nonatomic) NSString *lon;
-(IBAction)addPhoto:(id)sender;
-(IBAction)takePhoto:(id)sender;
-(IBAction)takeFace:(id)sender;
@end
