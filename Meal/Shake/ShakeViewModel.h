//
//  ShakeViewModel.h
//  Meal
//
//  Created by Wei Fan on 8/8/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryItem.h"

@interface ShakeViewModel : NSObject

- (void)confirmIfCanShake:(void(^)())succes andError:(void(^)(NSString *string))error;
- (void)saveDate:(NSDate *)date andSave:(BOOL)save;
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
