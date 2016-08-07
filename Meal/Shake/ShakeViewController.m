//
//  ShakeViewController.m
//  Meal
//
//  Created by JingZhao on 8/4/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "ShakeViewController.h"
#import "SVProgressHUD.h"
#import "MenuRequest.h"
#import "Menu.h"

@interface ShakeViewController ()

@property (strong, nonatomic) MenuRequest *request;

@property (strong, nonatomic) IBOutlet UIImageView *resultImage;
@property (strong, nonatomic) IBOutlet UILabel *resultName;
@property (strong, nonatomic) IBOutlet UILabel *resultPrice;
@property (strong, nonatomic) IBOutlet UILabel *resultLocation;
@property ShakeStatus currentShakeStatus;

@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cleanUIForShakeBegin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)cleanUIForShakeBegin {
    self.currentShakeStatus = beginToShake;
    self.resultImage.image = [UIImage imageNamed:@"dishes.png"];
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
             Menu *randomMenu = allMenus[arc4random() % [allMenus count]];
             self.resultImage.image = randomMenu.image;
             self.resultName.text = randomMenu.name;
             self.resultPrice.text = randomMenu.price;
             self.resultLocation.text = randomMenu.location;
        }
    }
}

#pragma mark - ClickButtonAction

- (IBAction)clickShakeAgain:(id)sender {
    [self cleanUIForShakeBegin];
}

- (IBAction)clickConfirm:(id)sender {
    [SVProgressHUD showSuccessWithStatus: @"确定成功"];
}

@end
