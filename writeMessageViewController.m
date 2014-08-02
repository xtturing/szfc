//
//  writeMessageViewController.m
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "writeMessageViewController.h"
#import "loginViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface writeMessageViewController (){
    float heightBord;
}

@end

@implementation writeMessageViewController
@synthesize theImageView,TVBackView,noteView,buttonView,locationName,lon,lat,address,photo,userCode;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id) initWithSendReply:(NSString *)userName atUser:(NSString *)atUser infoCode:(NSString *)info type:(int)type{
    self = [super initWithNibName:@"writeMessageViewController" bundle:nil];
    if (self) {
        // Custom initialization       
        name=userName;
        infoCode=info;
        atUserCode=atUser;
        reply=type;
        sendType=@"sendReply";
    }
    return self;
}
-(id)initWithLog{
    self = [super initWithNibName:@"writeMessageViewController" bundle:nil];
    if (self) {
        
        sendType=@"sendLog";
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _shouldPostImage=NO;
    dataManager=[[dataHttpManager alloc] initWithDelegate];
    dataManager.delegate=self;
    [dataManager start];
    [dataManager logIn];
    if([sendType isEqualToString:@"sendReply"]){
        self.navigationItem.title=[NSString stringWithFormat:@"回复%@",name];
        self.locationName.hidden=YES;
        self.buttonView.hidden=YES;
    }else if ([sendType isEqualToString:@"sendLog"]) {
        self.navigationItem.title=@"写日志";
        m_sqlite = [[CSqlite alloc]init];
        [m_sqlite openSqlite];
        if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            locationManager.distanceFilter=0.5;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            [locationManager startUpdatingLocation]; // 开始定位
        }
        NSLog(@"GPS 启动");
        lat=@"";
        lon=@"";
        address=@"";
        photo=[[UIImage alloc] init];
        self.theImageView=[[UIImageView alloc] init];
        [self pohtoAction]; 
        buttonView.hidden=YES;
    }
    else {        
        self.navigationItem.title=@"发表动态";
        m_sqlite = [[CSqlite alloc]init];
        [m_sqlite openSqlite];
        if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            locationManager.distanceFilter=0.5;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            [locationManager startUpdatingLocation]; // 开始定位
        }
        NSLog(@"GPS 启动");
        lat=@"";
        lon=@"";
        address=@"";
        photo=[[UIImage alloc] init];
        self.theImageView=[[UIImageView alloc] init];
        [self pohtoAction];        
    }
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];  
    backButton.frame = CGRectMake(0.0, 0.0, 36.0, 30.0);  
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];  
    [backButton setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
    [temporaryBarButtonItem release];

    UIButton *button=
    [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, 36.0,30.0); 
    [button setImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];  
    [button setImage:[UIImage imageNamed:@"upload_hover.png"] forState:UIControlStateHighlighted];  
    [button addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside]; 
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];  
    addBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.rightBarButtonItem=addBarButtonItem;  
    [addBarButtonItem release];
    if(![dataManager logIn]){
        self.navigationItem.rightBarButtonItem.enabled=NO;
    }
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
    heightBord=44;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    theImageView=nil;
    TVBackView=nil;
    noteView=nil;
    buttonView=nil;
    locationName=nil;
    lon=nil;
    lat=nil;
    address=nil;
    photo=nil;
    userCode=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc{
    [theImageView release];
    [TVBackView release];
    [noteView release];
    [buttonView release];
    [locationName release];
    [lon release];
    [lat release];
    [address release];
    [photo release];
    [userCode release];
    [super dealloc];
}
-(void)didGetAuthInfo:(NSString *)code userName:(NSString *)userName nikeName:(NSString *)nikeName phone:(NSString *)phone photo:(NSString *)photo{
    self.userCode=code;
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
    [self.locationName setFrame:CGRectMake(0, (float)([UIScreen mainScreen].bounds.size.height-heightBord-130.0), (float)(self.locationName.bounds.size.width), 23)];
    [self.buttonView setFrame:CGRectMake(0, (float)([UIScreen mainScreen].bounds.size.height-heightBord-100.0), (float)([UIScreen mainScreen].bounds.size.width), 36)];
    
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
- (void)sendAction:(id)sender {  
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageUnCurl";
    animation.subtype = kCATransitionFromRight;
    [[self.view layer] addAnimation:animation forKey:@"animation"];
    if([sendType isEqualToString:@"sendReply"]){        
        [dataManager sendReply:self.userCode infoCode:infoCode reply:reply toUser:atUserCode intr:self.noteView.text photo:nil address:nil lat:nil lon:nil]; 
    }else{
        [dataManager sendInfo:self.userCode intr:self.noteView.text photo:photo address:address lat:lat lon:lon];
    }
    
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
