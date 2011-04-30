//
//  TopMusicController.h
//  GMDownloader
//
//  Created by jeremy on 4/4/11.
//  Copyright 2011 shenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface PopularMusicController : UITableViewController <MBProgressHUDDelegate> {
    UINavigationController *navigationController;
    MBProgressHUD *HUD;
    NSMutableArray *popularMusicLists;
}
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) NSMutableArray *popularMusicLists;
@end
