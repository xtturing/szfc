//
//  friendMessageCell.h
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface friendMessageCell : UITableViewCell{
    IBOutlet UILabel* InfoIntr;
    IBOutlet UILabel* AddTime;
    
    IBOutlet UILabel* NickName;
    IBOutlet UIImageView* UserLdpiPhoto;
}
@property(nonatomic,copy) NSString *InfoIntrText;
@property(nonatomic,copy) NSString *AddTimeText;
@property(nonatomic,copy) NSString *NickNameText;
@property(nonatomic,copy) NSString *UserLdpiPhotoUrl;

@end
