//
//  NPCommon.m
//  iPhone SDK extend class,including string,date,file access.
//
//  Created by Liu Leon on 11-5-24.
//  Copyright 2011 NotionInMotion.com. All rights reserved.
//

#import "NPCommon.h"

@implementation NPCommon


#pragma mark NSString methods
#

+ (NSString *)sClearSpaceOfS:(NSString *)aString
{
	NSString *rString = [aString stringByReplacingOccurrencesOfString:@" " withString:@""];
	return rString;
}

+ (NSString *)sClearFrontSpaceOfS:(NSString *)aString
{
	int count_index = 0;
	while(count_index< [aString length])
	{
	
		if ([aString characterAtIndex:count_index]  != 32) {
			break;
		}
		else {
			count_index++;
		}
	}
	return [NPCommon sStartIndex:count_index EndIndex:-1 OfS:aString];
}

+ (NSString *)sClearNOfS:(NSString *)aString
{
	NSString *rString = [aString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	return rString;
}

+ (NSString *)sAddEnterOfS:(NSString *)aString
{
	NSString *rString =  [aString stringByAppendingString:@"\r\n"];
	return rString;
}



+ (NSString *)sBetweenW1:(NSString *)w1 W2:(NSString *)w2 OfS:(NSString *)aString;
{
	NSRange range1 = [aString rangeOfString:w1];
	NSRange range2 = [aString rangeOfString:w2];
	NSString *rString; 
	if(range1.location == range2.location)
	{
		range2 = [[NPCommon sReverseOfS:aString] rangeOfString:w2];
		range2.location += [aString length] -1;
	}
	if(range1.length != 0 && range2.length != 0)
	{
		int location1 = range1.location ; 
		int location2 = range2.location ; 
		NSString *substring = [aString substringWithRange:NSMakeRange(location1,location2-location1)] ; 
		
		rString = [substring stringByAppendingString:w2];
	}
	else
	{
		rString = @"nil";
	}
	return rString;
}


+ (NSString *)sFillBlankOfS:(NSString *)aString Length:(int)length;
{
	int stringLength = [aString length];
	while(stringLength < length)
	{
		aString = [aString stringByAppendingString:@" "];
		stringLength ++;
	}
	return aString;
}

+ (NSMutableArray *)saSplitMultiSpaceOfS:(NSString *)aString
{
	int count_index = 0;
	int beginWordindex = -1;
	int endWordindex = -1;
	NSMutableArray *splictWords = [NSMutableArray array];
	NSString *splictString;
	
	while(count_index< [aString length])
	{
		if([aString characterAtIndex:count_index]  == 32)
		{
			count_index ++;				
		}
		else
		{
			if (beginWordindex == -1)
			{
				beginWordindex = count_index;
				if([aString characterAtIndex:count_index + 1]  == 32 && [aString characterAtIndex:count_index + 2]  == 32 && [aString characterAtIndex:count_index + 3]  == 32)
				{
					endWordindex = count_index;
					splictString = [aString substringWithRange:NSMakeRange(beginWordindex, endWordindex - beginWordindex + 1)];
					[splictWords addObject:splictString];
					beginWordindex = -1;					
				}
				count_index ++;
			}
			else
			{
				if (count_index + 1 == [aString length])
				{
					count_index ++;
				}
				else
				{
					if([aString characterAtIndex:count_index + 1]  == 32 && [aString characterAtIndex:count_index + 2]  == 32 && [aString characterAtIndex:count_index + 3]  == 32)
					{
						endWordindex = count_index;
						splictString = [aString substringWithRange:NSMakeRange(beginWordindex, endWordindex - beginWordindex + 1)];
						[splictWords addObject:splictString];
						beginWordindex = -1;
					}
					count_index ++;
				}
			}
		}
	}
	return splictWords;
}

+ (NSString *)sReplace:(NSString *)oriString ToS:(NSString *)repString OfS:(NSString *)aString
{
	NSString *rString = [aString stringByReplacingOccurrencesOfString:oriString  withString:repString];
	return rString;
}

+ (NSString *)sStartIndex:(int)startindex EndIndex:(int)endindex OfS:(NSString *)aString
{
	NSString *rString;
	if (startindex != -1 && endindex != -1)
	{
		rString = [aString substringWithRange:NSMakeRange(startindex,endindex - startindex+1)];
	}
	else if(startindex != -1 && endindex == -1)
	{
		rString = [aString substringFromIndex:startindex];
	}
	else if(startindex == -1 && endindex != -1)
	{
		rString = [aString substringToIndex:endindex];
	}
	else
	{
		rString = @"nil";
	}
	return rString; 
}

+ (NSString *)sAddQuotationMarkOfS:(NSString *)aString
{
	NSMutableString *rString = [[NSMutableString alloc] init];
	[rString appendString:@"'"];
	[rString appendString:aString];
	[rString appendString:@"'"];
	return [rString autorelease];
}

+ (NSString *)sOfI:(int)intValue
{
	NSString *rString = [NSString stringWithFormat:@"%d",intValue];
	return rString;
}

+ (NSString *)sSplitByThousandOfS:(NSString *)aString
{
	NSMutableString *rmString = [[NSMutableString alloc] init];
	int startIndex = [aString intValue] < 0?1:0;
	int thousandCount = 0;
	for(int i = [aString length] - 1;i >= startIndex;--i)
	{
		[rmString appendFormat:@"%c",[aString characterAtIndex:i]];
		thousandCount++;
		if(thousandCount == 3&&i!=startIndex)
		{
			[rmString appendString:@","];
			thousandCount = 0;
		}
	}
	if(startIndex == 1)
		[rmString appendString:@"-"];
	NSString *rString = [self sReverseOfS:rmString];
	[rmString release];
	return rString;
}

+ (NSString *)sReverseOfS:(NSString *)aString
{
	NSMutableString *rString = [[NSMutableString alloc] init];
	for(int i = [aString length] - 1;i >= 0;--i)
	{
		[rString appendFormat:@"%c",[aString characterAtIndex:i]];
	}
	return [rString autorelease];
}

+ (NSString *)sAddSeparate:(NSString *)sepString ByStep:(NSInteger)step OfS:(NSString *)aString
{
	int length = [aString length];
	NSMutableString *rString = [[NSMutableString alloc] init];
	
	for(int i = 0; i < length; i++)
	{
		if((i+1)%step == 0&&i != 0&&i != length - 1)
		{
			[rString appendFormat:@"%c",[aString characterAtIndex:i]];
			[rString appendString:sepString];
		}
		else
		{
			[rString appendFormat:@"%c",[aString characterAtIndex:i]];
		}
	}
	return [rString autorelease];
}

+ (void)vStringCompareOfA:(NSMutableArray *)aArray
{
	for(int i=1;i<[aArray count];++i)
	{
		for(int j=0;j<[aArray count] - i;++j)
		{
			if([[aArray objectAtIndex:j] compare:[aArray objectAtIndex:j+1]] == NSOrderedDescending)
			{
				NSString *temp = [NSString stringWithString:[aArray objectAtIndex:j]];
				[aArray replaceObjectAtIndex:j withObject:[aArray objectAtIndex:j+1]];
				[aArray replaceObjectAtIndex:j+1 withObject:temp];
			}
		}
	}
}

+ (NSString *)sOfBool:(bool)aBool
{
	NSString *rString;
	if(aBool)
		rString = @"true";
	else
		rString = @"false";
	return rString;
}


#pragma mark NSDate methods
#

+ (NSDate *)dOfS:(NSString *)aString withFormat:(NSString *)format
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	//[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
	
	[formatter setDateFormat:format];
	NSDate *rDate = [formatter dateFromString:aString];
	[formatter release];
	return rDate;
}

