//
//  ShakeViewController.m
//  Meal
//
//  Created by JingZhao on 8/4/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "ShakeViewController.h"
#import "MenuRequest.h"
#import "Menu.h"

@interface ShakeViewController ()

@property (strong, nonatomic) MenuRequest *request;

@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - ShakeAction

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        self.request = [[MenuRequest alloc] init];
        NSArray *allMenus = [self.request getAllMenus];
        Menu *randomMenu = allMenus[arc4random() % [allMenus count]];
        NSLog(@"menuId:%ld name:%@ price:%@ location:%@",
              (long)randomMenu.menuId,
              randomMenu.name,
              randomMenu.price,
              randomMenu.location);
    }
}

@end
