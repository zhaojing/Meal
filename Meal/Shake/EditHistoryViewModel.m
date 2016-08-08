//
//  EditHistoryViewModel.m
//  Meal
//
//  Created by Wei Fan on 8/7/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "EditHistoryViewModel.h"
#import "HistoryRequest.h"

@interface EditHistoryViewModel ()

@property (strong, nonatomic)HistoryItem *historyItem;

@end

@implementation EditHistoryViewModel

- (instancetype)initWithHistory:(HistoryItem *)historyItem {
    self = [super init];
    if(self) {
        self.historyItem = historyItem;
        self.date = historyItem.date;
        self.year = historyItem.year;
        self.month = historyItem.month;
    }
    return self;
}

- (void)saveTheImage:(UIImage *)image
           andMenuId:(NSString *)menuId
             andName:(NSString *)name
         andLocation:(NSString *)location
             andDate:(NSString *)date
             andYear:(NSInteger)year
            andMonth:(NSInteger)month
            andPrice:(NSString *)price
          andSuccess:(void (^)(NSString *))success
            andError:(void (^)(NSString *))error {
    [[[HistoryRequest alloc]init] addHistoryItem:[[HistoryItem alloc] initWithId:[self getRandom] andMenuID:menuId andName:name andprice:price andLocation:location andDate:date andYear:year andMonth:month andImage:image]]? success(@"添加成功") : error(@"添加失败") ;
}

- (NSString *)getRandom {
    NSString *interval = [NSString stringWithFormat: @"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    return [NSString stringWithFormat: @"%1.0f", [interval doubleValue]*100 + arc4random() % 100];
}

- (BOOL)checkStringIsNumber: (NSString *)string {
    NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: expression
                                                                           options: NSRegularExpressionCaseInsensitive
                                                                             error: nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString: string
                                                        options: 0
                                                          range: NSMakeRange(0, [string length])];
    return numberOfMatches == 0 ? false : true;
}

@end
