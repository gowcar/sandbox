//
//  HelloWorld3AppDelegate.h
//  HelloWorld3
//
//  Created by Jacky Zhang on 11-4-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HelloWorld3ViewController;

@interface HelloWorld3AppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet HelloWorld3ViewController *viewController;

@end
