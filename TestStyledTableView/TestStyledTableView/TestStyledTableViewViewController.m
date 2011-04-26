//
//  TestStyledTableViewViewController.m
//  TestStyledTableView
//
//  Created by Jacky Zhang on 11-4-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TestStyledTableViewViewController.h"

@implementation TestStyledTableViewViewController

@synthesize data, anotherData, opaqueview, activityIndicator;
@synthesize tableView;

- (void)dealloc
{
    [data release];
    [tableView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
//    NSLog(@"self.view.frame.size.width:%f", self.view.frame.size.width);
//    NSLog(@"self.view.frame.size.height:%f", self.view.frame.size.width);
//    NSLog(@"self.view.window.frame.size.width:%f", self.view.window.frame.size.width);
//    NSLog(@"self.view.window.frame.size.height:%f", self.view.window.frame.size.width);
//    CGRect rect=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    
//    UIImageView* campFireView = [[UIImageView alloc] initWithFrame:rect];
//    campFireView.animationImages = [NSArray arrayWithObjects:	
//                                    [UIImage imageNamed:@"campFire01.gif"],
//                                    [UIImage imageNamed:@"campFire02.gif"],
//                                    [UIImage imageNamed:@"campFire03.gif"],
//                                    [UIImage imageNamed:@"campFire04.gif"],
//                                    [UIImage imageNamed:@"campFire05.gif"],
//                                    [UIImage imageNamed:@"campFire06.gif"],
//                                    [UIImage imageNamed:@"campFire07.gif"],
//                                    [UIImage imageNamed:@"campFire08.gif"],
//                                    [UIImage imageNamed:@"campFire09.gif"],
//                                    [UIImage imageNamed:@"campFire10.gif"],
//                                    [UIImage imageNamed:@"campFire11.gif"],
//                                    [UIImage imageNamed:@"campFire12.gif"],
//                                    [UIImage imageNamed:@"campFire13.gif"],
//                                    [UIImage imageNamed:@"campFire14.gif"],
//                                    [UIImage imageNamed:@"campFire15.gif"],
//                                    [UIImage imageNamed:@"campFire16.gif"],
//                                    [UIImage imageNamed:@"campFire17.gif"], nil];
//    
//    campFireView.animationDuration = 1.75;
//    campFireView.animationRepeatCount = 0;
//    [campFireView startAnimating];
//    [self.view insertSubview:campFireView atIndex:0];
//    [self.view.window sendSubviewToBack:campFireView];
//    [campFireView release];

    self.view.backgroundColor = [UIColor blackColor];
    CGRect webRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIWebView *webView  = [[UIWebView alloc] initWithFrame: webRect];
    
    webView.userInteractionEnabled = NO;
    webView.delegate = self;
    webView.opaque = NO;
    webView.backgroundColor = [UIColor blackColor];
    
    NSURL *baseURL = [[NSBundle mainBundle] resourceURL];
    NSURL *url = [NSURL URLWithString:@"WeatherResources/Animations/rain.html" relativeToURL:baseURL];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [url release];
    
    self.opaqueview = [[UIView alloc] initWithFrame: CGRectMake(0 ,0 ,100 ,100)];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(0 ,0 , 60, 60)];

    opaqueview.center = self.view.center;
    activityIndicator.center = self.view.center;
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    opaqueview.backgroundColor = [UIColor blackColor];
    opaqueview.alpha = 0.6;
    opaqueview.hidden = YES ;

    [self.view insertSubview:webView atIndex:0];
    [opaqueview addSubview: activityIndicator];
    [self.view addSubview:opaqueview];
    [self.view.window sendSubviewToBack:webView];

    
    NSURL *imgURL = [NSURL URLWithString:@"WeatherResources/Images/28.png" relativeToURL:baseURL];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgURL]] ;
    [imgURL release];
    
    CGRect rect = CGRectMake(self.view.frame.size.width/2, 40, img.size.width, img.size.height);
    UIImageView* campFireView = [[UIImageView alloc] initWithFrame:rect];
    campFireView.image = img;
    [self.view addSubview:campFireView];
    
    
    data = [[NSArray alloc] initWithObjects:@"北京", @"上海", @"广州", @"深圳", @"重庆", nil];
    anotherData = [[NSArray alloc] initWithObjects:@"山东", @"青岛", @"大连", @"海口", @"沈阳", nil];
    tableView.dataSource = self;
    tableView.delegate = self;
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView.backgroundColor = [UIColor clearColor];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];  
    //[self.view.window bringSubviewToFront:tableView];
    [super viewDidLoad];
}

- (void )webViewDidFinishLoad:(UIWebView *)webView {
    [activityIndicator stopAnimating];
    opaqueview.hidden  = YES ;
}

- (void )webViewDidStartLoad:(UIWebView *)webView {     
    [ activityIndicator startAnimating ]; 
    opaqueview.hidden  = NO ;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdnetifier = @"cellIdnetifier";
	StyledCellView *cell = (StyledCellView *)[aTableView dequeueReusableCellWithIdentifier: cellIdnetifier];
	if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StyledCellView" owner:self options:nil];
        cell=(StyledCellView *)[nib objectAtIndex:0];
        //cell.backgroundColor = [UIColor clearColor];
        //cell.contentView.backgroundColor = [UIColor clearColor];
	}
    StyledBackgroundView *bgView = [[StyledBackgroundView alloc] initWithFrame:CGRectZero];
    bgView.borderColor = [UIColor grayColor];
    bgView.fillColor = [UIColor lightGrayColor];
    bgView.alpha = 0.3;
    
    if (indexPath.row == 0) {
        bgView.position = CellBackgroundViewPositionTop;
    } else if (indexPath.row == 4) {
        bgView.position = CellBackgroundViewPositionBottom;
    } else {
        bgView.position = CellBackgroundViewPositionMiddle;
    }
    cell.backgroundView = bgView;
    NSInteger row = indexPath.row;
	cell.city.text = [[data objectAtIndex:row] autorelease];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSInteger height = 10;
    switch (row) {
        case 0:
            height = 80;
            break;
        case 4:
            height = 60;
            break;
            
        default:
            height = 40;
            break;
    }
    return height;
}

- (IBAction) refresh: (id)sender {
    [data release];
    data = [anotherData retain];
    [tableView reloadData];
}


@end
