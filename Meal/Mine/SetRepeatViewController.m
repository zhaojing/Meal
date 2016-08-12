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
@property (strong, nonatomic) IBOutlet UISwitch *weekdaysSwitch;

@end

@implementation SetRepeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAllSwitchOff];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

#pragma mark - action

- (IBAction)changeSwitchButton:(id)sender {
    [self setAllSwitchOff];
    [sender setOn:true];
    [self.delegate passRepeatFrequency:(int)[sender tag]];
}

- (void)setAllSwitchOff {
    [self.everydaySwitch setOn:false];
    [self.everyweekSwitch setOn:false];
    [self.everymonthSwitch setOn:false];
    [self.everyyearSwitch setOn:false];
    [self.weekdaysSwitch setOn:false];
}

@end