+ (NSString *)sTimeByZoneOfS:(NSString *)aString TimeZone:(NSTimeZone *)zone
{
	NSInteger second = [zone secondsFromGMT];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT];
	[formatter setTimeZone:zone];
	NSDate *date = [formatter dateFromString:aString];
	NSDate *rDate = [date dateByAddingTimeInterval:second];
	NSString *rString = [rDate description];
	rString = [self sStartIndex:-1 EndIndex:18 OfS:rString];
	[formatter release];
	return rString;
}

+ (NSString *)sOfD:(NSDate*)aDate Withforamt:(NSString *)format
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:format];
	NSString *rString = [dateFormatter stringFromDate:aDate];
	[dateFormatter release];
	return rString;
}


+ (NSString *)sWordMiddleToAllNumberOfS:(NSString *)aString SplitS:(NSString *)splitString
{
	NSArray *datePartArray = [aString componentsSeparatedByString:splitString];
	NSString *year = [datePartArray objectAtIndex:2];
	NSString *month = [self sMonthToNumberOfS:[datePartArray objectAtIndex:1]];
	NSString *day = [datePartArray objectAtIndex:0];
	NSString *rString = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
	return rString;
}

+ (NSString *)sAllNumberToWordMiddleOfS:(NSString *)aString SplitS:(NSString *)splitString
{
	NSArray *datePartArray = [aString componentsSeparatedByString:splitString];
	NSString *year = [datePartArray objectAtIndex:0];
	NSString *month = [self sNumberToMonthOfS:[datePartArray objectAtIndex:1]];
	NSString *day = [datePartArray objectAtIndex:2];
	NSString *rString = [NSString stringWithFormat:@"%@-%@-%@",day,month,year];
	return rString;
}

