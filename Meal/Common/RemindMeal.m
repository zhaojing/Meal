//
//  RemindMeal.m
//  Meal
//
//  Created by JingZhao on 8/4/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//
#import <EventKit/EventKit.h>
#import "RemindMeal.h"

@interface SingletonEventStore : NSObject

@property (strong, nonatomic) EKEventStore *eventStore;

+ (id)shareObject;

@end

static SingletonEventStore * object;

@implementation SingletonEventStore

+ (id)shareObject {
    if (!object) {
        object = [[SingletonEventStore alloc]init];
    }
    return object;
}

- (id)init {
    self = [super init];
    if (self) {
        self.eventStore = [[EKEventStore alloc]init];
    }
    return self;
}

@end

@implementation RemindMeal

- (void)addRemindParams:(NSDictionary *)remind
               andError:(void(^)(RemindAddErrorResult addResult, NSString *errorInfo))errorResult
             andSuccess:(void(^)())success {
    SingletonEventStore  *singletonEventStore = [SingletonEventStore shareObject];
    EKEventStore *eventStore = singletonEventStore.eventStore;
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) {
            errorResult(errorAuthorize, @"授权失败");
            return ;
        }
        [self addCalendarWithRemind:remind andError:errorResult andSuccess:success];
    }];
}

- (void)addCalendarWithRemind:(NSDictionary*)remind
                     andError:(void(^)(RemindAddErrorResult addResult, NSString *errorInfo))errorResult
                   andSuccess:(void(^)())success {
    SingletonEventStore  *staticEvent = [SingletonEventStore shareObject];
    EKEventStore *eventStore = staticEvent.eventStore;
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    event.calendar = [eventStore defaultCalendarForNewEvents];
    event.timeZone = [NSTimeZone systemTimeZone];
    event.title = [remind.allKeys containsObject:@"title"] ? remind[@"title"] : @"吃饭啦";
    NSDate *alarm = [remind.allKeys containsObject:@"alarm"] ? remind[@"alarm"] : [NSDate date];
    [event addAlarm:[EKAlarm alarmWithAbsoluteDate:alarm]];
    event.startDate = [remind.allKeys containsObject:@"startDate"] ? remind[@"startDate"] : alarm;
    event.URL = [NSURL URLWithString:@"iOSDevMeal://"];
    event.endDate = [remind.allKeys containsObject:@"endDate"] ? remind[@"endDate"] : [alarm dateByAddingTimeInterval:1*60*60];
    event.notes = [remind.allKeys containsObject:@"notes"] ? remind[@"notes"] : @"";
    NSString *repeat = [remind.allKeys containsObject:@"repeat"] ? remind[@"repeat"] : @"" ;
    if (![repeat isEqualToString:@""]) {
        [event addRecurrenceRule:[[EKRecurrenceRule alloc] initRecurrenceWithFrequency:repeat.integerValue interval:1 end:nil]];
    }
    __block NSError *err;
    [eventStore saveEvent:event span:EKSpanFutureEvents commit:YES error:&err];
    if (err) {
        errorResult(errorAdd, [NSString stringWithFormat:@"addCalendar = %@", err]);
    }
    success();
}

@end
