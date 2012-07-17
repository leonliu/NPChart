//
//  NPChartData.h
//  SalesPad
//
//  Created by Liu Leon on 11-6-2.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPChartData : NSObject 
{	
	// data table which stores the raw data  
	// example:
	// year              sales              expenses
	// 2004              10000              4000
	// 2005              14000              6000
	// 2006              16000              7000
	//
	// Note that:
	// - The first column is used to display on X axis. Values
	//   must always be NSString type.
	// - Rest columns must have same data type, float.
	
	NSUInteger _rows;
	NSUInteger _columns;
	NSMutableArray *_data;
}

@property (nonatomic, readonly) NSUInteger rows;
@property (nonatomic, readonly) NSUInteger columns;

- (id)initWithRows:(NSUInteger)numRows andColumns:(NSUInteger)numCols;

- (void)addData:(id)value column:(NSUInteger)column;

- (NSArray *)dataAtColumn:(NSUInteger)column;
- (NSArray *)dataAtRow:(NSUInteger)row;
- (float)sumOfColumn:(NSUInteger)column;
- (float)sumOfRow:(NSUInteger)row;
- (float)sum;

- (void)setTitle:(NSString *)title forColumn:(NSUInteger)column;
- (NSString *)titleOfColumn:(NSUInteger)column;

- (float)maxValueOfColumn:(NSUInteger)column;
- (float)minValueOfColumn:(NSUInteger)column;
- (float)maxDataValue;
- (float)minDataValue;

- (NSUInteger)count;

@end
