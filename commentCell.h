//
//  commentCell.h
//  szfc
//
//  Created by tao xu on 13-8-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentCell : UITableViewCell{
    IBOutlet UILabel *ReplyNick;
    IBOutlet UILabel *ReplyIntr;
    IBOutlet UILabel *AddTime;
    IBOutlet UIImageView *UserLdpiPhoto;
}
@property(nonatomic,copy) NSString *ReplyNickText;
@property(nonatomic,copy) NSString *ReplyIntrText;
@property(nonatomic,copy) NSString *AddTimeText;
@property(nonatomic,copy) NSString *UserLdpiPhotoUrl;
@end
