//
//  shareViewController.m
//  房伴
//
//  Created by tao xu on 13-8-29.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "shareViewController.h"
#import "SysFunction.h"
#import <QuartzCore/QuartzCore.h>
@interface shareViewController (){
    float heightBord;
}

@end

@implementation shareViewController
@synthesize theImageView,TVBackView,noteView,buttonView,locationName,lon,lat,address,photo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self defalutInit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _shouldPostImage=NO;
    m_sqlite = [[CSqlite alloc]init];
    [m_sqlite openSqlite];    
    lat=@"";
    lon=@"";
    address=@"";
    photo=[[UIImage alloc] init];
    self.navigationItem.title=@"分享到新浪微博";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];  
    backButton.frame = CGRectMake(0.0, 0.0, 36.0, 30.0);  
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];  
    [backButton setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
    [temporaryBarButtonItem release];
    // Do any additional setup after loading the view from its nib.
    UIButton *button= 
    //    [UIButton buttonWithType:UIButtonTypeRoundedRect];  
    //    button.frame = CGRectMake(0.0, 0.0, 60.0,30.0);  
    //    [button setTitle:@"评论我的" forState:UIControlStateNormal];
    //    button.titleLabel.textColor=[UIColor colorWithHex:0x3D89BF];
    //    button.titleLabel.font=[UIFont systemFontOfSize:12];
    [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, 36.0,30.0); 
    [button setImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];  
    [button setImage:[UIImage imageNamed:@"upload_hover.png"] forState:UIControlStateHighlighted];  
    [button addTarget:self action:@selector(sendShare:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];  
    addBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.rightBarButtonItem=addBarButtonItem;  
    [addBarButtonItem release];
    //监听键盘高度的变换 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 键盘高度变化通知，ios5.0新增的  
#ifdef __IPHONE_5_0
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
#endif
	[noteView setDelegate:self];
    
    //    [noteView becomeFirstResponder];
    
    self.theImageView=[[UIImageView alloc] init];   
    heightBord=44;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)defalutInit
{
    
    _krShare  = [KRShare sharedInstanceWithTarget:0];
    
    _krShare.delegate = self;
    
    [_krShare logIn];
}
#pragma mark - SinaWeibo Delegate
//发送按钮回调方法
- (void) sendShare:(UIButton*) sender
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageUnCurl";
    animation.subtype = kCATransitionFromRight;
    [[self.view layer] addAnimation:animation forKey:@"animation"];
    [_krShare requestWithURL:@"statuses/upload.json"
                      params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"#苏州#%@",self.noteView.text], @"status",
                              photo, @"pic", nil]
                  httpMethod:@"POST"
                    delegate:self];
    [self.navigationController popViewControllerAnimated:YES]; 
    
}
#pragma mark - SinaWeibo Delegate
- (void)removeAuthData
{
    if(_krShare.shareTarget == KRShareTargetSinablog)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KRShareAuthData-Sina"];
    }
    else if(_krShare.shareTarget == KRShareTargetTencentblog)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KRShareAuthData-Tencent"];
    }
    else if(_krShare.shareTarget == KRShareTargetDoubanblog)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KRShareAuthData-Douban"];
    }
    else if(_krShare.shareTarget == KRShareTargetRenrenblog)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KRShareAuthData-Renren"];
    }
}



- (void)KRShareDidLogIn:(KRShare *)krShare
{
    if(krShare.shareTarget == KRShareTargetSinablog)
    {
        if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            locationManager.distanceFilter=0.5;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            [locationManager startUpdatingLocation]; // 开始定位
        }
         [self pohtoAction];
         
    }
    
    else if(krShare.shareTarget == KRShareTargetTencentblog)
    {
        [krShare requestWithURL:@"t/add_pic"
                         params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"这是我分享的图片", @"content",
                                 @"json",@"format",
                                 @"221.232.172.30",@"clientip",
                                 @"all",@"scope",
                                 krShare.userID,@"openid",
                                 @"ios-sdk-2.0-publish",@"appfrom",
                                 @"0",@"compatibleflag",
                                 @"2.a",@"oauth_version",
                                 kTencentWeiboAppKey,@"oauth_consumer_key",
                                 [UIImage imageNamed:@"Default.png"], @"pic", nil]
                     httpMethod:@"POST"
                       delegate:self];
    }
    else if(krShare.shareTarget == KRShareTargetDoubanblog)
    {
        [krShare requestWithURL:@"shuo/v2/statuses/"
                         params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"这是我分享的图片", @"text",
                                 kDoubanBroadAppKey,@"source",
                                 [UIImage imageNamed:@"Default.png"], @"image", nil]
                     httpMethod:@"POST"
                       delegate:self];
    }
    else if(krShare.shareTarget == KRShareTargetRenrenblog)
    {
        [krShare requestWithURL:@"restserver.do"
                         params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"1.0",@"v",
                                 @"这是我分享的图片", @"caption",
                                 @"json",@"format",
                                 @"photos.upload",@"method",
                                 [UIImage imageNamed:@"Default.png"],@"upload",
                                 kRenrenBroadAppKey,@"api_key",
                                 nil]
                     httpMethod:@"POST"
                       delegate:self];
    }
    
}

