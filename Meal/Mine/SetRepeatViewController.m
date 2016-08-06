//
//  SetRepeatViewController.m
//  Meal
//
//  Created by Wei
//Fan on 8/5/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "SetRepeatViewController.h"

@interface SetRepeatViewController ()

@property (strong, nonatomic) IBOutlet UISwitch *everydaySwitch;
@property (strong, nonatomic) IBOutlet UISwitch *everyweekSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *everymonthSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *everyyearSwitch;

@end

@implementation SetRepeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.everydaySwitch setOn:false];
    [self.everyweekSwitch setOn:false];
    [self.everymonthSwitch setOn:false];
    [self.everyyearSwitch setOn:false];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- action

- (IBAction)changeSwitchButton:(id)sender {
    if ([sender tag] != everyday) {
        [self.everydaySwitch setOn:false];
    }
    if ([sender tag] != everyweek) {
        [self.everyweekSwitch setOn:false];
    }
    if ([sender tag] != everymonth) {
        [self.everymonthSwitch setOn:false];
    }
    if ([sender tag] != everyyear) {
        [self.everyyearSwitch setOn:false];
    }
    [self.delegate passRepeatFrequency:(int)[sender tag]];
}

@end
