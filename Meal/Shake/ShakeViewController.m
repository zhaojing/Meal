//
//  ShakeViewController.m
//  Meal
//
//  Created by JingZhao on 8/4/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "ShakeViewController.h"
#import "EditHistoryViewModel.h"
#import "ShakeViewModel.h"
#import "SVProgressHUD.h"
#import "MenuRequest.h"
#import "Menu.h"

@interface ShakeViewController ()

@property (strong, nonatomic) MenuRequest *request;
@property (strong, nonatomic) Menu *menu;
@property (strong, nonatomic) EditHistoryViewModel *viewModel;
@property (strong ,nonatomic) ShakeViewModel *shakeViewModel;
@property (strong, nonatomic) IBOutlet UIImageView *resultImage;
@property (strong, nonatomic) IBOutlet UILabel *resultName;
@property (strong, nonatomic) IBOutlet UILabel *resultPrice;
@property (strong, nonatomic) IBOutlet UILabel *resultLocation;
@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) BOOL currentShakeStatus;

@end

@implementation ShakeViewController

-(void)configure: (EditHistoryViewModel *)viewModel needUpdate: (void(^)())needUpdate {
    self.viewModel = viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cleanUIForShakeBegin];
    self.viewModel = [[EditHistoryViewModel alloc]init];
    self.shakeViewModel = [[ShakeViewModel alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)cleanUI:(BOOL)status {
    self.currentShakeStatus = status ? beginToShake : showResult;
    [self.resultName setHidden:status];
    [self.resultPrice setHidden:status];
    [self.resultLocation setHidden:status];
    if (status) {
        self.resultImage.image = [UIImage imageNamed:@"dishes.png"];
    } else {
        self.resultImage.image = self.menu.image;
        self.resultName.text = self.menu.name;
        self.resultPrice.text = self.menu.price;
        self.resultLocation.text = self.menu.location;
    }
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
        [self cleanUIForShakeBegin];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        self.request = [[MenuRequest alloc] init];
        NSArray *allMenus = [self.request getAllMenus];
        if([allMenus count] == 0) {
            [SVProgressHUD showErrorWithStatus: @"还没有选项，请先添加一些"];
        } else {
            [self.shakeViewModel confirmIfCanShake:^{
                self.menu = allMenus[arc4random() % [allMenus count]];
                [self cleanUI:false];
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
    if (self.currentShakeStatus == showResult) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
        NSDateComponents *dateComponents  = [calendar components:unitFlags fromDate:self.date];
        [self.viewModel saveTheImage:self.self.menu.image andMenuId:self.menu.menuId andName:self.menu.name andLocation:self.menu.location andDate:[NSString stringWithFormat:@"%ld-%ld-%ld %ld时",(long)[dateComponents year], [dateComponents month], (long)[dateComponents day], (long)[dateComponents hour]] andYear:[dateComponents year] andMonth:[dateComponents month] andPrice:self.menu.price andSuccess:^(NSString *successInfo){
            [SVProgressHUD showSuccessWithStatus:@"出发啦 记得带纸巾哦！"];
            [self.shakeViewModel saveDate:self.date andSave:YES];
        }andError:^(NSString *errorInfo){
            [SVProgressHUD showErrorWithStatus: errorInfo];
        }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"还没有摇动结果"];
    }
    
}

@end