- (void)KRShareDidLogOut:(KRShare *)sinaweibo
{
    [self removeAuthData];
}

- (void)KRShareLogInDidCancel:(KRShare *)sinaweibo
{
    NSLog(@"用户取消了登录");
}

- (void)krShare:(KRShare *)krShare logInDidFailWithError:(NSError *)error
{
    [SysFunction AlertWithMessage:@"登录失败"];
}

- (void)krShare:(KRShare *)krShare accessTokenInvalidOrExpired:(NSError *)error
{
    [self removeAuthData];
}

- (void)KRShareWillBeginRequest:(KRShareRequest *)request
{
    NSLog(@"开始请求");
    //_loadingView.hidden = NO;
}

-(void)request:(KRShareRequest *)request didFailWithError:(NSError *)error
{
    //_loadingView.hidden = YES;
    
    if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        [SysFunction AlertWithMessage:@"发表微博失败"];
        
        NSLog(@"Post image status failed with error : %@", error);
    }
    else if ([request.url hasSuffix:@"api/t/add_pic"])
    {
        [SysFunction AlertWithMessage:@"发表微博失败"];
        
        NSLog(@"Post image status failed with error : %@", error);
    }
    //发表人人网相片回调
    else if ([request.url hasSuffix:@"restserver.do"])
    {
        
        [SysFunction AlertWithMessage:@"发表人人网相片失败"];
        
        NSLog(@"Post image status failed with error : %@", error);
    }
}


- (void)request:(KRShareRequest *)request didFinishLoadingWithResult:(id)result
{
    //NSLog(@"请求已完成，结果是：%@",result);
    //_loadingView.hidden = YES;
    
    //新浪微博响应
    if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        if([[result objectForKey:@"error_code"] intValue]==20019)
        {
            [SysFunction AlertWithMessage:@"发送频率过高，请您过会再发"];
        }
        else if([[result objectForKey:@"error_code"] intValue]==0)
        {
            [SysFunction AlertWithMessage:@"发送微博成功"];
        }
    }
    //腾讯微博响应
    else if ([request.url hasSuffix:@"api/t/add_pic"])
    {
        if([[result objectForKey:@"errcode"] intValue]==0)
        {
            [SysFunction AlertWithMessage:@"发表微博成功"];
        }
        else{
            [SysFunction AlertWithMessage:@"发表微博失败"];
        }
    }
    //豆瓣说响应
    else if ([request.url hasSuffix:@"shuo/v2/statuses/"])
    {NSLog(@"%@",request.url);
        if([[result objectForKey:@"code"] intValue]==0)
        {
            [SysFunction AlertWithMessage:@"发表豆瓣说成功"];
        }
        else{
            NSLog(@"%@",result);
            [SysFunction AlertWithMessage:@"发表豆瓣说失败"];
        }
    }
    //发表人人网相片回调
    else if ([request.url hasSuffix:@"restserver.do"])
    {
        if([[result objectForKey:@"error_code"] intValue]==0)
        {
            [SysFunction AlertWithMessage:@"发表人人网相片成功"];
        }
        else{
            [SysFunction AlertWithMessage:@"发表人人网相片失败"];
        }
    }
}
-(void) autoMovekeyBoard{
    if(_shouldPostImage){
        if(heightBord==44){
            [self.theImageView setFrame: CGRectMake(0, (float)([UIScreen mainScreen].bounds.size.height-heightBord-230.0), 100,100)];
            [self.noteView setFrame:CGRectMake(0, 0, (float)([UIScreen mainScreen].bounds.size.width), (float)([UIScreen mainScreen].bounds.size.height-heightBord-230.0))]; 
        }else {
            [self.theImageView setFrame: CGRectMake((float)([UIScreen mainScreen].bounds.size.width-110), (float)([UIScreen mainScreen].bounds.size.height-heightBord-210.0), 100,100)];
            [self.noteView setFrame:CGRectMake(0, 0, (float)([UIScreen mainScreen].bounds.size.width-110), (float)([UIScreen mainScreen].bounds.size.height-heightBord-130))];
        }
        
    }
    [self.buttonView setFrame:CGRectMake(0, (float)([UIScreen mainScreen].bounds.size.height-heightBord-130.0), (float)([UIScreen mainScreen].bounds.size.width), 50)];
    
}
#pragma mark -
#pragma mark Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification {
    
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    heightBord=keyboardRect.size.height;
    [self autoMovekeyBoard];
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    heightBord=44;
    [self autoMovekeyBoard];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // to update NoteView
    [noteView setNeedsDisplay];
}
- (void)backAction:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES]; 
}
- (void)pohtoAction{  
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"插入图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"系统相册",@"拍摄", nil];
    [alert show];
    [alert release];
}
- (void)textViewDidEndEditing:(UITextView *)textView {  
    NSLog(@"%@",textView.text);   
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [self leaveEditMode];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
- (void)leaveEditMode {  
    
    [self.noteView resignFirstResponder];  
    
}
-(IBAction)addPhoto:(id)sender{
    [self addPhoto];
}
-(IBAction)takePhoto:(id)sender{
    [self takePhoto];
}
-(IBAction)takeFace:(id)sender{
    
}
#pragma mark - Tool Methods
- (void)addPhoto
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.navigationBar.tintColor = [UIColor colorWithRed:72.0/255.0 green:106.0/255.0 blue:154.0/255.0 alpha:1.0];
	imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePickerController.delegate = self;
	imagePickerController.allowsEditing = NO;
	[self presentModalViewController:imagePickerController animated:YES];
	[imagePickerController release];
}

