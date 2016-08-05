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

@interface MenuListViewController ()

@property (strong , nonatomic)MenuRequest *request;
@property (strong , nonatomic)MenuListViewModel* viewModel;

@end

@implementation MenuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.request = [[MenuRequest alloc]init];
    self.viewModel = [[MenuListViewModel alloc]init];
    [self loadData];
}

-(void)loadData {
    [self.viewModel configureMenus:[self.request getAllMenus]];
    NSLog(@"betta");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"add"]) {
        EditMenuViewController *editController = segue.destinationViewController;
        [editController configure:_viewModel.willSaveMenu];
    }
}

@end
