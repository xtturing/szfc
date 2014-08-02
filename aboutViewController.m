//
//  aboutViewController.m
//  szfc
//
//  Created by tao xu on 13-8-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "aboutViewController.h"

@interface aboutViewController ()

@end

@implementation aboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"关于团队";
        UIImage *d=nil;
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad){
            d=[UIImage imageNamed:@"关于1280.png"];
            CGSize size = CGSizeMake(768.0f, 960.0f);
            if (UIGraphicsBeginImageContextWithOptions != NULL) {
                UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
            } else {
                UIGraphicsBeginImageContext(size);
            }
            [d drawInRect:CGRectMake(0.0f,0.0f, 768.0f, 960.0f)];
        }else {
            if([[UIScreen mainScreen] bounds].size.height==568){
                d=[UIImage imageNamed:@"关于568.png"];
                CGSize size = CGSizeMake(320.0f,504.0f);
                if (UIGraphicsBeginImageContextWithOptions != NULL) {
                    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
                } else {
                    UIGraphicsBeginImageContext(size);
                }
                [d drawInRect:CGRectMake(0.0f, 0.0f, 320.0f, 504.0f)];
            }else{
                d=[UIImage imageNamed:@"关于.png"];
                CGSize size = CGSizeMake(320.0f,416.0f);
                if (UIGraphicsBeginImageContextWithOptions != NULL) {
                    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
                } else {
                    UIGraphicsBeginImageContext(size);
                }
                [d drawInRect:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f)];
            }
        }
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor=[UIColor colorWithPatternImage:image];
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];  
        backButton.frame = CGRectMake(0.0, 0.0, 36.0, 30.0);     
        [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal]; 
        [backButton setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted];  
        [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];  
        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
        temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
        self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
        [temporaryBarButtonItem release];
    }
    return self;
}
- (IBAction)backAction:(id)sender {  
    [self dismissModalViewControllerAnimated:YES]; 
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
