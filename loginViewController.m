//
//  loginViewController.m
//  房伴
//
//  Created by tao xu on 13-8-29.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "loginViewController.h"
#import <QuartzCore/QuartzCore.h>
#define ANIMATION_DURATION 0.3f
@interface loginViewController ()

@end

@implementation loginViewController
@synthesize dropButton,moveDownGroup,account_box,userNumber,numberLabel,userPassword,passwordLabel,userLargeHead,loginButton,registerButton,userLargeHeadView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(id)initIsLogin:(BOOL)isLog{
    self = [super initWithNibName:@"loginViewController" bundle:nil];
    if (self) {
        isLogin=isLog;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self isLoginOrRegister];
    NSDictionary *account1=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"userNumber",@"",@"passWord",@"1.jpeg",@"userHead", nil];
    NSDictionary *account2=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"userNumber",@"",@"passWord",@"2.jpeg",@"userHead", nil];
    
    _currentAccounts=[[NSMutableArray arrayWithObjects:account1,account2, nil]retain];
    
    
    [self reloadAccountBox];
    dataManager=[[dataHttpManager alloc] initWithDelegate];
    dataManager.delegate=self;
    [dataManager start];
    // Do any additional setup after loading the view from its nib.
}
-(void)isLoginOrRegister{
    if(isLogin){
        userLargeHeadView.hidden=YES;
        dropButton.hidden=YES;
        numberLabel.text=@"帐号";
        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [registerButton setTitle:@"注册帐号" forState:UIControlStateNormal];
    }else {
        userLargeHeadView.hidden=NO;
        dropButton.hidden=NO;
        numberLabel.text=@"注册";
        [loginButton setTitle:@"注册" forState:UIControlStateNormal];
        [registerButton setTitle:@"用户登录" forState:UIControlStateNormal];
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (IBAction)backAction:(id)sender {  
    [self dismissModalViewControllerAnimated:YES]; 
}
-(IBAction)registerUser:(id)sender{
    if(isLogin){
        isLogin=NO;
        [self isLoginOrRegister];
    }else {
        isLogin=YES;
        [self isLoginOrRegister];
    }
}
-(IBAction)findPassword:(id)sender{

}
- (IBAction)login:(id)sender {
    if(isLogin){
        NSDictionary *account=[NSDictionary dictionaryWithObjectsAndKeys:self.userNumber.text,@"userNumber",self.userPassword.text,@"passWord",@"3.jpeg",@"userHead", nil];
        [_currentAccounts addObject:account];
        [self reloadAccountBox];
        if(self.userNumber.text.length>0&&self.userPassword.text.length>0){
            if([dataManager loginCheck:self.userNumber.text password:self.userPassword.text]){
                [self dismissModalViewControllerAnimated:YES];
            } 
        }
    }else {
        if(self.userNumber.text.length>0&&self.userPassword.text.length>0){
            if([dataManager registerUser:self.userNumber.text password:self.userPassword.text photo:nil]){
                [self dismissModalViewControllerAnimated:YES];
            } 
        }
    }
    
    
    
}
- (IBAction)dropDown:(id)sender {
    if ([sender isSelected]) {
        
        [self hideAccountBox];
        
    }else
    {
        
        [self showAccountBox];
        
    }
    
}

-(void)showAccountBox
{
    [self.dropButton setSelected:YES];
    CABasicAnimation *move=[CABasicAnimation animationWithKeyPath:@"position"];
    [move setFromValue:[NSValue valueWithCGPoint:CGPointMake(self.moveDownGroup.center.x, self.moveDownGroup.center.y)]];
    [move setToValue:[NSValue valueWithCGPoint:CGPointMake(self.moveDownGroup.center.x, self.moveDownGroup.center.y+self.account_box.frame.size.height)]];
    [move setDuration:ANIMATION_DURATION];
    [self.moveDownGroup.layer addAnimation:move forKey:nil];
    
    
    [self.account_box setHidden:NO];
    
    //模糊处理
    [self.userLargeHead setAlpha:0.5f];
    [self.numberLabel setAlpha:0.5f];
    [self.passwordLabel setAlpha:0.5f];
    [self.userNumber setAlpha:0.5f];
    [self.userPassword setAlpha:0.5f];
    
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform"];
    [scale setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.2, 1.0)]];
    [scale setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    CABasicAnimation *center=[CABasicAnimation animationWithKeyPath:@"position"];
    [center setFromValue:[NSValue valueWithCGPoint:CGPointMake(self.account_box.center.x, self.account_box.center.y-self.account_box.bounds.size.height/2)]];
    [center setToValue:[NSValue valueWithCGPoint:CGPointMake(self.account_box.center.x, self.account_box.center.y)]];
    
    CAAnimationGroup *group=[CAAnimationGroup animation];
    [group setAnimations:[NSArray arrayWithObjects:scale,center, nil]];
    [group setDuration:ANIMATION_DURATION];
    [self.account_box.layer addAnimation:group forKey:nil];
    
    
    
    [self.moveDownGroup setCenter:CGPointMake(self.moveDownGroup.center.x, self.moveDownGroup.center.y+self.account_box.frame.size.height)];
    
}
-(void)hideAccountBox
{
    [self.dropButton setSelected:NO];
    CABasicAnimation *move=[CABasicAnimation animationWithKeyPath:@"position"];
    [move setFromValue:[NSValue valueWithCGPoint:CGPointMake(self.moveDownGroup.center.x, self.moveDownGroup.center.y)]];
    [move setToValue:[NSValue valueWithCGPoint:CGPointMake(self.moveDownGroup.center.x, self.moveDownGroup.center.y-self.account_box.frame.size.height)]];
    [move setDuration:ANIMATION_DURATION];
    [self.moveDownGroup.layer addAnimation:move forKey:nil];
    
    [self.moveDownGroup setCenter:CGPointMake(self.moveDownGroup.center.x, self.moveDownGroup.center.y-self.account_box.frame.size.height)];
    [self.userLargeHead setAlpha:1.0f];
    [self.numberLabel setAlpha:1.0f];
    [self.passwordLabel setAlpha:1.0f];
    [self.userNumber setAlpha:1.0f];
    [self.userPassword setAlpha:1.0f];
    
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform"];
    [scale setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [scale setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.2, 1.0)]];
    
    CABasicAnimation *center=[CABasicAnimation animationWithKeyPath:@"position"];
    [center setFromValue:[NSValue valueWithCGPoint:CGPointMake(self.account_box.center.x, self.account_box.center.y)]];
    [center setToValue:[NSValue valueWithCGPoint:CGPointMake(self.account_box.center.x, self.account_box.center.y-self.account_box.bounds.size.height/2)]];
    
    CAAnimationGroup *group=[CAAnimationGroup animation];
    [group setAnimations:[NSArray arrayWithObjects:scale,center, nil]];
    [group setDuration:ANIMATION_DURATION];
    [self.account_box.layer addAnimation:group forKey:nil];
    
    
    [self.account_box performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:NO] afterDelay:ANIMATION_DURATION];
}


