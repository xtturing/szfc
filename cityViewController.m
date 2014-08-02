//
//  cityViewController.m
//  房伴
//
//  Created by tao xu on 13-8-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "cityViewController.h"
#import "area.h"
#import "searchViewController.h"
@interface cityViewController ()

@end

@implementation cityViewController
@synthesize tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithAreaList:(NSArray*)list chooseCity:(NSString*)choose{
    self = [super init];
    if (self) {
        city=list;
        chooseCity=choose;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"城市选择";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];  
    backButton.frame = CGRectMake(0.0, 0.0, 36.0, 30.0);  
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];  
    [backButton setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted];  
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];  
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;  
    [temporaryBarButtonItem release];

    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    // Do any additional setup after loading the view from its nib.
}
- (void)backAction:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES]; 
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    tableView.delegate = nil;
    tableView.dataSource = nil;
    tableView=nil;
    city=nil;
    chooseCity=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc{
    [super dealloc];
    [tableView release];
    [city release];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    if(indexPath.row==0){
        return 40;
    }else if (indexPath.row==2) {
        return 40;
    }else {
        return 44;
    }
    
} 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (city.count+3);
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"SvTableViewCell";
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify] autorelease];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if(indexPath.row==0){
        UIFont *font = [UIFont systemFontOfSize:14]; 
        cell.textLabel.font=font;
        cell.textLabel.text =@"已选城市";
    }else if (indexPath.row==1) {
        UIFont *font = [UIFont systemFontOfSize:18]; 
        cell.textLabel.font=font;
        cell.accessoryType =UITableViewCellAccessoryCheckmark;
        cell.textLabel.text =[NSString stringWithFormat:@"    %@",chooseCity];
    }else if (indexPath.row==2) {
        UIFont *font = [UIFont systemFontOfSize:14]; 
        cell.textLabel.font=font;
        cell.textLabel.text =@"所有城市";
    }else if (indexPath.row>2){
        UIFont *font = [UIFont systemFontOfSize:18]; 
        cell.textLabel.font=font;
        area *area=[city objectAtIndex:(indexPath.row-3)];
        cell.textLabel.text =[NSString stringWithFormat:@"    %@",area.AreaName];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0||indexPath.row==2){
        
    }else {
        area *a=[city objectAtIndex:indexPath.row-3];
        chooseCity=a.AreaName;
        NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:1 inSection:0];
        UITableViewCell *maincell = [self.tableView cellForRowAtIndexPath:indexPathToInsert];
        [[maincell textLabel] setText:[NSString stringWithFormat:@"    %@",chooseCity]];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPathToInsert] withRowAnimation:UITableViewRowAnimationFade];
        searchViewController *search=(searchViewController*)self.parentViewController;
        [search cityChanged:chooseCity];
        [self.navigationController popViewControllerAnimated:YES]; 
    }
    
}
-(void)SetParentView:(UIViewController *)viewController{
    
    [self setParentViewController:viewController];
    
}
@end
