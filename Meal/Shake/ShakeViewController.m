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
        [SVProgressHUD dismiss];
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
                self.menu = [self.shakeViewModel getRandomMenu:allMenus];
                [self showResult];
                [self.shakeViewModel saveDate:[NSDate date] andSave:false];
            } andError:^(NSString *string) {
                [SVProgressHUD showErrorWithStatus:string];
            }];
        }
    }
}

#pragma mark - ClickButtonAction

- (IBAction)clickConfirm:(id)sender {
    [self.shakeViewModel saveHistory:self.menu
                             andDate:[NSDate date]
                          andSuccess:^(NSString *successInfo) {
                              [self.confirmButton setEnabled:false];
                              [SVProgressHUD showSuccessWithStatus:@"出发啦 记得带纸巾哦！"];
                              [self.shakeViewModel saveDate:[NSDate date] andSave:YES];
                          } andError:^(NSString *errorInfo) {
                              [SVProgressHUD showErrorWithStatus: errorInfo];
                          }];
}

@end
