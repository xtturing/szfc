    //
//  BaseViewController.m
//  RaisedCenterTabBar
//
//  Created by Peter Boctor on 12/15/10.
//
// Copyright (c) 2011 Peter Boctor
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE
//

#import "BaseViewController.h"

@implementation BaseViewController

// Create a view controller and setup it's tab bar item with a title and image
-(UIViewController*) viewControllerWithTabTitle:(NSString*) title image:(UIImage*)image
{
  UIViewController* viewController = [[[UIViewController alloc] init] autorelease];
  viewController.tabBarItem = [[[UITabBarItem alloc] initWithTitle:title image:image tag:0] autorelease];
  return viewController;
}

// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage  index:(int)index
{
  UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
  button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
  [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
  [button setBackgroundImage:highlightImage forState:UIControlStateSelected];
  CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0){
    CGPoint center = self.tabBar.center;
    center.x = center.x+(index-2)*80+40;
    center.y = center.y - 5;
    button.center = center;
  }else
  {
    CGPoint center = self.tabBar.center;
    center.y = center.y - heightDifference/2.0;
    button.center = center;
  }
   button.tag=index;
  [button addTarget:self
                action:@selector(alarmTimeDone:)
      forControlEvents:UIControlEventTouchUpInside
     ];
  button.showsTouchWhenHighlighted=YES;
  button.adjustsImageWhenHighlighted = YES;
  [self.view addSubview:button];
    if(index==1){
        button.selected=YES;
    }
}


- (IBAction)alarmTimeDone:(id)sender{
    for( UIButton *v in self.view.subviews )
        
    {
        
        if( [v isKindOfClass:[UIButton class]] )
            
        {
            
            v.selected=NO;
            
        }
        
    }
    UIButton *button=(UIButton *)sender;
    button.selected=YES;
    [self setSelectedIndex:button.tag];
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    for( UIButton *v in self.view.subviews )
        
    {
        
        if( [v isKindOfClass:[UIButton class]] )
            
        {
            if(v.tag==item.tag){
                v.selected=YES;
            }else {
              v.selected=NO;  
            }
        }
        
    }
   
}
@end
