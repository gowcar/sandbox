//
//  PopularMusicDetailController.h
//  GMDownloader
//
//  Created by jeremy on 4/5/11.
//  Copyright 2011 shenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ASINetworkQueue.h"


@interface PopularMusicDetailController : UITableViewController <MBProgressHUDDelegate>{
    UINavigationController *navigationController;
    NSString *popularMusicTitle;
    UITableViewController *preViewController;
    NSString *popularMusicListSeg;
    MBProgressHUD *HUD;
    NSMutableArray *musicAlbumDatas;
    ASINetworkQueue *requestQueue;
}
@property(nonatomic, retain) UINavigationController *navigationController;
@property(nonatomic, copy) NSString *popularMusicTitle;
@property(nonatomic, copy) NSString *popularMusicListSeg;
@property(nonatomic, retain) UITableViewController *preViewController;
@property(nonatomic, retain) NSMutableArray *musicAlbumDatas;
@property(nonatomic,retain) ASINetworkQueue *requestQueue;
@end
