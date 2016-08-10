//
//  ShakeViewController.m
//  Meal
//
//  Created by JingZhao on 8/4/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "ShakeViewController.h"
#import "ShakeViewModel.h"
#import "SVProgressHUD.h"
#import "MenuRequest.h"
#import "Menu.h"

@interface ShakeViewController ()

@property (strong, nonatomic) Menu *menu;
@property (strong ,nonatomic) ShakeViewModel *shakeViewModel;
@property (strong, nonatomic) IBOutlet UIView *DataView;
@property (strong, nonatomic) IBOutlet UIImageView *resultImage;
@property (strong, nonatomic) IBOutlet UIImageView *backgrougdImage;
@property (strong, nonatomic) IBOutlet UILabel *resultName;
@property (strong, nonatomic) IBOutlet UILabel *resultPrice;
@property (strong, nonatomic) IBOutlet UILabel *resultLocation;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong, nonatomic) NSDate *date;

@end

@implementation ShakeViewController

-(void)configure: (ShakeViewModel *)shakeViewModel needUpdate: (void(^)())needUpdate {
    self.shakeViewModel = shakeViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cleanUI];
    self.shakeViewModel = [[ShakeViewModel alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - SetUI

- (void)cleanUI {
    self.backgrougdImage.image = [UIImage imageNamed:@"shake.png"];
    [self.DataView setHidden:true];
}

- (void)showResult {
    [self.DataView setHidden:false];
    self.resultImage.image = self.menu.image;
    self.resultName.text = self.menu.name;
    self.resultPrice.text = self.menu.price;
    self.resultLocation.text = self.menu.location;
}

#pragma mark - ShakeAction

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [self cleanUI];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        NSArray *allMenus = [[[MenuRequest alloc] init] getAllMenus];
        if([allMenus count] == 0) {
            [SVProgressHUD showErrorWithStatus: @"还没有选项，请先添加一些"];
        } else {
            [self.shakeViewModel confirmIfCanShake:^{
                self.menu = allMenus[arc4random() % [allMenus count]];
                [self showResult];
                self.date  = [NSDate date];
                [self.shakeViewModel saveDate:self.date andSave:false];
            } andError:^(NSString *string) {
                [SVProgressHUD showErrorWithStatus:string];
            }];
        }
    }
}

#pragma mark - ClickButtonAction

- (IBAction)clickConfirm:(id)sender {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
    NSDateComponents *dateComponents  = [calendar components:unitFlags fromDate:self.date];
    [self.shakeViewModel saveTheImage:self.self.menu.image andMenuId:self.menu.menuId andName:self.menu.name andLocation:self.menu.location andDate:[NSString stringWithFormat:@"%ld-%ld-%ld %ld时",(long)[dateComponents year], (long)[dateComponents month], (long)[dateComponents day], (long)[dateComponents hour]] andYear:[dateComponents year] andMonth:[dateComponents month] andPrice:self.menu.price andSuccess:^(NSString *successInfo) {
        [self.confirmButton setEnabled:false];
        [SVProgressHUD showSuccessWithStatus:@"出发啦 记得带纸巾哦！"];
        [self.shakeViewModel saveDate:self.date andSave:YES];
    }andError:^(NSString *errorInfo){
        [SVProgressHUD showErrorWithStatus: errorInfo];
    }];
}

@end
