//
//  HistoryListViewModelSpec.m
//  Meal
//
//  Created by Lvju Wang on 8/10/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "OCMock.h"
#import "HistoryListViewModel.h"
#import "Menu.h"

SPEC_BEGIN(HistoryListViewModelSpec)

describe(@"test HistoryListViewModel", ^{
    context(@"tableView have a item", ^{
        __block HistoryListViewModel *viewModel = [[HistoryListViewModel alloc] init];
        [viewModel configureHistoryItems: @[@{},@{}]];
        it(@"tableView count equal 2", ^{
            [[theValue([viewModel tableViewCount]) should] equal:theValue(2)];
        });
    });
});

SPEC_END
