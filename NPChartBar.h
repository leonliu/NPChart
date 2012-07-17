//
//  NPChartBar.h
//  SalesPad
//
//  Created by Liu Leon on 11-5-24.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPChart.h"

@interface NPChartBar : NSObject 
{
	NSString	*text;
	UIColor     *fillColor;
	
	float		x;
	float       y;
	float       width;
	float       height;
	
	NPChartBarOrientation orientation;
}

@property(nonatomic,retain) NSString *text;
@property(nonatomic,retain) UIColor *fillColor;
@property(nonatomic,assign) float x;
@property(nonatomic,assign) float y;
@property(nonatomic,assign) float width;
@property(nonatomic,assign) float height;
@property(nonatomic,assign) NPChartBarOrientation orientation;

- (void)drawBar:(CGContextRef)context;

@end