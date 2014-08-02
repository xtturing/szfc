//
//  userCell.h
//  房伴
//
//  Created by tao xu on 13-8-26.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userCell : UITableViewCell{
    IBOutlet UILabel* AddTime;
    
    IBOutlet UILabel* NickName;
    IBOutlet UIImageView* UserLdpiPhoto;
}
@property(nonatomic,copy) NSString *AddTimeText;
@property(nonatomic,copy) NSString *NickNameText;
@property(nonatomic,copy) NSString *UserLdpiPhotoUrl;
@end
