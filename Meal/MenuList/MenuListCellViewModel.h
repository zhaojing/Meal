//
//  MenuListCellViewModel.h
//  Meal
//
//  Created by JingZhao on 8/5/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Menu.h"

@interface MenuListCellViewModel : NSObject

- (instancetype)initWithMenu: (Menu *)menu;
- (NSString *)getName;
- (NSString *)getPrice;
- (NSString *)getLocation;
- (UIImage *)getImage;

@end
