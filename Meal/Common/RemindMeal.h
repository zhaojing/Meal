//
//  RemindMeal.h
//  Meal
//
//  Created by JingZhao on 8/4/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

typedef NS_ENUM(NSInteger, RemindAddErrorResult) {
    errorAdd,
    errorAuthorize
};

@interface RemindMeal : NSObject


/** 添加日历
@param remind 提醒字典 
 -[title]: 提醒的主题            非必须
 -[alarm]: 闹铃的时间            非必须
 -[startDate]: 事件开始时间           非必须
 -[endDate]: 事件结束时间         非必须
 -[notes]: 提醒的内容            非必须
 -[repeat]: 重复参数value =（0，1，2，3）对应值为（日，周，月，年）重复         非必须
@param errorResult 返回失败事件及原因
@param success 成功事件
*/

-(void)addRemindParams:(NSDictionary *)remind
              andError:(void(^)(RemindAddErrorResult addResult, NSString *errorInfo))errorResult
            andSuccess:(void(^)())success;

@end
