//
//  NPChartAxis.m
//  SalesPad
//
//  Created by Liu Leon on 11-5-30.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import "NPChartAxis.h"
#import "NPChartTick.h"
#import "NPCommon.h"

@interface NPChartAxis()

- (float)niceNumber:(float)input round:(BOOL)round;
- (void)labelTicks:(float)min max:(float)max;
- (void)labelTicks:(NSArray *)labels;
- (void)layoutTicks;

@end


@implementation NPChartAxis

@synthesize type;
@synthesize isCategory;
@synthesize startPoint;
@synthesize length;
@synthesize numOfTicks;

@synthesize titleColor;
@synthesize lineColor;
@synthesize lineWidth;

@synthesize title;
@synthesize ticks;

@synthesize unitsPerTick;
@synthesize minValue;
@synthesize maxValue;

#pragma mark -
#pragma mark private methods
#
// Find a "nice" number approximately equal to x.
// Round the number if round = YES, take ceiling if round = NO
- (float)niceNumber:(float)x round:(BOOL)round
{
	float exponent;    // exponent of x
	float fraction;    // fraction part of x
	float niceFraction;  // nice, rounded fraction
	
	exponent = floorf(log10f(x));
	fraction = x/powf(10.f, exponent);  // between 1 and 10
	
	if (round)
	{
		if (fraction < 1.5) niceFraction = 1.f;
		else if (fraction < 3.f) niceFraction = 2.f;
		else if (fraction < 7.f) niceFraction = 5.f;
		else niceFraction = 10.f;
	}
	else 
	{
		if (fraction <= 1.f) niceFraction = 1.f;
		else if (fraction <= 2.f) niceFraction = 2.f;
		else if (fraction <= 5.f) niceFraction = 5.f;
		else niceFraction = 10.f;
	}
	
	return (niceFraction * powf(10.f, exponent));
}

- (void)labelTicks:(float)min max:(float)max
{
	float range = [self niceNumber:(max - min) round:NO];
	unitsPerTick = [self niceNumber:(range/(numOfTicks - 1)) round:YES];
	minValue = floorf(min/unitsPerTick) * unitsPerTick;
	maxValue = ceilf(max/unitsPerTick) * unitsPerTick;
	
	float limit = maxValue + 0.5 * unitsPerTick;
	int i = 0;
	
	for (float value = minValue; value < limit; value += unitsPerTick)
	{
		NPChartTick *tick = [[NPChartTick alloc] init];
		tick.type = NPChartTickTypeY;
		
		if (i % 5 == 0)
		{
			tick.highlighted = YES;
		}
		
		tick.text = [NSString stringWithFormat:@"%.2f", value];
		[ticks addObject:tick];
		[tick release];
		
		i++;
	}
	
	// update the tick number
	numOfTicks = i;
}

- (void)labelTicks:(NSArray *)labels
{	
	for (int i = 0; i < numOfTicks; i++) 
	{
		NPChartTick *tick = [[NPChartTick alloc] init];
		tick.type = NPChartTickTypeX;
		
		if (i % 5 == 0)
		{
			tick.highlighted = YES;
		}
		
		tick.text = (NSString *)[labels objectAtIndex:i];
		[ticks addObject:tick];
		[tick release];
	}
}

- (void)layoutTicks
{	
	float interval;
	
	if (isCategory)
	{
		interval = length / numOfTicks;
	}
	else 
	{
		interval = length / (numOfTicks - 1);
	}

	if (type == NPChartAxisTypeY)
	{
		for (int i = 0; i < numOfTicks; i++) 
		{
			NPChartTick *tick = [ticks objectAtIndex:i];
			tick.x = startPoint.x;
			
			if (isCategory) 
			{
				tick.y = startPoint.y - (i + 1) * interval;
			}
			else
			{
				tick.y = startPoint.y - i * interval;
			}
		}
	}
	else 
	{
		for (int i = 0; i < numOfTicks; i++) 
		{
			NPChartTick *tick = [ticks objectAtIndex:i];
			if (isCategory) 
			{
				tick.x = startPoint.x + (i + 1) * interval;
			}
			else 
			{
				tick.x = startPoint.x + i * interval;
			}

			tick.y = startPoint.y;
		}
	}

	
}


