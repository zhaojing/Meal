//
//  Menu.m
//  Meal
//
//  Created by JingZhao on 8/4/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "Menu.h"

@implementation Menu

-(instancetype)initWithId:(NSString *)menuId
                  andName:(NSString *)name
                 andprice:(NSString *)price
              andLocation:(NSString *)location
                 andImage:(UIImage *)image {
    self = [super init];
    if (self) {
        self.menuId = menuId;
        self.name = name;
        self.price = price;
        self.location = location;
        self.image = image;
    }
    return self;
}

@end
