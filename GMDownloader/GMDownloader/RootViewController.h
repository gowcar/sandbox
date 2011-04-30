//
//  RootViewController.h
//  GMDownloader
//
//  Created by jeremy on 3/20/11.
//  Copyright 2011 shenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
    NSDictionary *gmCategoryData;
    UINavigationController *navigationController;
}
@property(nonatomic,retain) NSDictionary *gmCategoryData;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@end
