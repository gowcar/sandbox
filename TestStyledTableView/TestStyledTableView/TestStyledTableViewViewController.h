//
//  TestStyledTableViewViewController.h
//  TestStyledTableView
//
//  Created by Jacky Zhang on 11-4-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StyledCellView.h"
#import "StyledBackgroundView.h"

@interface TestStyledTableViewViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate> {
    UIView *opaqueview;
    UIActivityIndicatorView *activityIndicator;
}
@property(nonatomic, retain) UIView *opaqueview;
@property(nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property(nonatomic, retain) NSArray *data;
@property(nonatomic, retain) NSArray *anotherData;
@property(nonatomic, retain) IBOutlet UITableView *tableView;

- (IBAction) refresh: (id)sender;

@end
