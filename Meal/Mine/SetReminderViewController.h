//
//  SetReminderViewController.h
//  Meal
//
//  Created by Wei
//Fan on 8/5/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemindMeal.h"
#import "SetRepeatViewController.h"

@interface SetReminderViewController : UIViewController<PassRepeatFrequency>

- (IBAction)clickSaveReminder:(id)sender;
- (IBAction)clickDatePicker:(id)sender;
- (IBAction)clickBackground:(id)sender;

@end
