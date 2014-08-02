//
//  realTimeMessageViewController.m
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "realTimeMessageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "realTimeMessageCell.h"
#import "PrettyToolbar.h"
#define TOOLBARTAG		200
#define TABLEVIEWTAG	300
@interface realTimeMessageViewController ()

@end

@implementation realTimeMessageViewController
@synthesize tableView,messageTextField,phraseViewController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"实时动态";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];  
    backButton.frame = CGRectMake(0.0, 0.0, 58.0, 30.0);  
    [backButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];  
    [backButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateHighlighted]; 
    [backButton setFont:[UIFont systemFontOfSize:12]]; 
    [backButton setTitle:@"好友动态" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithHex:0x6ac627] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
    [temporaryBarButtonItem release];
    UIButton *button= 
    [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, 35.0,30.0); 
    [button setImage:[UIImage imageNamed:@"renovate.png"] forState:UIControlStateNormal];  
    [button setImage:[UIImage imageNamed:@"renovate_hover.png"] forState:UIControlStateHighlighted];  
    [button addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];  
    addBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.rightBarButtonItem=addBarButtonItem;  
    [addBarButtonItem release];

    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xf0f1f4];
    self.view.backgroundColor= [UIColor colorWithHex:0xf0f1f4];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    tableView.delegate = nil;
    tableView.dataSource = nil;
    tableView=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)backAction:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES]; 
}
- (void)refreshAction:(id)sender {  
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    animation.subtype = kCATransitionFromTop;
    [[self.view layer] addAnimation:animation forKey:@"animation"];
}
//选择系统表情
-(IBAction)showPhraseInfo:(id)sender
{   
//    self.messageString =[NSMutableString stringWithFormat:@"%@",self.messageTextField.text];
	[self.messageTextField resignFirstResponder];
	if (self.phraseViewController == nil) {
		FaceViewController *temp = [[FaceViewController alloc] initWithNibName:@"FaceViewController" bundle:nil];
		self.phraseViewController = temp;
		[temp release];
	}
	[self presentModalViewController:self.phraseViewController animated:YES];
}
-(IBAction)talkRoom:(id)sender{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *realTimeMessageCellIdentifier = @"realTimeMessageCellIdentifier";
    static BOOL nibsRegistered = NO;
    
    if (!nibsRegistered) {
        
        UINib *nib = [UINib nibWithNibName:@"realTimeMessageCell" bundle:nil];
        
        [self.tableView registerNib:nib forCellReuseIdentifier:realTimeMessageCellIdentifier];
        
        nibsRegistered = YES;
        
    }
    realTimeMessageCell *cell = (realTimeMessageCell *)[self.tableView dequeueReusableCellWithIdentifier:realTimeMessageCellIdentifier];
    if (cell==nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"realTimeMessageCell" owner:self options:nil]lastObject];
        
    }
    return cell;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    return 100;
} 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.messageTextField resignFirstResponder];
}
-(IBAction)sendMessage_Click:(id)sender{
    [self.messageTextField resignFirstResponder];
}
#pragma mark TextField Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void) autoMovekeyBoard: (float) h{
    
    
    UIView *toolbar = (UIView *)[self.view viewWithTag:TOOLBARTAG];
	toolbar.frame = CGRectMake(0.0f, (float)([UIScreen mainScreen].bounds.size.height-h-128.0), [UIScreen mainScreen].bounds.size.width, 45.0f);
	UITableView *tView = (UITableView *)[self.view viewWithTag:TABLEVIEWTAG];
	tView.frame = CGRectMake(tView.frame.origin.x, tView.frame.origin.y, [UIScreen mainScreen].bounds.size.width,(float)([UIScreen mainScreen].bounds.size.height-h-128.0));
    
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
    [self autoMovekeyBoard:keyboardRect.size.height];
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
    
    
    [self autoMovekeyBoard:45];
}



@end
