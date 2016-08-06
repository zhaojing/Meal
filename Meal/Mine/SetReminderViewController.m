//
//  SetReminderViewController.m
//  Meal
//
//  Created by Wei
//Fan on 8/5/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "SetReminderViewController.h"

@interface SetReminderViewController ()

@property (strong, nonatomic) IBOutlet UIDatePicker *reminderDatePicker;
@property (strong, nonatomic) IBOutlet UITextField *reminderTitleTextFiled;
@property (strong, nonatomic) RemindMeal *myRemindMeal;
@property (strong, nonatomic) NSDictionary *remindDictionary;
@property (strong, nonatomic) NSString *reminderRepeatFrequency;

@end

@implementation SetReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SetRepeatViewController *setRepeatController = (SetRepeatViewController *)segue.destinationViewController;
    setRepeatController.delegate = self;
}

#pragma mark- PassRepeateFrequcnryDelegate

- (void)passRepeatFrequency:(int)repeatFrequency {
    self.reminderRepeatFrequency = [NSString stringWithFormat:@"%d", repeatFrequency];
}

#pragma mark- action

- (IBAction)clickSaveReminder:(id)sender {
    [self.reminderTitleTextFiled resignFirstResponder];
    self.remindDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                             [self.reminderDatePicker date], @"alarm",
                             [[self.reminderTitleTextFiled text] isEqual:@""] ? @"吃饭啦" : [self.reminderTitleTextFiled text], @"title",
                             self.reminderRepeatFrequency, @"repeat",
                             nil];
    self.myRemindMeal = [[RemindMeal alloc] init];
    [self.myRemindMeal addRemindParams:self.remindDictionary
                              andError:^(RemindAddErrorResult addResult, NSString *errorInfo) {
                                  NSLog(@"add error");
                              } andSuccess:^{
                                  NSLog(@"add success");
                              }];
}

- (IBAction)clickBackground:(id)sender {
    [self.reminderTitleTextFiled resignFirstResponder];
}

- (IBAction)clickDatePicker:(id)sender {
    [self.reminderTitleTextFiled resignFirstResponder];
}

@end
