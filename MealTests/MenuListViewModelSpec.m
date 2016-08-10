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
//    context(@"configure menus", ^{
//        __block MenuListViewModel *viewModel;
//        beforeEach(^{
//            id menuMock = [OCMockObject mockForClass: [Menu class]];
//            viewModel = [[MenuListViewModel alloc] init];
//            [viewModel stub: @selector(menu) andReturn: menuMock];
//        });
//        it(@"", ^{
//        });
//    });
    
    context(@"will save menu", ^{
        __block MenuListViewModel *viewModel = [[MenuListViewModel alloc] init];
        it(@"", ^{
            [[[viewModel willSaveMenu] should] beKindOfClass: [EditMenuViewModel class]];
        });
    });

    context(@"get tableView count", ^{
        __block MenuListViewModel *viewModel = [[MenuListViewModel alloc] init];
        id menuMock = [OCMockObject mockForClass: [Menu class]];
        [viewModel stub: @selector(menu) andReturn: menuMock];
        it(@"", ^{
            [[theValue([viewModel tableViewCount]) should] equal: theValue([menuMock count])];
        });
    });
    
    context(@"will edit menu with index", ^{
        __block MenuListViewModel *viewModel = [[MenuListViewModel alloc] init];
        id menuMock = [OCMockObject mockForClass: [Menu class]];
        [viewModel stub: @selector(menu) andReturn: menuMock];
        id indexMock = [OCMockObject mockForClass: [NSIndexPath class]];
        it(@"", ^{
            [[[viewModel willEditMenuWithIndex: indexMock] should] beKindOfClass: [EditMenuViewModel class]];
        });
    });
    
    context(@"get cellViewModel", ^{
        __block MenuListViewModel *viewModel = [[MenuListViewModel alloc] init];
        id menuMock = [OCMockObject mockForClass: [Menu class]];
        [viewModel stub: @selector(menu) andReturn: menuMock];
        id indexMock = [OCMockObject mockForClass: [NSIndexPath class]];
        it(@"", ^{
            [[[viewModel getCellViewModel: indexMock] should] beKindOfClass: [MenuListCellViewModel class]];
        });
    });

});

SPEC_END