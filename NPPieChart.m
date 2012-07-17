//
//  NPPieChart.m
//  SalesPad
//
//  Created by Liu Leon on 11-6-10.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import "NPPieChart.h"
#import "NPCommon.h"

@interface NPPieChart()

- (CGPoint)getTextPos:(CGSize)textSize angle:(float)angle radius:(float)r offset:(int)offset;

@end


@implementation NPPieChart

- (id)initWithFrame:(CGRect)frame context:(CGContextRef)context data:(NPChartData *)data
{
	if ((self = [super initWithFrame:frame context:context data:data]))
	{
		_itemColors = [[NSMutableArray alloc] initWithCapacity:_rawData.rows];
		for (int i = 0; i < _rawData.rows; i++)
		{
			[_itemColors addObject:[NPCommon getRandomColor]];
		}
		
		_textColor = [UIColor blackColor];
	}
	
	return self;
}

- (void)draw
{	
	[super draw];
	
	float x = _frame.origin.x + _frame.size.width/2;
	float y = _frame.origin.y + _frame.size.height/2;
	float r = 0.f;
	
	if (_frame.size.width > _frame.size.height)
	{
		r = _frame.size.height/2 * 0.8;
	}
	else 
	{
		r = _frame.size.width/2 * 0.8;
	}
	
	// Draw the pie
	CGContextSetRGBStrokeColor(_context, 0.0, 0.0, 0.0, 0.4);
	CGContextSetLineWidth(_context, 1.0);
	
	// Draw a thin line around the circle
	CGContextAddArc(_context, x, y, r, 0.0, 360.0*M_PI/180.0, 0);
	CGContextClosePath(_context);
	CGContextDrawPath(_context, kCGPathStroke);
	
	// Loop through all the values and draw the graph
	float sum = [_rawData sum];
	float startDegree = 0;
	float endDegree = 0;
	
	NSArray *category = [_rawData dataAtColumn:0];
	
	for (int i = 0; i < _rawData.rows; i++) 
	{
		UIColor *color = (UIColor *)[_itemColors objectAtIndex:i];
		float currentValue = [_rawData sumOfRow:i];
		
		float theta = 360.0 * (currentValue/sum);
		
		if (theta > 0.0) 
		{
			endDegree += theta;
			
			if (startDegree != endDegree) 
			{
				NSLog(@"startDegree: %f, endDegree: %f", startDegree-90, endDegree-90);
				[color setFill];
				CGContextMoveToPoint(_context, x, y);
				CGContextAddArc(_context, x, y, r, (startDegree-90) * M_PI/180.0, (endDegree-90)*M_PI/180.0, 0);
				CGContextClosePath(_context);
				CGContextFillPath(_context);
			}
		}
		
		NSString *text = (NSString *)[category objectAtIndex:i];
		CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:13]];
		float angle = (startDegree - 90) + (endDegree - startDegree) / 2;
		CGPoint textPoint = [self getTextPos:textSize angle:angle radius:r offset:1];
		[_textColor setFill];
		[text drawAtPoint:textPoint withFont:[UIFont systemFontOfSize:13]];
		
		startDegree = endDegree;
	}
}


- (CGPoint)getTextPos:(CGSize)textSize angle:(float)angle radius:(float)r offset:(int)offset
{
	float xPos = 0.f;
	float yPos = 0.f;
	float uAngle = angle;
	if (angle < 0) 
	{
		uAngle = angle + 360;
	}
	
	if (uAngle <= 90)
	{
		xPos = r * cos(radians(uAngle)) * offset + 5;
		yPos = r * sin(radians(uAngle)) * offset;
	}
	
	if (uAngle > 90 && uAngle <= 180)		
	{
		xPos = r * cos(radians(uAngle)) * offset - textSize.width - 5;
		yPos = r * sin(radians(uAngle)) * offset;
		
	}
	
	if (uAngle > 180 && uAngle <= 270)
	{
		xPos = r * cos(radians(uAngle)) * offset - textSize.width - 5;
		yPos = r * sin(radians(uAngle)) * offset - textSize.height;
	}
	
	if (uAngle > 270)
	{
		xPos = r * cos(radians(uAngle)) * offset + 8;
		yPos = r * sin(radians(uAngle)) * offset - textSize.height;
	}
	
	// convert to chart frame coordinate
	xPos = xPos + _frame.origin.x + _frame.size.width/2;
	yPos = yPos + _frame.origin.y + _frame.size.height/2;
	
	return CGPointMake(xPos, yPos);
}

- (void)dealloc
{
	[_itemColors release];
	[_textColor release];
	[super dealloc];
}

@end
