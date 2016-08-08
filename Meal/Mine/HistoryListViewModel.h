//
//  HistoryListViewModel.h
//  Meal
//
//  Created by Wei Fan on 8/7/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryListCellViewModel.h"
#import "HistoryItem.h"

@interface HistoryListViewModel : NSObject

-(void)configureHistoryItems:(NSArray<HistoryItem *> *)historyItem;
-(HistoryListCellViewModel *)getCellViewModel:(NSIndexPath *)index;
-(NSUInteger )tableViewCount;

@end
