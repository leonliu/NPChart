//
//  NPChartTick.h
//  SalesPad
//
//  Created by Liu Leon on 11-5-30.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
	NPChartTickTypeX = 1,
	NPChartTickTypeY = 1 << 1
} NPChartTickType;

@interface NPChartTick : NSObject 
{
	NPChartTickType   type;
	float      x;
	float      y;	
	BOOL       highlighted; // if highlighted, the tick has a long line drawed
	NSString   *text;       // text for the tick
	
	UIColor    *textColor;
	UIColor    *lineColor;
}

@property (nonatomic, assign) NPChartTickType type;
@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIColor *lineColor;

- (void)drawTick:(CGContextRef)context;

@end
