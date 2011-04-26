//
//  TestPageViewViewController.m
//  TestPageView
//
//  Created by Jacky Zhang on 11-4-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TestPageViewViewController.h"

@implementation TestPageViewViewController

@synthesize pageControl;
@synthesize scrollView;

- (void)dealloc
{
    [pageControl dealloc];
    [scrollView dealloc];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    NSInteger kNumberOfPages = 2;
//    pageControl.numberOfPages=page;
//    //[scrollView setContentSize:CGSizeMake(320*(30/6 +1), 331)];
//    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * page,scrollView.frame.size.height - 50);
//    scrollView.pagingEnabled = YES;
//    [scrollView setDelegate:self];
//    
//    //CGSizeMake(scrollView.frame.size.width * page,scrollView.frame.size.height);
//
//    for (int i = 0; i<2; i++) {
//        NSArray* nib = [[NSBundle mainBundle] loadNibNamed: @"MyPage1" owner: self options: nil];
//        UIView *catlg = [nib objectAtIndex: 0];
//        NSInteger pageNum = i /6;
//        CGRect frame = CGRectMake(0, 0,60,60);
//        frame.origin = CGPointMake(60*pageNum, (i%6)*65+5);
//        catlg.frame = frame;
//        //NSString *str=[[NSString alloc]initWithFormat:@"%d",i];
//        //catlg.m_label.text=str;
//        [scrollView addSubview:catlg];
//    }
//    
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    scrollView.canCancelContentTouches = YES;
    
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
    MyPage1 *controller1 = [[MyPage1 alloc] initWithNibName:@"MyPage1" bundle:nil];
    
        CGRect frame1 = scrollView.frame;
        frame1.origin.x = frame1.size.width * 0;
        frame1.origin.y = 0;
        controller1.view.frame = frame1;
        [scrollView addSubview:controller1.view];
    
    MyPage2 *controller2 = [[MyPage2 alloc] initWithNibName:@"MyPage2" bundle:nil];
    
    CGRect frame2 = scrollView.frame;
    frame2.origin.x = frame2.size.width * 1;
    frame2.origin.y = 0;
    controller2.view.frame = frame2;
    
    [scrollView addSubview:controller2.view ];
    [super viewDidLoad];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    [UIView beginAnimations:@"animationID" context:nil];
//    [UIView setAnimationDuration:0.8f];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationRepeatAutoreverses:NO];
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view.window cache:YES];
//    [UIView commitAnimations];
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
