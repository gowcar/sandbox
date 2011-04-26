//
//  StyledBackgroundView.m
//  TestStyledTableView
//
//  Created by Jacky Zhang on 11-4-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "StyledBackgroundView.h"

#define ROUND_SIZE 10 
static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,float ovalHeight); 

@implementation StyledBackgroundView

@synthesize borderColor, fillColor, position, borderWidth; 


- (BOOL) isOpaque { 
    return NO; 
} 

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!borderWidth) borderWidth = 1;
        // Initialization code
    }
    return self;
}

- (void)drawRect2:(CGRect)rect
{
    CGContextRef c = UIGraphicsGetCurrentContext(); 
    CGContextSetFillColorWithColor(c, [fillColor CGColor]); 
    CGContextSetStrokeColorWithColor(c, [borderColor CGColor]); 
    
    if (position == CellBackgroundViewPositionTop) { 
        
        CGContextFillRect(c, CGRectMake(0.0f, rect.size.height - 10.0f, rect.size.width, 10.0f)); 
        CGContextBeginPath(c); 
        CGContextMoveToPoint(c, 0.0f, rect.size.height - 10.0f); 
        CGContextAddLineToPoint(c, 0.0f, rect.size.height); 
        CGContextAddLineToPoint(c, rect.size.width, rect.size.height); 
        CGContextAddLineToPoint(c, rect.size.width, rect.size.height - 10.0f); 
        CGContextStrokePath(c); 
        CGContextClipToRect(c, CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height - 10.0f)); 

    } else if (position == CellBackgroundViewPositionBottom) { 
        CGContextFillRect(c, CGRectMake(0.0f, 0.0f, rect.size.width, 10.0f)); 
        CGContextBeginPath(c); 
        CGContextMoveToPoint(c, 0.0f, 10.0f); 
        CGContextAddLineToPoint(c, 0.0f, 0.0f); 
        CGContextStrokePath(c); 
        CGContextBeginPath(c); 
        CGContextMoveToPoint(c, rect.size.width, 0.0f); 
        CGContextAddLineToPoint(c, rect.size.width, 10.0f); 
        CGContextStrokePath(c); 
        CGContextClipToRect(c, CGRectMake(0.0f, 10.0f, rect.size.width, rect.size.height)); 
        
    } else if (position == CellBackgroundViewPositionMiddle) { 
        CGContextFillRect(c, rect); 
        CGContextBeginPath(c); 
        CGContextMoveToPoint(c, 0.0f, 0.0f); 
        CGContextAddLineToPoint(c, 0.0f, rect.size.height); 
        CGContextAddLineToPoint(c, rect.size.width, rect.size.height); 
        CGContextAddLineToPoint(c, rect.size.width, 0.0f); 
        CGContextStrokePath(c); 
        return; 
    } 
    
    CGContextBeginPath(c); 
    addRoundedRectToPath(c, rect, 10.0f, 10.0f); 
    
    CGContextFillPath(c);   
    CGContextSetLineWidth(c, 1);   
    
    CGContextBeginPath(c); 
    addRoundedRectToPath(c, rect, 10.0f, 10.0f);   
    CGContextStrokePath(c); 
}

-(void)drawRect:(CGRect)rect  

{ 
    CGContextRef c = UIGraphicsGetCurrentContext(); 
    CGContextSetFillColorWithColor(c, [fillColor CGColor]); 
    CGContextSetStrokeColorWithColor(c, [borderColor CGColor]); 
    CGContextSetLineWidth(c, borderWidth);
    
    if (position == CellBackgroundViewPositionTop) { 
        CGFloat minx = CGRectGetMinX(rect) , midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect) ; 
        CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ; 
        
        minx = minx + 1; 
        miny = miny + 1; 
        maxx = maxx - 1; 
        maxy = maxy ; 
        
        CGContextMoveToPoint(c, minx, maxy); 
        CGContextAddArcToPoint(c, minx, miny, midx, miny, ROUND_SIZE); 
        CGContextAddArcToPoint(c, maxx, miny, maxx, maxy, ROUND_SIZE); 
        CGContextAddLineToPoint(c, maxx, maxy); 

        CGContextClosePath(c); 
        
        CGContextDrawPath(c, kCGPathFillStroke); 
        return; 
        
    } else if (position == CellBackgroundViewPositionBottom) { 
        CGFloat minx = CGRectGetMinX(rect) , midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect) ; 
        CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ; 

        minx = minx + 1; 
        miny = miny ; 
        maxx = maxx - 1; 
        maxy = maxy - 1; 
        
        CGContextMoveToPoint(c, minx, miny); 
        CGContextAddArcToPoint(c, minx, maxy, midx, maxy, ROUND_SIZE); 
        CGContextAddArcToPoint(c, maxx, maxy, maxx, miny, ROUND_SIZE); 
        CGContextAddLineToPoint(c, maxx, miny); 
        
        CGContextClosePath(c); 
        CGContextDrawPath(c, kCGPathFillStroke); 
        return; 
        
    } else if (position == CellBackgroundViewPositionMiddle) { 
        CGFloat minx = CGRectGetMinX(rect) , maxx = CGRectGetMaxX(rect) ; 
        CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ; 
        
        minx = minx + 1; 
        miny = miny ; 
        maxx = maxx - 1; 
        maxy = maxy ; 
        
        CGContextMoveToPoint(c, minx, miny); 
        CGContextAddLineToPoint(c, maxx, miny); 
        CGContextAddLineToPoint(c, maxx, maxy); 
        CGContextAddLineToPoint(c, minx, maxy); 
        CGContextClosePath(c); 
        
        CGContextDrawPath(c, kCGPathFillStroke); 
        return; 
    } 
}

- (void)dealloc
{
    [borderColor release]; 
    [fillColor release]; 
    [super dealloc];
}

@end

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,float ovalHeight) { 
    float fw, fh; 
    if (ovalWidth == 0 || ovalHeight == 0) {// 1 
        CGContextAddRect(context, rect); 
        return; 
    } 
    
    CGContextSaveGState(context);// 2 
    CGContextTranslateCTM (context, CGRectGetMinX(rect),// 3 
                           CGRectGetMinY(rect)); 
    CGContextScaleCTM (context, ovalWidth, ovalHeight);// 4 
    fw = CGRectGetWidth (rect) / ovalWidth;// 5 
    fh = CGRectGetHeight (rect) / ovalHeight;// 6 
    
    CGContextMoveToPoint(context, fw, fh/2); // 7 

    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);// 8 
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);// 9 
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);// 10 
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // 11 
    
    CGContextClosePath(context);// 12 
    CGContextRestoreGState(context);// 13 
} 