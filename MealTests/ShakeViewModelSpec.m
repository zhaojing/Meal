//
//  ShakeViewModelSpec.m
//  Meal
//
//  Created by Wei Fan on 8/10/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "OCMock.h"
#import "ShakeViewModel.h"
#import "ShakeViewController.h"
#import "SVProgressHUD.h"

@interface ShakeViewController ()

@property (strong ,nonatomic) ShakeViewModel *viewModel;

- (void)shakeDataStoreWithMenu:(NSArray <Menu *> *)allMenus;

@end


SPEC_BEGIN(ShakeViewModelSpec)

describe(@"test ShakeViewModel", ^{
    it(@"getRandomMenu: allMenus should contain the return random menu", ^{
        ShakeViewModel *viewModel = [[ShakeViewModel alloc] init];
        NSMutableArray <Menu *> *allMenus =  [[ NSMutableArray <Menu *> alloc ]init];
        Menu *menu1 = [[Menu alloc] initWithId:@"1" andName:@"1" andprice:@"1" andLocation:@"1" andImage:[[UIImage alloc] init]];
        Menu *menu2 = [[Menu alloc] initWithId:@"2" andName:@"2" andprice:@"2" andLocation:@"2" andImage:[[UIImage alloc] init]];
        [allMenus addObject: menu1];
        [allMenus addObject: menu2];
        [[allMenus should] contain:[viewModel getRandomMenu: allMenus]];
    });
    it(@"saveDate andSave: if date is empty, we get a data when add a data", ^{
        ShakeViewModel *viewModel = [[ShakeViewModel alloc] init];
        NSMutableArray *shakeArray = [[NSMutableArray alloc]init];
        [[NSUserDefaults standardUserDefaults] setObject: shakeArray forKey: @"Shakelist"];
        NSDate * date = [NSDate date];
        BOOL save = YES;
        [viewModel saveDate: date andSave: save];
        NSMutableArray *newShakeArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Shakelist"];
        [[newShakeArray should] contain: @{@"date": date, @"save": @YES}];
    });
    it(@"saveDate andSave: if have one data, we get a data when add a data", ^{
        ShakeViewModel *viewModel = [[ShakeViewModel alloc] init];
        NSMutableArray *shakeArray = [[NSMutableArray alloc] initWithObjects: @[@{@"date":[NSDate date],@"save":[NSNumber numberWithBool:NO]}], nil];
        [[NSUserDefaults standardUserDefaults] setObject: shakeArray forKey: @"Shakelist"];
        NSDate * date = [NSDate date];
        BOOL save = YES;
        [viewModel saveDate: date andSave: save];
        NSMutableArray *newShakeArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Shakelist"];
        [[newShakeArray should] contain: @{@"date": date, @"save": @YES}];
    });
    it(@"confirmIfCanShake 当前没有被选过", ^{
        ShakeViewController *controller = [ShakeViewController new];
        ShakeViewModel *viewModel = [ShakeViewModel nullMock];
        [viewModel stub:@selector(confirmIfCanShake:andError:) withBlock:^id(NSArray *params) {
            void (^Success)() = (void(^)())params[0];
            Success();
            return nil;
        }];
        controller.viewModel = viewModel;
        [[viewModel should]receive:@selector(getRandomMenu:)];
        [controller shakeDataStoreWithMenu:nil];
    });
    it(@"confirmIfCanShake 在当前一个小时之内已经选过了", ^{
        ShakeViewController *controller = [ShakeViewController new];
        ShakeViewModel *viewModel = [ShakeViewModel nullMock];
        [viewModel stub:@selector(confirmIfCanShake:andError:) withBlock:^id(NSArray *params) {
            void (^Error)(NSString *) = (void (^)(NSString *))params[1];
            Error(@"在当前一个小时之内已经选过了");
            return nil;
        }];
        controller.viewModel = viewModel;
        [[SVProgressHUD should]receive:@selector(showErrorWithStatus:)];
        [controller shakeDataStoreWithMenu:nil];
    });
});

SPEC_END