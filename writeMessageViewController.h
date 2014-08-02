//
//  writeMessageViewController.h
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CSqlite.h"
#import "NoteView.h"
#import "dataHttpManager.h"
@interface writeMessageViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,CLLocationManagerDelegate,dataHttpDelegate>{
    BOOL _shouldPostImage;
    NSString *sendType;
    CLLocationManager *locationManager;
    CSqlite *m_sqlite;
    NSString *atUserCode;
    NSString *infoCode;
    NSString *name;
    NSString *userCode;
    int reply;
    dataHttpManager *dataManager;
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
@property (nonatomic,retain) NSString *userCode;
-(id) initWithSendReply:(NSString *)userName atUser:(NSString *)atUser infoCode:(NSString *)info type:(int)type;
-(id)initWithLog;
-(IBAction)addPhoto:(id)sender;
-(IBAction)takePhoto:(id)sender;
-(IBAction)takeFace:(id)sender;
@end