-(void)reloadAccountBox
{
    for (UIView* view in self.account_box.subviews) {
        if (view.tag!=20000) {
            [view removeFromSuperview];
        } 
    }
    int count=_currentAccounts.count;
    //图片之间的间距
    CGFloat insets;
    
    
    //图片的宽度与背景的宽度
    CGFloat imageWidth=49,bgWidth=288,bgHeight=80;
    
    //根据账号数量对3的商来计算整个view高度的调整
    CGFloat newHeight;
    newHeight=((count-1)/3)*80+80;
    if (newHeight!=bgHeight) {
        [self.account_box setFrame:CGRectMake(self.account_box.frame.origin.x, self.account_box.frame.origin.y, self.account_box.frame.size.width, newHeight)];
    }
    
    CGFloat paddingTop=(bgHeight-imageWidth)/2;
    CGFloat paddingLeft=(320-bgWidth)/2;
    if (count >3) {
        insets=insets=(bgWidth-imageWidth*3)/4;
    }else{
        //根据图片数量对3取模计算间距
        switch (count%3) {
            case 0:
                insets=(bgWidth-imageWidth*3)/4;
                
                break;
            case 1:
                insets=(bgWidth-imageWidth)/2;
                break;
            case 2:
                insets=(bgWidth-imageWidth*2)/3;
                break;
            default:
                break;
        }
    }
    
    
    
    for (int i=0;i<_currentAccounts.count;i++)
    {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(paddingLeft+insets+(i%3)*(imageWidth+insets), paddingTop+80*(i/3), imageWidth, imageWidth)];
        [button setBackgroundImage:[UIImage imageNamed:@"login_dropdown_avatar_border"] forState:UIControlStateNormal];
        [button.imageView setImage:[UIImage imageNamed:@"login_avatar"]];
        button.tag=10000+i;
        [button addTarget:self action:@selector(chooseAccount:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *headImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45 , 45)];
        [headImage.layer setCornerRadius:3.0];
        [headImage setClipsToBounds:YES];
        [headImage setCenter:CGPointMake(button.center.x, button.center.y)];
        [headImage setImage:[UIImage imageNamed:[[_currentAccounts objectAtIndex:i] objectForKey:@"userHead"]]];
        [self.account_box addSubview:headImage];
        [self.account_box addSubview:button];
        
    }
}

- (void)chooseAccount:(UIButton*)button
{
    int accountIndex=button.tag-10000;
    [self.userNumber setText:[[_currentAccounts objectAtIndex:accountIndex] objectForKey:@"userNumber"] ];
    [self.userPassword setText:[[_currentAccounts objectAtIndex:accountIndex] objectForKey:@"passWord"]];
    [self.userLargeHead setImage:[UIImage imageNamed:[[_currentAccounts objectAtIndex:accountIndex] objectForKey:@"userHead"]]];
    [self hideAccountBox];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userNumber resignFirstResponder];
    [self.userPassword resignFirstResponder];
}


@end
