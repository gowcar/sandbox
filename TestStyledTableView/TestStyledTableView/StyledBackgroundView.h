//
//  StyledBackgroundView.h
//  TestStyledTableView
//
//  Created by Jacky Zhang on 11-4-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  { 
    
    CellBackgroundViewPositionTop,  
    
    CellBackgroundViewPositionMiddle,  
    
    CellBackgroundViewPositionBottom, 
    
    CellBackgroundViewPositionSingle 
    
} CellBackgroundViewPosition; 

@interface StyledBackgroundView : UIView {
    UIColor *borderColor; 
    UIColor *fillColor; 
    NSInteger borderWidth;
    CellBackgroundViewPosition position; 
}

@property(nonatomic, retain) UIColor *borderColor, *fillColor; 
@property(nonatomic, assign) NSInteger borderWidth;

@property(nonatomic) CellBackgroundViewPosition position; 

@end
