//
//  talkCell.h
//  szfc
//
//  Created by tao xu on 13-8-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface talkCell : UITableViewCell{
    IBOutlet UILabel *MsgIntr;
    IBOutlet UIImageView *MsgHdpiPhoto;
}
@property(nonatomic,copy) NSString *MsgIntrText;
@property(nonatomic,copy) NSString *MsgHdpiPhotoUrl;
@end
