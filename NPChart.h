//
//  NPChart.h
//  SalesPad
//
//  Created by Liu Leon on 11-5-24.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPChartData.h"

typedef enum
{
	NPChartBarHorizontal,
	NPChartBarVertical = 1<< 1
} NPChartBarOrientation;

@protocol NPChartDelegate

@end

@class NPChartAxis;

@interface NPChart : NSObject 
{
	CGContextRef		_context;
	CGRect				_frame;
	NPChartData         *_rawData;
	
	NSString			*_title; // chart title
	id<NPChartDelegate>	_delegate;
	
	UIColor				*_backgroundColor;
}


// Chart properties, set them before call the methods
@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) id<NPChartDelegate> delegate;


- (id)initWithFrame:(CGRect)frame context:(CGContextRef)context data:(NPChartData *)data;
- (void)draw;

@end

