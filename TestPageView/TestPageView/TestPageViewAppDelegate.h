//
//  TestPageViewAppDelegate.h
//  TestPageView
//
//  Created by Jacky Zhang on 11-4-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestPageViewViewController;

@interface TestPageViewAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TestPageViewViewController *viewController;

@end
