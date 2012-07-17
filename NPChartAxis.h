//
//  NPChartAxis.h
//  SalesPad
//
//  Created by Liu Leon on 11-5-30.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define XAXIS_OFFSET 50
#define YAXIS_OFFSET 50

#define DEFAULT_X_TICKS 50
#define DEFAULT_Y_TICKS 30

#define PIXELS_PER_TICK 20

typedef enum
{
	NPChartAxisTypeX = 1,
	NPChartAxisTypeY = 1 << 1
} NPChartAxisType;

@interface NPChartAxis : NSObject 
{
	NPChartAxisType type;
	BOOL       isCategory;  // if the axis is category
	
	CGPoint    startPoint;  // X axis start point shall be same as Y axis start point
	float      length;
	
	NSUInteger numOfTicks;
	
	UIColor    *titleColor;
	UIColor    *lineColor;
	int        lineWidth;
	
	NSString   *title;
	NSMutableArray *ticks;
	
	float      unitsPerTick;    // data units per tick
	float      minValue;    // minimal value on the graph
	float      maxValue;    // maximal value on the graph
}

@property (nonatomic, assign) NPChartAxisType type;
@property (nonatomic, readonly) BOOL isCategory;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) float length;
@property (nonatomic, assign) NSUInteger numOfTicks;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, retain) UIColor *lineColor;
@property (nonatomic, assign) int lineWidth;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSMutableArray *ticks;
@property (nonatomic, readonly) float unitsPerTick;
@property (nonatomic, readonly) float minValue;
@property (nonatomic, readonly) float maxValue;

// Can be used for both Y axis and X axis init. By default Y axis.
- (id)initWithData:(float)min max:(float)max count:(int)count;

// Used for X axis init. X axis are labeled by default.
- (id)initWithLabels:(NSArray *)labels;

- (void)drawAxis:(CGContextRef)context;

@end
