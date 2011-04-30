//
//  TopMusicController.m
//  GMDownloader
//
//  Created by jeremy on 4/4/11.
//  Copyright 2011 shenzhen. All rights reserved.
//

#import "PopularMusicController.h"
#import "ASIHTTPRequest.h"
#import "RegexKitLite.h"
#import "PopularMusicDetailController.h"


@interface PopularMusicDesc : NSObject {
    NSString *title;
    NSString *popularMusicListSeg;
}
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *popularMusicListSeg;
@end

@implementation PopularMusicDesc
@synthesize title,popularMusicListSeg;
-(void)dealloc{
    [self.title release];
    [self.popularMusicListSeg release];
    [super dealloc];
}
@end

@implementation PopularMusicController
@synthesize navigationController;
@synthesize popularMusicLists;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.popularMusicLists = [NSMutableArray arrayWithCapacity:6];
    }
    return self;
}

- (void)dealloc
{
    [self.popularMusicLists release];
    [self.navigationController release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(void)goCategoryAction:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)loadPopularMusicList{
    NSURL *url = [NSURL URLWithString:@"http://www.top100.cn/hot/"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *responseData = [request responseData]; 
        NSString * respStr = [[NSString alloc] initWithData:responseData encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8)];
        NSString *regexString = @"<dl class=\"\\w*\\sgnav\">\\s*<dt>\\s*<div>\\s*(.*)</div>\\s*</dt>([\\w\\W]*?)</dl>";
        
        NSArray *matchArray = [respStr arrayOfCaptureComponentsMatchedByRegex:regexString];
        NSLog(@"%d", [matchArray count]);
        
        for (int i = 0; i < [matchArray count]; i++) {
            NSString *title = [[matchArray objectAtIndex: i] objectAtIndex: 1];
            NSString *popularMusicListSeg = [[matchArray objectAtIndex: i] objectAtIndex: 2];
            PopularMusicDesc *desc = [[PopularMusicDesc alloc] init];
            desc.title = title;
            desc.popularMusicListSeg = popularMusicListSeg;
            [self.popularMusicLists addObject:desc];
            [desc release];
        }
        [self.tableView reloadData];
        
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *goCategoryButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Music Category", @"")
																   style:UIBarButtonItemStyleBordered
																  target:self
																  action:@selector(goCategoryAction:)];
	self.navigationItem.leftBarButtonItem = goCategoryButton;
    [goCategoryButton release];
    self.navigationItem.title = NSLocalizedString(@"Popular Music", @"");
    
    HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    
	// Add HUD to screen
	[self.navigationController.view addSubview:HUD];
    
	// Regisete for HUD callbacks so we can remove it from the window at the right time
	HUD.delegate = self;
    
	HUD.labelText = NSLocalizedString(@"Load Popular Music List", @"");
    
	// Show the HUD while the provided method executes in a new thread
	[HUD showWhileExecuting:@selector(loadPopularMusicList) onTarget:self withObject:nil animated:YES];
}

- (void)hudWasHidden:(MBProgressHUD *)hud{
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release]; 
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"%d", [self.popularMusicLists retainCount]);
    return [self.popularMusicLists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PopularMusicListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    PopularMusicDesc *desc = [self.popularMusicLists objectAtIndex:indexPath.row];
    cell.textLabel.text = desc.title;
    
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
     DetailViewController *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    PopularMusicDesc *desc = [self.popularMusicLists objectAtIndex:indexPath.row];
    PopularMusicDetailController *popularMusicDetailController = [[PopularMusicDetailController alloc] init];
    popularMusicDetailController.navigationController = self.navigationController;
    popularMusicDetailController.popularMusicTitle = desc.title;
    popularMusicDetailController.popularMusicListSeg = desc.popularMusicListSeg;
    popularMusicDetailController.preViewController = self;
    [self.navigationController pushViewController:popularMusicDetailController animated:TRUE];
    [popularMusicDetailController release];
}

@end
