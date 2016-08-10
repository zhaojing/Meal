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
describe(@"HistoryListViewModel", ^{
    context(@"get cellViewModel", ^{
        __block HistoryListViewModel *viewModel = [[HistoryListViewModel alloc] init];
        id historyItemMock = [OCMockObject mockForClass: [NSMutableArray<HistoryItem *> class]];
        [viewModel stub: @selector(historyItem) andReturn: historyItemMock];
        id indexMock = [OCMockObject mockForClass: [NSIndexPath class]];
        it(@"", ^{
            [[[viewModel getCellViewModel: indexMock] should] beKindOfClass: [HistoryListCellViewModel class]];
        });
    });

});
SPEC_END
