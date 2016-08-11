//
//  ShakeViewModel.m
//  Meal
//
//  Created by Wei Fan on 8/8/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "ShakeViewModel.h"
#import "HistoryItem.h"
#import "HistoryRequest.h"
#import "Menu.h"
#import "NSString+Meal.h"

static const int LIMITCOUNT = 3;
static const int LIMITTIME = 3600;

@interface ShakeViewModel ()

@property (strong, nonatomic)HistoryItem *historyItem;
@property (strong, nonatomic)NSDate *date;

@end

@implementation ShakeViewModel

- (instancetype)initWithHistory:(HistoryItem *)historyItem {
    self = [super init];
    if(self) {
        self.historyItem = historyItem;
        self.date = historyItem.date;
    }
    return self;
}

- (void)saveHistory:(Menu *)menu
            andDate:(NSDate *)date
         andSuccess:(void (^)(NSString *))success
           andError:(void (^)(NSString *))error {
    [[[HistoryRequest alloc]init] addHistoryItem:[[HistoryItem alloc] initWithId:[NSString getRandom] andMenuID:menu.menuId andName:menu.name andprice:menu.price andLocation:menu.location andDate:date andImage:menu.image]]? success(@"添加成功") : error(@"添加失败") ;
}

- (Menu *)getRandomMenu:(NSArray <Menu *> *)allMenus {
    return allMenus[arc4random() % [allMenus count]];
}

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
    NSMutableArray *currentShakeArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Shakelist"] ? [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Shakelist"]]: [[NSMutableArray alloc]init];
    if ([currentShakeArray count] == LIMITCOUNT) {
        [currentShakeArray removeObjectAtIndex:0];
    }
    if ([date isEqual:[[currentShakeArray lastObject] valueForKey:@"date"]]) {
        [currentShakeArray removeLastObject];
    }
    [currentShakeArray addObject:@{@"date":date, @"save": [NSNumber numberWithBool:save]}];
    [[NSUserDefaults standardUserDefaults] setObject:currentShakeArray forKey:@"Shakelist"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
