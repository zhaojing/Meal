//
//  ShakeViewController.h
//  Meal
//
//  Created by JingZhao on 8/4/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, ShakeStatus) {
    beginToShake = 0,
    showResult
};

@interface ShakeViewController : UIViewController

- (IBAction)clickShakeAgain:(id)sender;
- (IBAction)clickConfirm:(id)sender;

@end
