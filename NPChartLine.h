//
//  NPChartLine.h
//  SalesPad
//
//  Created by Liu Leon on 11-5-24.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NPChartPoint;

@interface NPChartLine : NSObject 
{
	NSMutableArray	    *points;		// NPChartPoint Array
	NSString        	*text;          // line name
	UIColor	            *color;			// line color
	UIColor             *textColor;
	int			        lineWidth;
}

@property(nonatomic,retain) NSMutableArray *points;
@property(nonatomic,retain) NSString *text;
@property(nonatomic,retain) UIColor *color;
@property(nonatomic,retain) UIColor *textColor;
@property(nonatomic,assign) int lineWidth;

- (void)drawLine:(CGContextRef)context;
- (void)addPoint:(NPChartPoint *)point;

@end