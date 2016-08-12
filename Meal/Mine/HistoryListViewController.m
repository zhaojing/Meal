//
//  HistoryListViewController.m
//  Meal
//
//  Created by Wei Fan on 8/7/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "HistoryListViewController.h"
#import "HistoryListViewModel.h"
#import "HistoryRequest.h"
#import "HistoryListCell.h"

@interface HistoryListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *historyTableView;
@property (strong, nonatomic)HistoryRequest *historyRequest;
@property (strong, nonatomic)HistoryListViewModel *historyViewModel;

@end

@implementation HistoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.historyRequest = [[HistoryRequest alloc] init];
    self.historyViewModel = [[HistoryListViewModel alloc] init];
    [self loadData];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.historyTableView.tableFooterView = [UIView new];
}

- (void)loadData {
    [self.historyViewModel configureHistoryItems: [self.historyRequest getAllHistoryItems]];
    [self.historyTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return self.historyViewModel.tableViewCount;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    HistoryListCell *cell = [tableView dequeueReusableCellWithIdentifier: [HistoryListCell identifierCell]];
    [cell configureViewModel: self.historyViewModel andIndex: indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *deletedId = [self.historyViewModel getItemIdWithIndex: indexPath];
        [self.historyRequest deleteHistoryItem:deletedId];
        [self loadData];
    }
}

@end
