//
//  TestStyledTableViewAppDelegate.h
//  TestStyledTableView
//
//  Created by Jacky Zhang on 11-4-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestStyledTableViewViewController;

@interface TestStyledTableViewAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TestStyledTableViewViewController *viewController;

@end
