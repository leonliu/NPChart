//
//  NPChartPoint.h
//  SalesPad
//
//  Created by Liu Leon on 11-5-24.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPLineChart.h"


@interface NPChartPoint : NSObject 
{
	// position relative to the upper left point of the drawing surface (UIView frame)
	CGFloat     x;
	CGFloat     y;
	
	NSString	*text;
	NPChartPointType type;
	
	// valid for point type other than NPChartPointTypeNone
	UIColor     *fillColor; 
	UIColor     *strokeColor;
}

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, assign) NPChartPointType type;
@property (nonatomic, retain) UIColor *fillColor;
@property (nonatomic, retain) UIColor *strokeColor;

-(void)drawPoint:(CGContextRef)context;

@end