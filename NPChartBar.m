//
//  NPChartBar.m
//  SalesPad
//
//  Created by Liu Leon on 11-5-24.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import "NPChartBar.h"

@implementation NPChartBar

@synthesize text;
@synthesize fillColor;
@synthesize x;
@synthesize y;
@synthesize width;
@synthesize height;
@synthesize orientation;

- (id)init
{
	if (self = [super init])
	{
		text = @"";
		fillColor = nil;
		orientation = NPChartBarHorizontal;
	}
	return self;
}

- (void)dealloc
{
	self.text = nil;
	self.fillColor = nil;
	[super dealloc];
}

- (void)drawBar:(CGContextRef)context
{
	if (orientation == NPChartBarHorizontal)
	{
		// Draw a bar
		CGRect rect = CGRectMake(x, y - height/2, width, height);
		[fillColor setFill];
		CGContextAddRect(context, rect);
		CGContextDrawPath(context, kCGPathFill);
		
		[[UIColor blackColor] set];
		[text drawAtPoint:CGPointMake(x, y - height/2 - 15) withFont:[UIFont boldSystemFontOfSize:10]];
	}
	else 
	{
		// Draw a column
		CGRect rect = CGRectMake(x - width/2, y - height, width, height);
		[fillColor setFill];
		CGContextAddRect(context, rect);
		CGContextDrawPath(context, kCGPathFill);
		
		[[UIColor blackColor] set];
		[text drawAtPoint:CGPointMake(x - width/2, y - height - 15) withFont:[UIFont boldSystemFontOfSize:10]];
	}
}

@end