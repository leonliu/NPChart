//
//  NPLineChart.m
//  SalesPad
//
//  Created by Liu Leon on 11-6-10.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import "NPLineChart.h"
#import "NPChartTick.h"
#import "NPChartAxis.h"
#import "NPChartPoint.h"
#import "NPChartLine.h"
#import "NPCommon.h"


@interface NPLineChart()

- (float)getYAxisPosition:(float)value;
- (float)getXAxisPosition:(float)value;

@end


@implementation NPLineChart

@synthesize pointType = _pointType;


#pragma mark -
#pragma mark private methods
#
- (float)getYAxisPosition:(float)value
{
	// Y axis is always value axis in line chart
	float yPos;
	
	// (value - axis.min)/pixels = (axis.max - axis.min)/axis.length
	float distance = (_axis_Y.length / (_axis_Y.maxValue - _axis_Y.minValue)) * (value - _axis_Y.minValue);
	yPos = _axis_Y.startPoint.y - distance;
	
	NSLog(@"yPos = %f", yPos);
	return yPos;
}

- (float)getXAxisPosition:(float)value
{
	// X axis is always category axis in line chart
	float xPos;
	float pixelsPerTick = _axis_X.length / _axis_X.numOfTicks;
	xPos = _axis_X.startPoint.x + value * pixelsPerTick;
	
	NSLog(@"xPos = %f", xPos);
	return xPos;
}


#pragma mark -
#pragma mark public methods
#
- (id)initWithFrame:(CGRect)frame context:(CGContextRef)context data:(NPChartData *)data
{
	if ((self = [super initWithFrame:frame context:context data:data]))
	{
		_pointType = NPChartPointTypeCircle;
		
		// X axis is always category in line chart;
		float min = [_rawData minDataValue];
		float max = [_rawData maxDataValue];
		
		NSArray *xLables = [_rawData dataAtColumn:0];
		
		_axis_X = [[NPChartAxis alloc] initWithLabels:xLables];
		_axis_Y = [[NPChartAxis alloc] initWithData:min max:max count:[_rawData count]];
		
		_axis_X.type = NPChartAxisTypeX;
		_axis_Y.type = NPChartAxisTypeY;
		
		_axis_X.startPoint = CGPointMake(_frame.origin.x + XAXIS_OFFSET - 1, 
										 _frame.origin.y + _frame.size.height - YAXIS_OFFSET);
		_axis_X.length = _frame.size.width - 2 * XAXIS_OFFSET;
		
		_axis_Y.startPoint = CGPointMake(_frame.origin.x + XAXIS_OFFSET, 
										 _frame.origin.y + _frame.size.height - YAXIS_OFFSET);
		_axis_Y.length = _frame.size.height - 2 * YAXIS_OFFSET;
		
		_axis_X.title = (NSString*)[_rawData titleOfColumn:0];
		_axis_Y.title = @"Test";		
	}
	
	return self;
}

- (void)draw
{	
	[super draw];
	
	[_axis_X drawAxis:_context];
	[_axis_Y drawAxis:_context];
	
	// draw lines
	int lines = [_rawData columns] - 1;
	
	for (int i = 0; i < lines; i++) 
	{
		NSArray *lineData = [_rawData dataAtColumn:(i+1)];
		NPChartLine *line = [[NPChartLine alloc] init];
		int pointCount = [lineData count];
		
		for (int j = 0; j < pointCount; j++) 
		{
			float value = [(NSNumber *)[lineData objectAtIndex:j] floatValue];
			
			NPChartPoint *point = [[NPChartPoint alloc] init];
			point.x = [self getXAxisPosition:(j+1)];
			point.y = [self getYAxisPosition:value];
			point.type = NPChartPointTypeCircle;
			point.text = [NSString stringWithFormat:@"%f", value];
			
			[line addPoint:point];
			[point release];
		}
		
		[line drawLine:_context];
		[line release];
	}
}

- (void)dealloc
{
	[_axis_X release];
	[_axis_Y release];
	[super dealloc];
}

@end
