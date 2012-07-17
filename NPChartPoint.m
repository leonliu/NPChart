//
//  NPChartPoint.m
//  SalesPad
//
//  Created by Liu Leon on 11-5-24.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import "NPChartPoint.h"
#import "NPCommon.h"

@implementation NPChartPoint

@synthesize x;
@synthesize y;
@synthesize text;
@synthesize type;
@synthesize fillColor;
@synthesize strokeColor;

- (id)init
{
	if ((self = [super init]))
	{
		x = 0.f;
		y = 0.f;
		text = @"";
		type = NPChartPointTypeNone;
		fillColor = nil;
		strokeColor = nil;
	}
	return self;
}

- (void)dealloc
{
	[text release];
	[fillColor release];
	[strokeColor release];
	
	[super dealloc];
}

-(void)drawPoint:(CGContextRef)context
{	
	int diameter = 5;
	
	switch (type) 
	{
		case NPChartPointTypeCircle:
		{
			float radius = diameter * 0.5;
			CGRect oval = CGRectMake(x - radius, y - radius, diameter, diameter);
			[fillColor setFill];
			CGContextAddEllipseInRect(context, oval);
			CGContextFillPath(context);
			CGContextAddArc(context, x, y, radius, 0, 2*M_PI, 1);
			[strokeColor setStroke];
			CGContextStrokePath(context);
			
			break;
		}
		case NPChartPointTypeTriangle:
		{
			int offsetX = cos(radians(30))*diameter;
			int offsetY = sin(radians(30))*diameter;
			
			float point1X = x - offsetX;
			float point1Y = y + offsetY;
			
			float point2X = x;
			float point2Y = y - diameter;
			
			float point3X = x + offsetX;
			float point3Y = y + offsetY;
			
			CGContextBeginPath(context);
			CGContextMoveToPoint(context, point1X,point1Y);
			CGContextAddLineToPoint(context, point2X, point2Y);
			CGContextAddLineToPoint(context, point3X, point3Y);
			CGContextClosePath(context);
			[fillColor setFill];
			[strokeColor setStroke];
			CGContextDrawPath(context, kCGPathFillStroke);
			
			break;
		}
		case NPChartPointTypeSquare:
		{
			float length = sqrt(pow(diameter, 2)/2);
			CGRect rect = CGRectMake(x - length/2, y - length/2, length, length);
			[fillColor setFill];
			[strokeColor setStroke];
			CGContextAddRect(context,rect);
			CGContextDrawPath(context, kCGPathFillStroke);
			break;
		}

		default:
			break;
	}
	
}

@end