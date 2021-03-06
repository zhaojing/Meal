//
//  ShakeViewController.m
//  Meal
//
//  Created by JingZhao on 8/4/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "ShakeViewController.h"
#import "ShakeViewModel.h"
#import "SVProgressHUD.h"
#import "MenuRequest.h"
#import "Menu.h"

@interface ShakeViewController ()

@property (strong, nonatomic) Menu *menu;
@property (strong ,nonatomic) ShakeViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UIView *DataView;
@property (strong, nonatomic) IBOutlet UIImageView *resultImage;
@property (strong, nonatomic) IBOutlet UIImageView *backgrougdImage;
@property (strong, nonatomic) IBOutlet UILabel *resultName;
@property (strong, nonatomic) IBOutlet UILabel *resultPrice;
@property (strong, nonatomic) IBOutlet UILabel *resultLocation;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"shock.mp3" withExtension:Nil];
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:Nil];
    [self cleanUI];
    self.viewModel = [[ShakeViewModel alloc]init];
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
    [self setImageStyle];
    [self setButtonStyle];
}

#pragma mark - ShakeAction

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [SVProgressHUD dismiss];
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        [self cleanUI];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        NSArray <Menu *> *allMenus = [[[MenuRequest alloc] init] getAllMenus];
        if([allMenus count] == 0) {
            [SVProgressHUD showErrorWithStatus: @"还没有选项，请先添加一些"];
        } else {
            [self shakeDataStoreWithMenu:allMenus];
        }
    }
}

-(void)shakeDataStoreWithMenu:(NSArray <Menu *> *)allMenus {
    [self.viewModel confirmIfCanShake:^{
        self.menu = [self.viewModel getRandomMenu:allMenus];
        [self showResult];
        [self.viewModel saveDate:[NSDate date] andSave:false];
    } andError:^(NSString *string) {
        [SVProgressHUD showErrorWithStatus:string];
    }];
}

#pragma mark - ClickButtonAction

- (IBAction)clickConfirm:(id)sender {
    [self.viewModel saveHistory:self.menu
                        andDate:[NSDate date]
                     andSuccess:^(NSString *successInfo) {
                         [self.confirmButton setEnabled:false];
                         [SVProgressHUD showSuccessWithStatus:@"出发啦 记得带纸巾哦！"];
                         [self.viewModel saveDate:[NSDate date] andSave:YES];
                     } andError:^(NSString *errorInfo) {
                         [SVProgressHUD showErrorWithStatus: errorInfo];
                     }];
}

- (void)setImageStyle{
    self.resultImage.layer.masksToBounds = YES;
    self.resultImage.layer.cornerRadius = self.resultImage.frame.size.height / 10;
}

- (void)setButtonStyle{
    self.confirmButton.layer.masksToBounds = YES;
    self.confirmButton.layer.cornerRadius = self.confirmButton.frame.size.height / 8;
}

@end