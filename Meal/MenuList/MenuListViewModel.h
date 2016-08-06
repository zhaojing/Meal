//
//  MenuListViewModel.h
//  Meal
//
//  Created by Lvju Wang on 8/5/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditMenuViewModel.h"
#import "MenuListCellViewModel.h"
#import "Menu.h"

@interface MenuListViewModel : NSObject

- (void)configureMenus: (NSArray<Menu *> *)menus;
- (EditMenuViewModel *)willSaveMenu;
- (EditMenuViewModel *)willEditMenuWithIndex: (NSIndexPath *)index;
- (MenuListCellViewModel *)getCellViewModel: (NSIndexPath *)index;
- (NSUInteger )tableViewCount;

@end
