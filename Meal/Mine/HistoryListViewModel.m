//
//  HistoryListViewModel.m
//  Meal
//
//  Created by Wei Fan on 8/7/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "HistoryListViewModel.h"
#import "HistoryItem.h"

@interface HistoryListViewModel ()

@property (strong, nonatomic)NSMutableArray<HistoryItem *> *historyItem;

@end

@implementation HistoryListViewModel

- (void)configureHistoryItems: (NSArray<HistoryItem *> *)historyItem {
    self.historyItem = [NSMutableArray arrayWithArray: historyItem];
}

- (NSUInteger )tableViewCount {
    return [self.historyItem count];
}

- (NSString *)getNameWithIndex:(NSIndexPath *)index {
    return [self.historyItem objectAtIndex: index.row].name;
}

- (NSString *)getPriceWithIndex:(NSIndexPath *)index {
    return [NSString stringWithFormat:@"￥%@", [self.historyItem objectAtIndex: index.row].price];
}

- (NSString *)getLocationWithIndex:(NSIndexPath *)index {
    return [self.historyItem objectAtIndex: index.row].location;
}

- (NSString *)getDateWithIndex:(NSIndexPath *)index {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    return [formatter stringFromDate: [self.historyItem objectAtIndex: index.row].date];
}

- (UIImage *)getImageWithIndex:(NSIndexPath *)index {
    return [self.historyItem objectAtIndex: index.row].image;
}

- (NSString *)getItemIdWithIndex:(NSIndexPath *)index {
    return [self.historyItem objectAtIndex: index.row].itemId;
}

@end
