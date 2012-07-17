//
//  NPColumnChart.h
//  
//  In column chart, x axis is category, y axis is value.
//  The data is represented with columns vertically.
//  There are three types of column chart:
//    - cluster: each type of data value takes a column;
//    - stack: all data value for a category take a column. 
//      Every section of the column represent a type of data value;
//    - precent stack: all data value for a category take a column.
//      Every section of the column represent the percentage of a type of data value.
//
//  Created by Liu Leon on 11-6-10.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPChart.h"

typedef enum
{
	NPColumnChartTypeCluster = 1,
	NPColumnChartTypeStack = 1 << 1,
	NPColumnChartTypePercentStack = 1 << 2
} NPColumnChartType;

@interface NPColumnChart : NPChart 
{
	NPColumnChartType   _type;
	NPChartAxis         *_axis_X;
	NPChartAxis         *_axis_Y;
	NSMutableArray      *_columnColors;
}

@property (nonatomic, assign) NPColumnChartType type;

- (float)getYAxisPosition:(float)value;
- (float)getXAxisPosition:(float)value;

@end
