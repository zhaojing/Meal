//
//  SetRepeatViewController.h
//  Meal
//
//  Created by Wei
//Fan on 8/5/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RepeatFrequency) {
    everyday = 0,
    everyweek,
    everymonth,
    everyyear
};

@protocol PassRepeatFrequency <NSObject>

- (void)passRepeatFrequency:(int)repeatFrequency;

@end

@interface SetRepeatViewController : UIViewController

@property (strong, nonatomic) NSObject<PassRepeatFrequency> *delegate;

- (IBAction)changeSwitchButton:(id)sender;

@end
