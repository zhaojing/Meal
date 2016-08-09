//
//  ShakeViewModel.m
//  Meal
//
//  Created by Wei Fan on 8/8/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "ShakeViewModel.h"

static const int LIMITCOUNT = 3;
static const int LIMITTIME = 3600;

@implementation ShakeViewModel

- (void)confirmIfCanShake:(void (^)())succes andError:(void (^)(NSString *))error {
    NSDate *date = [NSDate date];
    NSArray *currentShakeArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Shakelist"];
    if (!currentShakeArray) {
        succes();
    } else if ([[[currentShakeArray lastObject] valueForKey:@"save"]isEqual:[NSNumber numberWithBool:YES]] && [date timeIntervalSinceDate:[[currentShakeArray lastObject] valueForKey:@"date"]] < LIMITTIME ) {
        error(@"在当前一个小时之内已经选过了");
    } else if ([currentShakeArray count] == LIMITCOUNT &&[date timeIntervalSinceDate:[[currentShakeArray firstObject] valueForKey:@"date"]] < LIMITTIME) {
        error(@"在当前一个小时之内摇动超过三次");
    } else {
        succes();
    }
}

- (void)saveDate:(NSDate *)date andSave:(BOOL)save {
    NSArray *currentShakeArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Shakelist"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"Shakelist"] : @[];
    NSMutableArray * array = [NSMutableArray arrayWithArray:currentShakeArray];
    if ([array count] == LIMITCOUNT) {
        [array removeObjectAtIndex:0];
    }
    if ([date isEqual:[[array lastObject] valueForKey:@"date"]]) {
        [array removeLastObject];
    }
    [array addObject:@{@"date":date, @"save": [NSNumber numberWithBool:save]}];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"Shakelist"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
