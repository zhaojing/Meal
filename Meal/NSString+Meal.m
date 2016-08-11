//
//  NSString+Meal.m
//  Meal
//
//  Created by Lvju Wang on 8/11/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "NSString+Meal.h"

@implementation NSString (Meal)

+ (NSString *)getRandom {
    NSString *interval = [NSString stringWithFormat: @"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    return [NSString stringWithFormat: @"%1.0f", [interval doubleValue]*100 + arc4random() % 100];
}

- (BOOL)checkStringIsNumber {
    NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: expression
                                                                           options: NSRegularExpressionCaseInsensitive
                                                                             error: nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString: self
                                                        options: 0
                                                          range: NSMakeRange(0, [self length])];
    return numberOfMatches == 0 ? false : true;
}

@end
