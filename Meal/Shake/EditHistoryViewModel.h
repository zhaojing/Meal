//
//  EditHistoryViewModel.h
//  Meal
//
//  Created by Wei Fan on 8/7/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryItem.h"

@interface EditHistoryViewModel : NSObject

@property (assign, nonatomic)NSString *itemId;
@property (strong, nonatomic)NSString *date;
@property (assign, nonatomic)NSInteger year;
@property (assign, nonatomic)NSInteger month;

- (instancetype)initWithHistory: (HistoryItem *)historyItem;
- (void)saveTheImage: (UIImage *)image
            andMenuId: (NSString *)menuId
              andName: (NSString *)name
          andLocation: (NSString *)location
              andDate: (NSString *)date
              andYear: (NSInteger)year
             andMonth: (NSInteger)month
             andPrice: (NSString *)price
           andSuccess: (void(^)(NSString *successInfo))success
             andError: (void(^)(NSString* errorInfo))error;

@end