+ (NSString *)sMonthToNumberOfS:(NSString *)month
{
	if ([month isEqualToString:@"Jan"])
		return @"01";
	else if([month isEqualToString:@"Feb"])
		return @"02";
	else if([month isEqualToString:@"Mar"])
		return @"03";
	else if([month isEqualToString:@"Apr"])
		return @"04";
	else if([month isEqualToString:@"May"])
		return @"05";
	else if([month isEqualToString:@"Jun"])
		return @"06";
	else if([month isEqualToString:@"Jul"])
		return @"07";
	else if([month isEqualToString:@"Aug"])
		return @"08";
	else if([month isEqualToString:@"Sep"])
		return @"09";
	else if([month isEqualToString:@"Oct"])
		return @"10";
	else if([month isEqualToString:@"Nov"])
		return @"11";
	else if([month isEqualToString:@"Dec"])
		return @"12";
	else
		return month;
}

+ (NSString *)sNumberToMonthOfS:(NSString *)number
{
	if ([number isEqualToString:@"01"])
		return @"Jan";
	else if([number isEqualToString:@"02"])
		return @"Feb";
	else if([number isEqualToString:@"03"])
		return @"Mar";
	else if([number isEqualToString:@"04"])
		return @"Apr";
	else if([number isEqualToString:@"05"])
		return @"May";
	else if([number isEqualToString:@"06"])
		return @"Jun";
	else if([number isEqualToString:@"07"])
		return @"Jul";
	else if([number isEqualToString:@"08"])
		return @"Aug";
	else if([number isEqualToString:@"09"])
		return @"Sep";
	else if([number isEqualToString:@"10"])
		return @"Oct";
	else if([number isEqualToString:@"11"])
		return @"Nov";
	else if([number isEqualToString:@"12"])
		return @"Dec";
	else
		return number;
}

+ (NSString *)stringOfCurrentDate
{
	NSDate *now = [NSDate date];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:kDEFAULT_DATE_FORMAT];
	NSString *rString = [formatter stringFromDate:now];
	[formatter release];
	return rString;	
}

+ (NSString *)stringOfCurrentTime
{
	NSDate *now = [NSDate date];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:kDEFAULT_TIME_FORMAT];
	NSString *rString = [formatter stringFromDate:now];
	[formatter release];
	return rString;
}

