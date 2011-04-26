//
//  HelloWorld2AppDelegate.h
//  HelloWorld2
//
//  Created by Jacky Zhang on 11-4-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HelloWorld2ViewController;

@interface HelloWorld2AppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet HelloWorld2ViewController *viewController;

@end