#pragma mark -
#pragma mark public methods
#
- (id)initWithData:(float)min max:(float)max count:(int)count
{
	if ((self = [super init])) 
	{
		title = @"";
		type = NPChartAxisTypeY;
		isCategory = NO;
		
		if (count <= DEFAULT_Y_TICKS)
		{
			numOfTicks = count;
		}
		else 
		{
			numOfTicks = DEFAULT_Y_TICKS;
		}

		lineColor = [UIColor blackColor];
		titleColor = [UIColor blackColor];
		lineWidth = 2;
		ticks = [[NSMutableArray alloc] initWithCapacity:numOfTicks];
		
		[self labelTicks:min max:max];
	}
	return self;
}

- (id)initWithLabels:(NSArray *)labels
{
	if ((self = [super init])) 
	{
		title = @"";
		isCategory = YES;
		
		type = NPChartAxisTypeX;
		numOfTicks = [labels count];
		lineColor = [UIColor blackColor];
		titleColor = [UIColor blackColor];
		lineWidth = 2;
		
		ticks = [[NSMutableArray alloc] initWithCapacity:numOfTicks];
	    
		[self labelTicks:labels];
	}
	return self;
}

- (void)dealloc
{
	[title release];
	[ticks release];
	[super dealloc];
}

- (void)drawAxis:(CGContextRef)context
{
	if (type == NPChartAxisTypeX)
	{
		// Draw title	
		[titleColor set];
		CGSize strSize = [title sizeWithFont:[UIFont systemFontOfSize:13]];
		CGPoint titlePos = CGPointMake(startPoint.x + (length - strSize.width)/2, startPoint.y + 20);
		[title drawAtPoint:titlePos withFont:[UIFont systemFontOfSize:13]];
		
		// Draw axis line
		CGPoint endpoint = CGPointMake(startPoint.x + length, startPoint.y);
		
		CGContextBeginPath(context);
		CGContextSetLineWidth(context, lineWidth);
		CGContextMoveToPoint(context, startPoint.x, startPoint.y);
		CGContextAddLineToPoint(context, endpoint.x, endpoint.y);
		CGContextClosePath(context);
		[lineColor setStroke];
		CGContextStrokePath(context);
		
		// Draw ticks
		[self layoutTicks];
		
		for (NPChartTick *tick in ticks)
		{
			[tick drawTick:context];
		}
	}
	else if (type == NPChartAxisTypeY)
	{
		// Draw title	
		[titleColor set];
		CGSize strSize = [title sizeWithFont:[UIFont systemFontOfSize:13]];
		CGPoint titlePos = CGPointMake(0.f, 0.f);
		CGContextSaveGState(context);
		CGContextTranslateCTM(context, startPoint.x - 35, startPoint.y - length/2 + strSize.width/2);
		CGContextRotateCTM(context, radians(-90.));
		[title drawAtPoint:titlePos withFont:[UIFont systemFontOfSize:13]];
		CGContextRestoreGState(context);
		
		// Draw axis line
		CGPoint endpoint = CGPointMake(startPoint.x, startPoint.y - length);
		
		CGContextBeginPath(context);
		CGContextSetLineWidth(context, lineWidth);
		CGContextMoveToPoint(context, startPoint.x, startPoint.y);
		CGContextAddLineToPoint(context, endpoint.x, endpoint.y);
		CGContextClosePath(context);
		[lineColor setStroke];
		CGContextStrokePath(context);
		
		// Draw ticks
		[self layoutTicks];
		
		for (NPChartTick *tick in ticks)
		{
			[tick drawTick:context];
		}
	}
}


@end
