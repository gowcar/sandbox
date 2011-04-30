//
//  PopularMusicDetailController.m
//  GMDownloader
//
//  Created by jeremy on 4/5/11.
//  Copyright 2011 shenzhen. All rights reserved.
//

#import "PopularMusicDetailController.h"
#import "RegexKitLite.h"
#import "ASIHTTPRequest.h"

@interface MusicAlbum : NSObject {
@private
    NSString *key;
    NSString *title;
}
@property (nonatomic,copy) NSString *key;
@property (nonatomic,copy) NSString *title;
@end

@implementation MusicAlbum
@synthesize key,title;
@end

@implementation PopularMusicDetailController
@synthesize navigationController;
@synthesize popularMusicTitle,popularMusicListSeg;
@synthesize preViewController;
@synthesize musicAlbumDatas;
@synthesize requestQueue;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.musicAlbumDatas = [NSMutableArray arrayWithCapacity:100];
        self.requestQueue = [[ASINetworkQueue alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [self.requestQueue cancelAllOperations];
    [self.requestQueue release];
    [self.musicAlbumDatas release];
    [self.preViewController release];
    [self.popularMusicListSeg release];
    [self.popularMusicTitle release];
    [self.navigationController release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)goPopularMusicAction:(id)sender{
    [self.navigationController popToViewController:preViewController animated:TRUE];
}

/*
- (void)queueComplete:(ASINetworkQueue *)queue
{
    NSLog(@"Finished: %f", [self.progressView progress] * 100);
}
 */


- (void)requestFinished:(ASIHTTPRequest *)top100Request
{
    NSArray *cookies = [top100Request responseCookies];
    NSString * top100ResponseString = [[NSString alloc] initWithData:[top100Request responseData] encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8)];
    NSString *songRegexString = @"<a href=\"http://www.top100.cn/download/dl.ashx\\?n=(.*)\\.mp3&al=(.*)\">.*</a>"; 
    NSArray *songMatchArray = NULL;
    songMatchArray = [top100ResponseString arrayOfCaptureComponentsMatchedByRegex:songRegexString];
    NSLog(@"%@", songMatchArray);
    [top100ResponseString release];
    NSDictionary *userInfo = [top100Request userInfo];
    MusicAlbum *album = [userInfo objectForKey:@"currentAlbum"];
    [requestQueue cancelAllOperations];
    //[requestQueue setDownloadProgressDelegate:self.progressView];
    //[requestQueue setDelegate:self];
    //[requestQueue setRequestDidFinishSelector:@selector(queueComplete:)];
    for (int i = 0; i < [songMatchArray count]; i++) {
        NSString *alValue = [[songMatchArray objectAtIndex: i] objectAtIndex: 2];
        NSString *downloadFileName = [[songMatchArray objectAtIndex: i] objectAtIndex: 1];
        NSString *downloadUrl = [[NSString alloc] initWithFormat:@"http://www.top100.cn/download/dl.ashx?n=%@.mp3&al=%@",[downloadFileName stringByReplacingOccurrencesOfRegex:@"\\s" withString:@"+"],alValue];
        NSLog(@"%@", downloadUrl);
        NSString* downloadFileNameDecodeByUTF8AndURI = [downloadFileName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@", downloadFileNameDecodeByUTF8AndURI);
        
        NSURL *songUrl = [NSURL URLWithString:downloadUrl];
        ASIHTTPRequest *songRequest = [ASIHTTPRequest requestWithURL:songUrl];
        [songRequest setUseCookiePersistence:NO];
        [songRequest setRequestCookies:[cookies mutableCopy]];
        
        [songRequest addRequestHeader:@"Accept" value:@"application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5"];
        
        [songRequest addRequestHeader:@"Referer" value:[[NSString alloc] initWithFormat:@"http://www.top100.cn/download/download.aspx?Productid=%@", album.key]];
        [songRequest addRequestHeader:@"User-Agent" value:@"AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5"];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *savedFileName = [[NSString alloc] initWithFormat:@"%@-%@.mp3", album.title, downloadFileNameDecodeByUTF8AndURI];
        NSString *destLocation = [[paths objectAtIndex:0] stringByAppendingPathComponent:savedFileName];
        [savedFileName release];
        [songRequest setDownloadDestinationPath:destLocation];
        [requestQueue addOperation:songRequest];
    }
    [requestQueue go];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    //NSError *error = [request error];
}

- (void)downloadMusic:(id)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if(indexPath != nil){
        MusicAlbum *album = [self.musicAlbumDatas objectAtIndex:indexPath.row];
        NSString *top100UrlStr = [[NSString alloc] initWithFormat:@"http://www.top100.cn/download/download.aspx?Productid=%@", album.key];
        NSURL *top100Url = [NSURL URLWithString:top100UrlStr];
        ASIHTTPRequest *top100Request = [ASIHTTPRequest requestWithURL:top100Url];
        NSMutableDictionary *userinfo = [NSMutableDictionary dictionaryWithCapacity:1];
        [userinfo setObject:album forKey:@"currentAlbum"];
        [top100Request setUserInfo:userinfo];
        [top100Request setDelegate:self];
        [top100Request startAsynchronous];
    }
}

- (void)loadPopularMusicDetails{
    NSString *regexString = @" <li class=\"l5\"><a href=\"../album/index-s(\\w+).shtml\" class=\"a3\"\\s*title=\"(.*)\">";
    
    NSArray *matchArray = [self.popularMusicListSeg arrayOfCaptureComponentsMatchedByRegex:regexString];
    NSLog(@"%d", [matchArray count]);
    
    for (int i = 0; i < [matchArray count]; i++) {
        NSString *key = [[matchArray objectAtIndex: i] objectAtIndex: 1];
        NSString *title = [[matchArray objectAtIndex: i] objectAtIndex: 2];
        MusicAlbum *album = [[MusicAlbum alloc] init];
        album.key = key;
        album.title = title;
        [musicAlbumDatas addObject:album];
        [album release];
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *goPopularMusicButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Popular Music", @"")
                                                                         style:UIBarButtonItemStyleBordered
                                                                        target:self
                                                                        action:@selector(goPopularMusicAction:)];
	self.navigationItem.leftBarButtonItem = goPopularMusicButton;
    [goPopularMusicButton release];
    UIBarButtonItem *downloadPopularMusicButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Download", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(downloadMusic:)];
    self.navigationItem.rightBarButtonItem = downloadPopularMusicButton;
    [downloadPopularMusicButton release];
    self.navigationItem.title = NSLocalizedString(@"Popular Music Details", @"");
    
    HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    
	// Add HUD to screen
	[self.navigationController.view addSubview:HUD];
    
	// Regisete for HUD callbacks so we can remove it from the window at the right time
	HUD.delegate = self;
    
	HUD.labelText = NSLocalizedString(@"Load Popular Music Details", @"");
    
	// Show the HUD while the provided method executes in a new thread
	[HUD showWhileExecuting:@selector(loadPopularMusicDetails) onTarget:self withObject:nil animated:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [musicAlbumDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MusicAlbumCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    MusicAlbum *album = [musicAlbumDatas objectAtIndex:indexPath.row];
    cell.textLabel.text = album.title;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)hudWasHidden:(MBProgressHUD *)hud{
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release]; 
}

@end
