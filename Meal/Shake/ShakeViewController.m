//
//  ShakeViewController.m
//  Meal
//
//  Created by JingZhao on 8/4/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "ShakeViewController.h"
#import "EditHistoryViewModel.h"
#import "SVProgressHUD.h"
#import "MenuRequest.h"
#import "Menu.h"

@interface ShakeViewController ()

@property (strong, nonatomic) MenuRequest *request;
@property (strong, nonatomic) Menu *menu;
@property (strong, nonatomic) EditHistoryViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UIImageView *resultImage;
@property (strong, nonatomic) IBOutlet UILabel *resultName;
@property (strong, nonatomic) IBOutlet UILabel *resultPrice;
@property (strong, nonatomic) IBOutlet UILabel *resultLocation;
@property ShakeStatus currentShakeStatus;

@end

@implementation ShakeViewController

-(void)configure: (EditHistoryViewModel *)viewModel needUpdate: (void(^)())needUpdate {
    self.viewModel = viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cleanUIForShakeBegin];
    self.viewModel = [[EditHistoryViewModel alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)cleanUIForShakeBegin {
    self.currentShakeStatus = beginToShake;
    self.resultImage.image = [UIImage imageNamed:@"images.png"];
    [self.resultName setHidden:true];
    [self.resultPrice setHidden:true];
    [self.resultLocation setHidden:true];
}

#pragma mark - ShakeAction

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
     if (motion == UIEventSubtypeMotionShake) {
         if (self.currentShakeStatus == showResult) {
             return;
         }
         self.request = [[MenuRequest alloc] init];
         NSArray *allMenus = [self.request getAllMenus];
         if([allMenus count] == 0) {
             [SVProgressHUD showErrorWithStatus: @"还没有选项，请先添加一些"];
         }else{
             self.menu = allMenus[arc4random() % [allMenus count]];
             self.resultImage.image = self.menu.image;
             [self.resultName setHidden:false];
             [self.resultPrice setHidden:false];
             [self.resultLocation setHidden:false];
             self.resultName.text = self.menu.name;
             self.resultPrice.text = self.menu.price;
             self.resultLocation.text = self.menu.location;
        }
    }
}

#pragma mark - ClickButtonAction

- (IBAction)clickShakeAgain:(id)sender {
    [self cleanUIForShakeBegin];
}

- (IBAction)clickConfirm:(id)sender {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
    NSDateComponents *dateComponents  = [calendar components:unitFlags fromDate:[NSDate date]];
    [self.viewModel saveTheImage:self.self.menu.image andMenuId:self.menu.menuId andName:self.menu.name andLocation:self.menu.location andDate:[NSString stringWithFormat:@"%ld-%ld-%ld %ld时",(long)[dateComponents year], [dateComponents month], (long)[dateComponents day], (long)[dateComponents hour]] andYear:[dateComponents year] andMonth:[dateComponents month] andPrice:self.menu.price andSuccess:^(NSString *successInfo){
        [SVProgressHUD showSuccessWithStatus:@"出发啦 记得带纸巾哦！"];
    }andError:^(NSString *errorInfo){
        [SVProgressHUD showErrorWithStatus: errorInfo];
    }];
}

@end
