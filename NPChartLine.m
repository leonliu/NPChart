//
//  NPChartLine.m
//  SalesPad
//
//  Created by Liu Leon on 11-5-24.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import "NPChartLine.h"
#import "NPChartPoint.h"

@implementation NPChartLine

@synthesize points;
@synthesize text;
@synthesize color;
@synthesize textColor;
@synthesize lineWidth;

- (id)init
{
	if ((self = [super init]))
	{
		points = [[NSMutableArray alloc] init];
		text = @"";
		color = [UIColor blueColor];
		textColor = [UIColor blackColor];
		lineWidth = 2;
	}
	return self;
}

- (void)dealloc
{
	[points release];
	[text release];
	[color release];
	[textColor release];
	[super dealloc];
}

- (void)drawLine:(CGContextRef)context
{
	NSUInteger pointCount = [points count];
	if (pointCount < 2) 
	{
		return;
	}
	
	CGContextBeginPath(context);
	CGContextSetLineWidth(context, lineWidth);
	
	for (uint i = 0; i < pointCount -1; i++) 
	{
		NPChartPoint *startPoint = (NPChartPoint*)[points objectAtIndex:i];
		NPChartPoint *endPoint = (NPChartPoint*)[points objectAtIndex:(i+1)];
		
		CGContextMoveToPoint(context, startPoint.x, startPoint.y);
		CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
		CGContextClosePath(context);
		[color setStroke];
		CGContextStrokePath(context);
		
		[startPoint drawPoint:context];
	}
	
	// Draw the last point
	NPChartPoint *lastPoint = (NPChartPoint*)[points lastObject];
	[lastPoint drawPoint:context];
}

- (void)addPoint:(NPChartPoint *)point
{
	NSAssert(point != nil, @"nil input");
	[points addObject:point];
}

@end