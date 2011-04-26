//
//  TestPageViewViewController.h
//  TestPageView
//
//  Created by Jacky Zhang on 11-4-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPage1.h"
#import "MyPage2.h"

@interface TestPageViewViewController : UIViewController<UIScrollViewDelegate> {
    
}
@property(nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property(nonatomic, retain) IBOutlet UIScrollView *scrollView;

@end
