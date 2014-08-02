//
//  personViewController.m
//  szfc
//
//  Created by tao xu on 13-8-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "personViewController.h"

@interface personViewController ()

@end

@implementation personViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人信息";
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

- (void)backAction:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES]; 
    
}

@end
