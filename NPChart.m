//
//  NPChart.m
//  SalesPad
//
//  Created by Liu Leon on 11-5-24.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import "NPChart.h"
#import "NPChartTick.h"
#import "NPChartAxis.h"
#import "NPChartBar.h"
#import "NPChartPoint.h"
#import "NPChartLine.h"
#import "NPCommon.h"


@implementation NPChart

@synthesize backgroundColor = _backgroundColor;
@synthesize title = _title;
@synthesize delegate = _delegate;


#pragma mark -
#pragma mark public methods
#
- (id)initWithFrame:(CGRect)frame context:(CGContextRef)context data:(NPChartData *)data
{
	if ((self = [super init]))
	{
		_context = context;
		_frame = frame;
		_title = @"";
		_backgroundColor = [UIColor whiteColor];
		_rawData = [data retain];
	}
	
	return self;
}

- (void)draw
{
	// draw background
	[_backgroundColor set];
	UIRectFill(_frame);
}

- (void)dealloc
{
	[_backgroundColor release];
	[_title release];
	[_rawData release];
	[super dealloc];
}

@end 