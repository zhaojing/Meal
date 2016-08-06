//
//  Menu.h
//  Meal
//
//  Created by JingZhao on 8/4/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Menu : NSObject

@property (strong, nonatomic)NSString * menuId;
@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)NSString *location;
@property (strong, nonatomic)NSString *price;
@property (strong, nonatomic)UIImage *image;

-(instancetype)initWithId:(NSString *)menuId
                  andName:(NSString *)name
                 andprice:(NSString *)price
              andLocation:(NSString *)location
                 andImage:(UIImage *)image;
@end