+ (NSString *)stringOfCurrentDateAndTime
{
	NSDate *now = [NSDate date];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT];
	
	NSString *rString = [formatter stringFromDate:now];
//	[now release];   //change
	[formatter release];
	return rString;
}

+ (NSDate *)dateByAddingYearsToDate:(NSDate *)aDate Months:(NSInteger)years
{
	return [aDate dateByAddingTimeInterval:years*365*24*60*60];
}

+ (NSDate *)dateByAddingMonthsToDate:(NSDate *)aDate Months:(NSInteger)months
{
	return [aDate dateByAddingTimeInterval:months*30*24*60*60];
}

+ (NSDate *)dateByAddingDaysToDate:(NSDate *)aDate Months:(NSInteger)days
{
	return [aDate dateByAddingTimeInterval:days*24*60*60];
}

+ (NSDate *)dRemoveTimeOfD:(NSDate *)aDate
{
	NSString *nowDateStr = [NPCommon sOfD:aDate Withforamt:kDEFAULT_DATE_TIME_FORMAT];
	nowDateStr = [NPCommon sStartIndex:-1 EndIndex:10 OfS:nowDateStr];
	nowDateStr = [NSString stringWithFormat:@"%@ 00:00:00",nowDateStr];
	NSDate *nowDate = [NPCommon dOfS:nowDateStr withFormat:kDEFAULT_DATE_TIME_FORMAT];
	return nowDate;
}

+ (int)getDaysFrom:(NSDate *)beiginDate To:(NSDate *)endDate
{
	NSDate *fromDate = [NPCommon dRemoveTimeOfD:beiginDate];
	NSDate *toDate = [NPCommon dRemoveTimeOfD:endDate];
	
	//get the remaining days
	NSCalendar *dateCalendar = [NSCalendar currentCalendar];
	
	unsigned int unitFlags = NSDayCalendarUnit;
	
	NSDateComponents *comps = [dateCalendar components:unitFlags fromDate:fromDate toDate:toDate options:0];
	
	int days = [comps day] + 1;
	return days;
}

+ (int)getHoursFrom:(NSDate *)beiginDate To:(NSDate *)endDate
{
	
	//get the remaining days
	NSCalendar *dateCalendar = [NSCalendar currentCalendar];
	
	unsigned int unitFlags = NSHourCalendarUnit;
	
	NSDateComponents *comps = [dateCalendar components:unitFlags fromDate:beiginDate toDate:endDate options:0];
	
	int hours = [comps hour] + 1;
	return hours;
}


#pragma mark UIColor methods
#

+ (UIColor *)getRandomColor
{
	CGFloat red = random()%256;
	CGFloat green = random()%256;
	CGFloat bule = random()%256;
	UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:bule/255.0 alpha:1];
	return color;
}


#pragma mark File Access methods
#

+ (BOOL)bSaveToFileSerializable:(NSString *)fileName OfObj:(id)object
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	if (!documentsDirectory) {
		return NO;
	}
	NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
	return ([data writeToFile:path atomically:YES]);
}

+ (id)objLoadFromFile:(NSString *)fileName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
	if ([[NSFileManager defaultManager] fileExistsAtPath:path])
	{
		NSData *data = [[[NSData alloc] initWithContentsOfFile:path] autorelease];
		return [NSKeyedUnarchiver unarchiveObjectWithData:data];
	}
	else
		return nil;
}

#pragma mark helper methods
#
+ (void)vBarButtonWithTitle:(NSString *)title tar:(id)tar sel:(SEL)sel right:(BOOL)right ofNav:(UINavigationItem *)nav
{
	UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
															 style:UIBarButtonItemStylePlain target:tar action:sel];
	if (right)
		nav.rightBarButtonItem = item;
	else 
		nav.leftBarButtonItem = item;
	
	[item release];
}

