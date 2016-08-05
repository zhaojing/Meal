//
//  MenuListViewModel.m
//  Meal
//
//  Created by Lvju Wang on 8/5/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "MenuListViewModel.h"

@interface MenuListViewModel ()

@property (strong , nonatomic)NSMutableArray<Menu *> * menus;

@end

@implementation MenuListViewModel

-(void)configureMenus:(NSArray<Menu *> *)menus {
    self.menus = [NSMutableArray arrayWithArray:menus];
}

-(EditMenuViewModel *)willSaveMenu {
    return  [[EditMenuViewModel alloc]init];
}

-(EditMenuViewModel *)willEditMenuWithIndex:(NSIndexPath*)index {
    return  [[EditMenuViewModel alloc]initWithMenu: [_menus objectAtIndex:index.row]];
}

@end
