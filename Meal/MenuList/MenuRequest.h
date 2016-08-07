//
//  MenuRequest.h
//  Meal
//
//  Created by JingZhao on 8/4/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Menu.h"

@interface MenuRequest : NSObject

- (BOOL)addMenu: (Menu *)menu;
- (BOOL)deleteMenu: (NSString *)menuId;
- (NSArray<Menu *> *)getAllMenus;
- (BOOL)modifyMenu: (Menu *)menu;

@end
