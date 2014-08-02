//
//  logViewController.m
//  szfc
//
//  Created by tao xu on 13-8-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "logViewController.h"
//#import "logCell.h"
#import <QuartzCore/QuartzCore.h>
#import "MMGridViewLogCell.h"
#import "writelogViewController.h"
#import "logDetailViewController.h"
#import "writeMessageViewController.h"
@interface logViewController ()

@end

@implementation logViewController

@synthesize tableView;
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
    self.navigationItem.title=@"我的日志";
    UIButton *backButton =
    [UIButton buttonWithType:UIButtonTypeCustom];  
    backButton.frame = CGRectMake(0.0, 0.0, 58.0, 30.0);  
    [backButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal]; 
    [backButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateHighlighted]; 
    [backButton setFont:[UIFont systemFontOfSize:12]];
    [backButton setTitle:@"楼盘收藏" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithHex:0x6ac627] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
    [temporaryBarButtonItem release];
    
    UIButton *addButton = 
    [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0.0, 0.0, 58.0, 30.0);  
    [addButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];  
    [addButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateHighlighted]; 
    [addButton setFont:[UIFont systemFontOfSize:12]];
    [addButton setTitle:@"写日志" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor colorWithHex:0x6ac627] forState:UIControlStateHighlighted];
    [addButton addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];  
    addBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.rightBarButtonItem=addBarButtonItem;  
    [addBarButtonItem release];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
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
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"cube";
    animation.subtype = kCATransitionFromRight;
    [[self.navigationController.view layer] addAnimation:animation forKey:@"animation"];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)detailAction:(id)sender {  
    writeMessageViewController *write=[[writeMessageViewController alloc] initWithLog];
    [self.navigationController pushViewController:write animated:YES];
//    
//    writelogViewController *write=[[writelogViewController alloc] initWithNibName:@"writelogViewController" bundle:nil];
//    [self.navigationController pushViewController:write animated:YES];
        
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
    static NSString *CellIdentifier = @"typeCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle        reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    CGRect frame = CGRectMake(0.0, 0.0f, self.tableView.frame.size.width,200.0f);
    pictureView= [[MMGridView alloc] initWithFrame:frame];
    pictureView.dataSource=self;
    pictureView.delegate=self;
    pictureView.cellMargin = 5;
    pictureView.numberOfRows =2;
    pictureView.numberOfColumns=1;
    pictureView.layoutStyle = HorizontalLayout; 
    cell.accessoryView=pictureView;   
    return cell;
}
-(UIView *)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeCustom];  
    backButton.frame = CGRectMake(self.tableView.center.x-58, 5.0, 115.0, 20.0);  
    [backButton setBackgroundImage:[UIImage imageNamed:@"bg1.png"] forState:UIControlStateNormal];  
    [backButton setFont:[UIFont systemFontOfSize:12]]; 
    [backButton setTitle:[NSString stringWithFormat:@"2013-%d",(section+1)] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIView *sectionview=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width,30)]autorelease];
    [sectionview addSubview:backButton];
    return sectionview;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
        return 200;    
} 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma - MMGridViewDataSource

- (NSInteger)numberOfCellsInGridView:(MMGridView *)gridView
{
    return 4;
}


- (MMGridViewCell *)gridView:(MMGridView *)gridView cellAtIndex:(NSUInteger)index
{
    MMGridViewLogCell *cell = [[[MMGridViewLogCell alloc] initWithFrame:CGRectNull] autorelease];
    cell.textLabel.text = @"工业园区印象城";
    cell.detailLabel.text=@"上周天气还算过得去，虽然算不上很凉爽，但也算不上很热，郁闷的是，明天开始又要上升到35度了，唉，夏天，怎么才能轻松地渡过呢。 这两天还有点小忙，几天没做美食了，天气热，出门真难受呢，今天好不容易空一点，做点骨头汤给小熊喝吧……";
    cell.image.image = [UIImage imageNamed:@"2013080506361710_easyicon_net_48.png"];
    cell.timeLabel.text=@"2013-01-10  08:12";
    return cell;
}

// ----------------------------------------------------------------------------------

#pragma - MMGridViewDelegate

- (void)gridView:(MMGridView *)gridView didSelectCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
    [self didGridView:index];
}


- (void)gridView:(MMGridView *)gridView didDoubleTapCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
    [self didGridView:index];
}

-(void) didGridView:(NSUInteger)index{
    logDetailViewController *log=[[logDetailViewController alloc]initWithNibName:@"logDetailViewController" bundle:nil];
    [self.navigationController pushViewController:log animated:YES];
}

- (void)gridView:(MMGridView *)theGridView changedPageToIndex:(NSUInteger)index
{
    //    [self setupPageControl];
}


@end
