//
//  HistoryListCellViewModel.h
//  Meal
//
//  Created by Wei Fan on 8/7/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "HistoryItem.h"

@interface HistoryListCellViewModel : NSObject

- (instancetype)initWithHistory:(HistoryItem *)historyItem;

- (NSString *)getName;
- (NSString *)getPrice;
- (NSString *)getLocation;
- (NSString *)getDate;
- (UIImage *)getImage;
- (NSString *)getItemId;

@end
