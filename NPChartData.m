//
//  NPChartData.m
//  SalesPad
//
//  Created by Liu Leon on 11-6-2.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import "NPChartData.h"


@implementation NPChartData

@synthesize rows = _rows;
@synthesize columns = _columns;

- (id)initWithRows:(NSUInteger)numRows andColumns:(NSUInteger)numCols
{
	if ((numRows == 0) || (numCols == 0)) 
	{
		return nil;
	}
	
	if ((self = [super init]))
	{
		_rows = numRows;
		_columns = numCols;
		
		_data = [[NSMutableArray alloc] initWithCapacity:_columns];
		
		for (int i = 0; i < _columns; i++) 
		{
			// every column has first two elements as title and data type
			NSMutableArray *columnData = [NSMutableArray arrayWithCapacity:(_rows + 1)];
			[_data addObject:columnData];
		}
	}
	
	return self;
}

- (void)addData:(id)value column:(NSUInteger)column
{
	NSAssert(column < _columns, @"input column exceeds maximum column");
	
	NSMutableArray *colArray = (NSMutableArray *)[_data objectAtIndex:column];
	
	NSAssert([colArray count] >= 1, @"title of column has not been set");
	
	[colArray addObject:value];
}

// get the data at column, title excluded
- (NSArray *)dataAtColumn:(NSUInteger)column
{
	NSAssert(column < _columns, @"input column exceeds maximum column");
	
	NSArray *colArray = (NSMutableArray *)[_data objectAtIndex:column];
	return [colArray subarrayWithRange:NSMakeRange(1, [colArray count] - 1)];
}

// get the data at row, the first column (category) excluded
- (NSArray *)dataAtRow:(NSUInteger)row
{
	NSAssert(row < (_rows + 1), @"input row exceeds maximum row");
	NSMutableArray *rowData = [[NSMutableArray alloc] init];
	
	for (int i = 1; i < _columns; i++)
	{
		NSMutableArray *colArray = (NSMutableArray *)[_data objectAtIndex:i];
		NSNumber *aValue = (NSNumber *)[colArray objectAtIndex:(row + 1)];
		[rowData addObject:aValue];
	}
	
	return [rowData autorelease];
}

// sum of data of column, title (the first element) excluded
- (float)sumOfColumn:(NSUInteger)column
{
	NSAssert(column < _columns, @"input column exceeds maximum column");
	
	NSArray *colArray = (NSMutableArray *)[_data objectAtIndex:column];
	NSUInteger count = [colArray count];
	float sum = 0.f;
	
	for (int i = 1; i < count; i++) 
	{
		sum += [(NSNumber *)[colArray objectAtIndex:i] floatValue];
	}
	
	return sum;
}

// sum of data of row, the first column (category) excluded
- (float)sumOfRow:(NSUInteger)row
{
	NSAssert(row < (_rows + 1), @"input row exceeds maximum row");
	float sum = 0.f;
	
	for (int i = 1; i < _columns; i++)
	{
		NSMutableArray *colArray = (NSMutableArray *)[_data objectAtIndex:i];
		sum += [(NSNumber *)[colArray objectAtIndex:(row + 1)] floatValue];
	}
	
	return sum;
}

- (float)sum
{
	float sum = 0.f;
	
	for (int i = 1; i < _columns; i++)
	{
		sum += [self sumOfColumn:i];
	}
	
	return sum;
}

- (void)setTitle:(NSString *)title forColumn:(NSUInteger)column
{
	NSAssert(column < _columns, @"input column exceeds maximum column");
	
	NSMutableArray *colArray = (NSMutableArray *)[_data objectAtIndex:column];
	
	NSAssert([colArray count] == 0, @"title has been set");
	
	[colArray addObject:title];
}

- (NSString *)titleOfColumn:(NSUInteger)column
{
	NSAssert(column < _columns, @"input column exceeds maximum column");
	NSMutableArray *colArray = (NSMutableArray *)[_data objectAtIndex:column];
	
	NSAssert([colArray count] > 0, @"column is empty");
	return (NSString *)[colArray objectAtIndex:0];
}

- (float)maxValueOfColumn:(NSUInteger)column
{
	NSAssert(column < _columns, @"input column exceeds maximum column");
	
	NSMutableArray *colArray = (NSMutableArray *)[_data objectAtIndex:column];
	NSUInteger rowCount = [colArray count];
	
	if (rowCount <= 1)
	{
		NSLog(@"column %i is empty", column);
		return 0.f;
	}
	
	id maxValue = [colArray objectAtIndex:1];
	
	for (int i = 1; i < rowCount; i++) 
	{
		NSNumber *aValue = (NSNumber *)[colArray objectAtIndex:i];
		if ([(NSNumber *)maxValue compare:aValue] == NSOrderedAscending) 
		{
			maxValue = aValue;
		}
	}
	
	return [maxValue floatValue];
}

- (float)minValueOfColumn:(NSUInteger)column
{
	NSAssert(column < _columns, @"input column exceeds maximum column");
	
	NSMutableArray *colArray = (NSMutableArray *)[_data objectAtIndex:column];
	NSUInteger rowCount = [colArray count];
	
	if (rowCount <= 1)
	{
		NSLog(@"column %i is empty", column);
		return 0.f;
	}
	
	id minValue = [colArray objectAtIndex:1];
		
	for (int i = 1; i < rowCount; i++) 
	{
		NSNumber *aValue = (NSNumber *)[colArray objectAtIndex:i];
		if ([minValue floatValue] > [aValue floatValue]) 
		{
			minValue = aValue;
		}
	}
	
	return [minValue floatValue];
}

- (float)maxDataValue
{
	if (_columns <= 1) 
	{
		return 0.f;
	}
	
	float max = 0.f;
	for (int i = 1; i < _columns; i++) 
	{
		float colMax = [self maxValueOfColumn:i];
		if (colMax > max)
		{
			max = colMax;
		}
	}
	
	return max;
}

- (float)minDataValue
{
	if (_columns <= 1) 
	{
		return 0.f;
	}
	
	float min = [self minValueOfColumn:1];
	
	for (int i = 1; i < _columns; i++) 
	{
		float colMin = [self minValueOfColumn:i];
		if (colMin < min)
		{
			min = colMin;
		}
	}
	
	return min;
}

- (NSUInteger)count
{
	NSUInteger ret = 0;
	for (int i = 1; i < _columns; i++)
	{
		NSMutableArray *colArray = (NSMutableArray *)[_data objectAtIndex:i];
		ret = ret + [colArray count] - 1;
	}
	
	return ret;
}

- (void)dealloc
{
	[_data release];
	[super dealloc];
}

@end