+ (void)vAlertWithTitle:(NSString *)title mes:(NSString *)mes del:(id)del cBtnTitle:(NSString *)cBtnTitle oBtnTitle:(NSString *)oBtnTitle tag:(NSInteger)tag
{
	if (title == nil) 
		title = kALERT_TITLE;

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:mes
												   delegate:del cancelButtonTitle:cBtnTitle otherButtonTitles:oBtnTitle,nil];
	[alert setTag:tag];
	[alert show];
	[alert release];
}

+ (void)vAddCoverViewTo:(UIView *)view refObj:(UIView *)obj
{
	UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	coverView.backgroundColor = [UIColor blackColor];
	obj = coverView;
	if (obj == nil) {
		obj = nil;
	}
	[view addSubview:coverView];
	[coverView release];
}

+ (void)vRemoveCoverViewFrom:(UIView *)view refObj:(UIView *)obj
{
	if (obj != nil) {
		[obj removeFromSuperview];
		[obj release];
		obj = nil;
	}
}

+ (NSMutableArray  *)arrDistinct:(NSMutableArray  *)arr
{
	[NPCommon vMergeSort:arr type:nil];
	int cur_number = INT_MAX;
	NSMutableArray *temp = [[NSMutableArray alloc] init]; 
	for (int i = 0; i < [arr count]; ++i) 
	{
		if (cur_number != [[arr objectAtIndex:i] intValue])
		{
			[temp addObject:[arr objectAtIndex:i]];
		}
		cur_number = [[arr objectAtIndex:i] intValue];
	}
	return [temp autorelease];
}

+ (void)vMergeSort:(NSMutableArray *)arr type:(NSString *)type
{
	[NPCommon vMerge_Sort:arr left:0 right:[arr count] - 1 type:type];
}

+ (void)vMerge_Sort:(NSMutableArray *)arr left:(int)left right:(int)right type:(NSString *)type
{
	int center = 0;
	if (left<right) {
		center = (left + right)/2;
		[NPCommon vMerge_Sort:arr left:left right:center type:type];
		[NPCommon vMerge_Sort:arr left:center+1 right:right type:type];
		[NPCommon vMerge:arr left:left center:center right:right type:type];
	}
}

+ (void)vMerge:(NSMutableArray *)arr left:(int)left center:(int)center right:(int)right type:(NSString *)type
{
	int left1 = left;
	int right1 = center;
	int left2 = center + 1;
	int right2 = right;
	
	NSMutableArray *temp = [[NSMutableArray alloc] init];
	
	while (left1<= right1 && left2 <= right2) 
	{
		if ([type isEqual:@"tag"]) 
		{
			if (((UIView *)[arr objectAtIndex:left1]).tag < ((UIView *)[arr objectAtIndex:left2]).tag) 
			{
				[temp addObject:[arr objectAtIndex:left1++]];
			}
			else
			{
				[temp addObject:[arr objectAtIndex:left2++]];
			}

		}
		else 
		{
			if ([[arr objectAtIndex:left1] intValue] < [[arr objectAtIndex:left2] intValue])
			{
				[temp addObject:[arr objectAtIndex:left1++]];
			}
			else
			{
				[temp addObject:[arr objectAtIndex:left2++]];
			}	
		}
	}
	
	while (left1 <= right1) 
	{
			[temp addObject:[arr objectAtIndex:left1++]];
	}
	
	while (left2 <= right2) 
	{
		[temp addObject:[arr objectAtIndex:left2++]];
	}
	
	for (int i = 0,k= left;k<=right;k++,i++) 
	{
		[arr replaceObjectAtIndex:k withObject:[temp objectAtIndex:i]];
	}
}

+ (int)getMAXValueFrom:(NSMutableArray *)arr
{
	int max = INT_MIN;
	for (int i = 0; i < [arr count]; ++i)
	{
		if ([[arr objectAtIndex:i] intValue] > max) {
			max = [[arr objectAtIndex:i] intValue];
		}
	}
	return max;
}

@end