- (void)takePhoto
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
                                                        message:@"该设备不支持拍照功能" 
                                                       delegate:nil 
                                              cancelButtonTitle:nil 
                                              otherButtonTitles:@"好", nil];
        [alert show];
        [alert release];
    }
    else
    {
        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
        [self presentModalViewController:imagePickerController animated:YES];
        [imagePickerController release];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self.view addSubview:self.theImageView];
    self.theImageView.image = image;       
    photo=image;
    _shouldPostImage = YES;
    [self autoMovekeyBoard];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"index = %d",buttonIndex);
    if (buttonIndex == 1) 
    {
        [self addPhoto];
    }
    else if(buttonIndex == 2)
    {
        [self takePhoto];
    }
}
// 定位成功时调用
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation 
{
    CLLocationCoordinate2D mylocation = newLocation.coordinate;//手机GPS
    lat=[[NSString stringWithFormat:@"%.4f", newLocation.coordinate.latitude] retain];
    lon=[[NSString stringWithFormat:@"%.4f", newLocation.coordinate.longitude] retain];
    mylocation = [self zzTransGPS:mylocation];///火星GPS
    
    //显示火星坐标
    
    /////////获取位置信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray* placemarks,NSError *error)
     {
         if (placemarks.count >0   )
         {
             CLPlacemark * plmark = [placemarks objectAtIndex:0];
             
             NSString * country = plmark.country;
             NSString * city    = plmark.locality;
             
             
             NSLog(@"%@-%@-%@",country,city,plmark.name);
             
             [self.locationName setTitle:[NSString stringWithFormat:@"%@%@",city,plmark.name] forState:UIControlStateNormal ];
             address=[[NSString stringWithFormat:@"%@%@",city,plmark.name] retain];
         }
         
         
     }];
    [locationManager stopUpdatingLocation];    
    //[geocoder release];
    
}
// 定位失败时调用
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
}

-(CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps
{
    int TenLat=0;
    int TenLog=0;
    TenLat = (int)(yGps.latitude*10);
    TenLog = (int)(yGps.longitude*10);
    NSString *sql = [[NSString alloc]initWithFormat:@"select offLat,offLog from gpsT where lat=%d and log = %d",TenLat,TenLog];
    NSLog(sql);
    sqlite3_stmt* stmtL = [m_sqlite NSRunSql:sql];
    int offLat=0;
    int offLog=0;
    while (sqlite3_step(stmtL)==SQLITE_ROW)
    {
        offLat = sqlite3_column_int(stmtL, 0);
        offLog = sqlite3_column_int(stmtL, 1);
        
    }
    
    yGps.latitude = yGps.latitude+offLat*0.0001;
    yGps.longitude = yGps.longitude + offLog*0.0001;
    return yGps;
    
    
}


@end
