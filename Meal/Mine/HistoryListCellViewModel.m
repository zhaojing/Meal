//
//  HistoryListCellViewModel.m
//  Meal
//
//  Created by Wei Fan on 8/7/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "HistoryListCellViewModel.h"

@interface HistoryListCellViewModel ()

@property (strong, nonatomic)HistoryItem *historyItem;

@end

@implementation HistoryListCellViewModel

-(instancetype)initWithHistory:(HistoryItem *)historyItem {
    self = [super init];
    if (self) {
        self.historyItem = historyItem;
    }
    return self;
}

-(NSString *)getName {
    return self.historyItem.name;
}

-(NSString *)getPrice {
    return [NSString stringWithFormat:@"￥%@", self.historyItem.price];
}

-(NSString *)getLocation {
    return self.historyItem.location;
}

-(NSString *)getDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    return [formatter stringFromDate:self.historyItem.date];
}

-(UIImage *)getImage {
    return self.historyItem.image;
}

- (NSString *)getItemId {
    return self.historyItem.itemId;
}

@end
