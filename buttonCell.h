//
//  buttonCell.h
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class buttonCell;
@protocol buttonCellDelegate <NSObject>
@optional
//评论
-(void)didComment:(buttonCell *)commentCell indexPath:(NSIndexPath*)indexPath;
//转发
-(void)didPraise:(buttonCell *)commentCell indexPath:(NSIndexPath*)indexPath;
//赞
-(void)didReply:(buttonCell *)commentCell indexPath:(NSIndexPath*)indexPath;
//继续添加
@end

@interface buttonCell : UITableViewCell{
    IBOutlet UIButton* CommentNum;
    IBOutlet UIButton* TransmitNum;
    IBOutlet UIButton* PraiseNum;
    id<buttonCellDelegate> delegate;
    NSIndexPath *cellIndexPath;
}
@property(nonatomic,copy) NSString *CommentNumText;
@property(nonatomic,copy) NSString *TransmitNumText;
@property(nonatomic,copy) NSString *PraiseNumText;
@property (nonatomic,assign) id<buttonCellDelegate> delegate;
@property (retain, nonatomic) NSIndexPath *cellIndexPath;
-(IBAction)comment:(id)sender;
-(IBAction)praise:(id)sender;
-(IBAction)reply:(id)sender;
@end
