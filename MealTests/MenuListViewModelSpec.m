//
//  MenuListViewModelSpec.m
//  Meal
//
//  Created by Lvju Wang on 8/9/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "OCMock.h"
#import "MenuListViewModel.h"
#import "Menu.h"

SPEC_BEGIN(MenuListViewModelSpec)

describe(@"MenuListViewModel", ^{
    context(@"will save menu", ^{
        MenuListViewModel *viewModel = [[MenuListViewModel alloc] init];
        it(@"return type be kind of EditMenuViewModel", ^{
            [[[viewModel willSaveMenu] should] beKindOfClass: [EditMenuViewModel class]];
        });
    });
    context(@"menu have 2", ^{
        MenuListViewModel *viewModel = [[MenuListViewModel alloc] init];
        [viewModel configureMenus:@[@{},@{}]];
        it(@"count should equal 2", ^{
            [[theValue([viewModel tableViewCount]) should] equal: theValue(2)];
        });
    });
    context(@"will edit menu with index", ^{
        MenuListViewModel *viewModel = [[MenuListViewModel alloc] init];
        Menu *menu = [[Menu alloc] initWithId:@"1" andName:@"1" andprice:@"1" andLocation:@"1" andImage: [[UIImage alloc]init]];
        [viewModel configureMenus: @[menu]];
        it(@"return type be kind of EditMenuViewModel", ^{
            [[[viewModel willEditMenuWithIndex: [NSIndexPath indexPathForRow:0 inSection:0]] should] beKindOfClass: [EditMenuViewModel class]];
        });
    });
    context(@"get cellViewModel", ^{
        __block MenuListViewModel *viewModel = [[MenuListViewModel alloc] init];
        Menu *menu = [[Menu alloc] initWithId:@"1" andName:@"1" andprice:@"1" andLocation:@"1" andImage: [[UIImage alloc]init]];
        [viewModel configureMenus: @[menu]];
        it(@"return type be kind of EditMenuViewModel", ^{
            [[[viewModel getCellViewModel: [NSIndexPath indexPathForRow:0 inSection:0]] should] beKindOfClass: [MenuListCellViewModel class]];
        });
    });
});

SPEC_END