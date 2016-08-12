//
//  HistoryListViewModel.h
//  Meal
//
//  Created by Wei Fan on 8/7/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryItem.h"

@interface HistoryListViewModel : NSObject

- (void)configureHistoryItems:(NSArray<HistoryItem *> *)historyItem;
- (NSUInteger )tableViewCount;
- (NSString *)getNameWithIndex: (NSIndexPath *)index;
- (NSString *)getPriceWithIndex:(NSIndexPath *)index;
- (NSString *)getLocationWithIndex:(NSIndexPath *)index;
- (NSString *)getDateWithIndex:(NSIndexPath *)index;
- (UIImage *)getImageWithIndex:(NSIndexPath *)index;
- (NSString *)getItemIdWithIndex:(NSIndexPath *)index;

@end
