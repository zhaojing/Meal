//
//  HistoryItem.m
//  Meal
//
//  Created by Wei Fan on 8/7/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "HistoryItem.h"

@implementation HistoryItem

- (instancetype)initWithId:(NSString *)itemId
                 andMenuID:(NSString *)menuId
                   andName:(NSString *)name
                  andprice:(NSString *)price
               andLocation:(NSString *)location
                   andDate:(NSDate *)date
                  andImage:(UIImage *)image {
    self = [super init];
    if (self) {
        self.itemId = itemId;
        self.menuId = menuId;
        self.name = name;
        self.price = price;
        self.location = location;
        self.date = date;
        self.image = image;
    }
    return self;
}

@end
