 //
//  MenuListCellViewModel.m
//  Meal
//
//  Created by JingZhao on 8/5/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "MenuListCellViewModel.h"

@interface MenuListCellViewModel ()

@property (strong, nonatomic)Menu* menu;

@end

@implementation MenuListCellViewModel

- (instancetype)initWithMenu: (Menu *)menu {
    self = [super init];
    if (self) {
        self.menu = menu;
    }
    return self;
}

- (NSString *)getName {
    return self.menu.name;
}

- (NSString *)getPrice {
    return [NSString stringWithFormat:@"￥%@", self.menu.price];
}

- (NSString *)getLocation {
    return self.menu.location;
}

- (UIImage *)getImage {
    return self.menu.image;
}

- (NSString *)getMenuId {
    return self.menu.menuId;
}

@end
