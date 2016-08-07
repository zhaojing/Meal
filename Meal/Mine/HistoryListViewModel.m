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

- (HistoryListCellViewModel *)getCellViewModel: (NSIndexPath *)index {
    return  [[HistoryListCellViewModel alloc]initWithHistory: [self.historyItem objectAtIndex: index.row]];
}

- (NSUInteger )tableViewCount {
    return [self.historyItem count];
}

@end
