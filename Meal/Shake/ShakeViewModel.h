//
//  ShakeViewModel.h
//  Meal
//
//  Created by Wei Fan on 8/8/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryItem.h"
#import "Menu.h"

@interface ShakeViewModel : NSObject

- (void)confirmIfCanShake: (void(^)())succes andError: (void(^)(NSString *string))error;
- (void)saveDate: (NSDate *)date andSave:(BOOL)save;
- (Menu *)getRandomMenu: (NSArray *)allMenus;
- (instancetype)initWithHistory: (HistoryItem *)historyItem;
- (void)saveHistory: (Menu *)menu
            andDate: (NSDate *)date
         andSuccess: (void(^)(NSString *successInfo))success
           andError: (void(^)(NSString* errorInfo))error;

@end
