//
//  HistoryItem.h
//  Meal
//
//  Created by Wei Fan on 8/7/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HistoryItem : NSObject

@property (strong, nonatomic)NSString *itemId;
@property (strong, nonatomic)NSString *menuId;
@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)NSString *location;
@property (strong, nonatomic)NSString *price;
@property (strong, nonatomic)NSDate *date;
@property (strong, nonatomic)UIImage *image;

-(instancetype)initWithId:(NSString *)itemId
                andMenuID:(NSString *)menuId
                  andName:(NSString *)name
                 andprice:(NSString *)price
              andLocation:(NSString *)location
                  andDate:(NSDate *)date
                 andImage:(UIImage *)image;

@end
