//
//  NPChartTick.m
//  SalesPad
//
//  Created by Liu Leon on 11-5-30.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import "NPChartTick.h"


@implementation NPChartTick

@synthesize type;
@synthesize x;
@synthesize y;
@synthesize highlighted;
@synthesize text;
@synthesize textColor;
@synthesize lineColor;

- (id)init
{
	if ((self = [super init]))
	{
		type = NPChartTickTypeX;
		x = 0.f;
		y = 0.f;
		highlighted = NO;
		text = @"";
		textColor = [UIColor blackColor];
		lineColor = [UIColor blackColor];
	}
	
	return self;
}

- (void)dealloc
{
	[text release];
	[textColor release];
	[lineColor release];
	[super dealloc];
}

- (void)drawTick:(CGContextRef)context
{
	NSLog(@"drawTick: x = %f, y = %f, type = %d", x, y, type);
	
	if (type == NPChartTickTypeX)
	{
		[textColor set];
		CGPoint textPos = CGPointMake(x - 15, y + 5);
		[text drawAtPoint:textPos withFont:[UIFont systemFontOfSize:12]];
		
		if (highlighted) 
		{
			CGContextBeginPath(context);
			CGContextSetLineWidth(context, 2);
			CGContextMoveToPoint(context, x, y + 5);
			CGContextAddLineToPoint(context, x, y - 5);
			CGContextClosePath(context);
			[lineColor setStroke];
			CGContextStrokePath(context);
			
		}
		else 
		{
			CGContextBeginPath(context);
			CGContextSetLineWidth(context, 2);
			CGContextMoveToPoint(context, x, y + 1);
			CGContextAddLineToPoint(context, x, y - 5);
			CGContextClosePath(context);
			[lineColor setStroke];
			CGContextStrokePath(context);
		}
	}
	else if (type == NPChartTickTypeY)
	{
		[textColor set];
		CGPoint textPos = CGPointMake(x - 15, y);
		[text drawAtPoint:textPos withFont:[UIFont systemFontOfSize:12]];
		
		if (highlighted) 
		{			
			CGContextBeginPath(context);
			CGContextSetLineWidth(context, 2);
			CGContextMoveToPoint(context, x - 5, y);
			CGContextAddLineToPoint(context, x + 5, y);
			CGContextClosePath(context);
			[lineColor setStroke];
			CGContextStrokePath(context);
			
		}
		else 
		{
			CGContextBeginPath(context);
			CGContextSetLineWidth(context, 2);
			CGContextMoveToPoint(context, x - 1, y);
			CGContextAddLineToPoint(context, x + 5, y);
			CGContextClosePath(context);
			[lineColor setStroke];
			CGContextStrokePath(context);
		}
	}
}

@end
