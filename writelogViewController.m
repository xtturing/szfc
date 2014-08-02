//
//  writelogViewController.m
//  szfc
//
//  Created by tao xu on 13-8-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "writelogViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface writelogViewController ()
@end

@implementation writelogViewController
@synthesize theImageView,TVBackView,noteView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"我的日志";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];  
    backButton.frame = CGRectMake(0.0, 0.0, 36.0, 30.0);  
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];  
    [backButton setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted]; 
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
    [temporaryBarButtonItem release];
   
	[noteView setDelegate:self];
    [noteView becomeFirstResponder];
    [self pohtoAction];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
}
- (IBAction)alarmAction:(id)sender {  
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageUnCurl";
    animation.subtype = kCATransitionFromRight;
    [[self.view layer] addAnimation:animation forKey:@"animation"];
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
    self.theImageView.image = image;
    _shouldPostImage = YES;
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

@end
