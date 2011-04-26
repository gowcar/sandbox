//
//  HelloWorld1AppDelegate.h
//  HelloWorld1
//
//  Created by Jacky Zhang on 11-4-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HelloWorld1ViewController;

@interface HelloWorld1AppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet HelloWorld1ViewController *viewController;

@end
