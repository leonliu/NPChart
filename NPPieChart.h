//
//  NPPieChart.h
//  SalesPad
//
//  Created by Liu Leon on 11-6-10.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPChart.h"

@interface NPPieChart : NPChart 
{
	NSMutableArray *_itemColors;
	UIColor        *_textColor;
}

@end
