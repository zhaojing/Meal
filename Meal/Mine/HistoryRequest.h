//
//  HistoryRequest.h
//  Meal
//
//  Created by Wei Fan on 8/7/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryItem.h"

@interface HistoryRequest : NSObject

- (BOOL)addHistoryItem:(HistoryItem *)historyitem;
- (BOOL)deleteHistoryItem:(NSString *)itemId;
- (NSArray<HistoryItem *> *)getAllHistoryItems;
- (BOOL)modifyHistoryItem:(HistoryItem *)historyitem;

@end
