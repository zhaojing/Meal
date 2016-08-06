//
//  MenuListViewController.m
//  Meal
//
//  Created by JingZhao on 8/4/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "MenuListViewController.h"
#import "EditMenuViewController.h"
#import "MenuListViewModel.h"
#import "MenuRequest.h"
#import "MenuListCell.h"

@interface MenuListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong , nonatomic)MenuRequest *request;
@property (strong , nonatomic)MenuListViewModel *viewModel;

@end

@implementation MenuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.request = [[MenuRequest alloc]init];
    self.viewModel = [[MenuListViewModel alloc]init];
    [self loadData];
}

-(void)loadData {
    [self.viewModel configureMenus: [self.request getAllMenus]];
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"add"]) {
        EditMenuViewController *editController = segue.destinationViewController;
        [editController configure: self.viewModel.willSaveMenu needUpdate: ^{
            [self loadData];
        }];
    } else if ([segue.identifier isEqualToString:@"edit"]){
        EditMenuViewController *editController = segue.destinationViewController;
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
        [editController configure: [self.viewModel willEditMenuWithIndex:index] needUpdate: ^{
            [self loadData];
        }];
    }
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.tableViewCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuListCell *cell = [tableView dequeueReusableCellWithIdentifier:[MenuListCell identifierCell]];
    [cell configureViewModel:[self.viewModel getCellViewModel:indexPath]];

    return cell;
}

@end
