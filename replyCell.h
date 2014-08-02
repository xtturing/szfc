//
//  replyCell.h
//  房伴
//
//  Created by tao xu on 13-8-26.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class replyCell;
@protocol replyCellDelegate <NSObject>
@optional
//回复评论
-(void)didReply:(replyCell *)replyCell indexPath:(NSIndexPath*)indexPath;

//继续添加
@end
@interface replyCell : UITableViewCell{
    IBOutlet UILabel *ReplyNick;
    IBOutlet UILabel *ReplyIntr;
    IBOutlet UILabel *AddTime;
    IBOutlet UILabel *AtNick;
    IBOutlet UIImageView *UserLdpiPhoto;
    id<replyCellDelegate> delegate;
    NSIndexPath *cellIndexPath;
}
@property(nonatomic,copy) NSString *ReplyNickText;
@property(nonatomic,copy) NSString *AtNickText;
@property(nonatomic,copy) NSString *ReplyIntrText;
@property(nonatomic,copy) NSString *AddTimeText;
@property(nonatomic,copy) NSString *UserLdpiPhotoUrl;
@property (nonatomic,assign) id<replyCellDelegate> delegate;
@property (retain, nonatomic) NSIndexPath *cellIndexPath;
-(IBAction)comment:(id)sender;

@end
