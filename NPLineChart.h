//
//  NPLineChart.h
//  SalesPad
//
//  Created by Liu Leon on 11-6-10.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPChart.h"

typedef enum
{
	NPChartPointTypeNone,
	NPChartPointTypeCircle = 1 << 1,
	NPChartPointTypeTriangle = 1 << 2,
	NPChartPointTypeSquare = 1 << 3
} NPChartPointType;


@interface NPLineChart : NPChart 
{	
	// point type
	NPChartPointType	_pointType;
	
	NPChartAxis         *_axis_X;
	NPChartAxis         *_axis_Y;
}

// Point Type, default is NPChartPointTypeCircle
@property (nonatomic, assign) NPChartPointType pointType;


@end
