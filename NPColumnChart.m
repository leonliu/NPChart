//
//  NPColumnChart.m
//  SalesPad
//
//  Created by Liu Leon on 11-6-10.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import "NPColumnChart.h"
#import "NPChartAxis.h"
#import "NPChartBar.h"
#import "NPCommon.h"

@implementation NPColumnChart

@synthesize type = _type;

- (float)getYAxisPosition:(float)value
{
	float yPos;
	
	if (_axis_Y.isCategory) 
	{
		float pixelsPerTick = _axis_Y.length / _axis_Y.numOfTicks;
		yPos = _axis_Y.startPoint.y - value * pixelsPerTick;
	}
	else 
	{
		// (value - axis.min)/pixels = (axis.max - axis.min)/axis.length
		float distance = (_axis_Y.length / (_axis_Y.maxValue - _axis_Y.minValue)) * (value - _axis_Y.minValue);
		yPos = _axis_Y.startPoint.y - distance;
	}
	
	NSLog(@"yPos = %f", yPos);
	return yPos;
}

- (float)getXAxisPosition:(float)value
{
	float xPos;
	if (_axis_X.isCategory) 
	{
		float pixelsPerTick = _axis_X.length / _axis_X.numOfTicks;
		xPos = _axis_X.startPoint.x + value * pixelsPerTick;
	}
	else 
	{
		// (value - axis.min)/pixels = (axis.max - axis.min)/axis.length
		float distance = (_axis_X.length / (_axis_X.maxValue - _axis_X.minValue)) * (value - _axis_X.minValue);
		xPos = _axis_Y.startPoint.x + distance;
	}
	
	NSLog(@"xPos = %f", xPos);
	return xPos;
}

- (id)initWithFrame:(CGRect)frame context:(CGContextRef)context data:(NPChartData *)data
{
	if (self = [super initWithFrame:frame context:context data:data]) 
	{
		// NPColumnChartTypeCluster by default
		_type = NPColumnChartTypeCluster;
		
		NSUInteger columns = _rawData.columns - 1;
		_columnColors = [[NSMutableArray alloc] initWithCapacity:columns];
		for (int i = 0; i < columns; i++)
		{
			[_columnColors addObject:[NPCommon getRandomColor]];
		}
		
		// create the X axis and Y axis
		float min = [_rawData minDataValue];
		float max = [_rawData maxDataValue];
		
		NSArray *xLables = [_rawData dataAtColumn:0];
		
		// X axis is category, Y axis is value
		_axis_X = [[NPChartAxis alloc] initWithLabels:xLables];
		_axis_Y = [[NPChartAxis alloc] initWithData:min max:max count:[_rawData count]];
		
		_axis_X.type = NPChartAxisTypeX;
		_axis_Y.type = NPChartAxisTypeY;
		
		// chart coordinate starts from left bottom of the plot area
		_axis_X.startPoint = CGPointMake(_frame.origin.x + XAXIS_OFFSET - 1, 
										 _frame.origin.y + _frame.size.height - YAXIS_OFFSET);
		_axis_X.length = _frame.size.width - 2 * XAXIS_OFFSET;
		
		_axis_Y.startPoint = CGPointMake(_frame.origin.x + XAXIS_OFFSET, 
										 _frame.origin.y + _frame.size.height - YAXIS_OFFSET);
		_axis_Y.length = _frame.size.height - 2 * YAXIS_OFFSET;
		
		_axis_X.title = (NSString *)[_rawData titleOfColumn:0];
		_axis_Y.title = @"Test";
	}
	
	return self;
}

- (void)draw
{
	[super draw];
	
	// draw X-axis and Y-axis
	[_axis_X drawAxis:_context];
	[_axis_Y drawAxis:_context];
	
	// Draw columns
	float pixelsPerTick = _axis_X.length / _axis_X.numOfTicks;
	
	for (int i = 0; i < _rawData.rows; i++)
	{
		NSArray *rowData = [_rawData dataAtRow:i];
		NSUInteger columns = _rawData.columns - 1;
		
		float barWidth = pixelsPerTick/(columns + 2);
		float xPos = [self getXAxisPosition:(i+1)];
		
		for (int j = 0; j < columns; j++)
		{
			float value = [(NSNumber *)[rowData objectAtIndex:j] floatValue];
			NPChartBar *bar = [[NPChartBar alloc] init];
			bar.orientation = NPChartBarVertical;
			bar.x = xPos - pixelsPerTick + (pixelsPerTick - columns * barWidth)/2 + j*barWidth + barWidth/2;
			bar.y = _axis_X.startPoint.y;
			bar.width = barWidth;
			bar.height = _axis_Y.startPoint.y - [self getYAxisPosition:value];
			bar.fillColor = (UIColor *)[_columnColors objectAtIndex:j];
			
			[bar drawBar:_context];
			[bar release];
		}
	}
}

- (void)dealloc
{
	[_axis_X release];
	[_axis_Y release];
	[_columnColors release];
	[super dealloc];
}

@end
