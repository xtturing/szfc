

#import <UIKit/UIKit.h>

@class realTimeMessageViewController;


@interface FaceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
	NSMutableArray            *_phraseArray;
	realTimeMessageViewController        *_realTimeMessageViewController;
    
    
}

@property (retain, nonatomic) IBOutlet UIScrollView *faceScrollView;
@property (nonatomic, retain) NSMutableArray            *phraseArray;
@property (nonatomic, retain) realTimeMessageViewController        *realTimeMessageViewController;

-(IBAction)dismissMyselfAction:(id)sender;
- (void)showEmojiView;
@end
