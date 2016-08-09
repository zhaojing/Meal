//
//  ShakeViewModel.h
//  Meal
//
//  Created by Wei Fan on 8/8/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShakeViewModel : NSObject

- (void)confirmIfCanShake:(void(^)())succes andError:(void(^)(NSString *string))error;
- (void)saveDate:(NSDate *)date andSave:(BOOL)save;

@end
