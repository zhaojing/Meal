//
//  EditMenuViewController.m
//  Meal
//
//  Created by Lvju
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "EditMenuViewController.h"
#import "SVProgressHUD.h"
#import "NSString+Meal.h"

@interface EditMenuViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) EditMenuViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *price;
@property (strong, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIAlertController *sheet;
@property (copy, nonatomic) void(^needUpdate)();

@end

@implementation EditMenuViewController

-(void)configure: (EditMenuViewModel *)viewModel needUpdate: (void(^)())needUpdate {
    self.needUpdate = needUpdate;
    self.viewModel = viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [self.viewModel getTitleName];
    self.viewModel.image ? self.imageView.image = self.viewModel.image : nil;
    self.name.text =  self.viewModel.name;
    self.price.text = self.viewModel.price;
    self.location.text = self.viewModel.location;
    [self addChoosePhotoType];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self setImageStyle];
}

#pragma mark - photo add

- (void)addChoosePhotoType {
    self.sheet = [UIAlertController alertControllerWithTitle: @"请选择方式"
                                                     message: @""
                                              preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle: @"取消"
                                                     style: UIAlertActionStyleCancel handler:nil];
    __weak EditMenuViewController *weakSelf = self;
    UIAlertAction *album = [UIAlertAction actionWithTitle: @"从相册选择"
                                                    style: UIAlertActionStyleDestructive
                                                  handler: ^(UIAlertAction * _Nonnull action) {
                                                      [self addAlbumWithController:weakSelf];
                                                  }];
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle: @"拍照"
                                                        style: UIAlertActionStyleDestructive
                                                      handler: ^(UIAlertAction * _Nonnull action) {
                                                          [self addPickerWithController:weakSelf];
                                                      }];
    [self.sheet addAction: cancel];
    [self.sheet addAction: album];
    [self.sheet addAction: takePhoto];
}

- (void)addAlbumWithController: (EditMenuViewController *)controller {
    UIImagePickerController *picker = [self.viewModel getAlbumController];
    if (!picker) {
        [SVProgressHUD showInfoWithStatus:@"相册未授权"];
        return;
    }
    picker.delegate = controller;
    [controller presentViewController: picker animated: YES completion: nil];
}

- (void)addPickerWithController: (EditMenuViewController *)controller {
    UIImagePickerController *picker = [self.viewModel getImageController];
    if (!picker) {
        [SVProgressHUD showInfoWithStatus: @"相册未授权"];
        return;
    }
    picker.delegate = controller;
    [controller presentViewController: picker animated: YES completion: nil];
}

-(void)imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo: (NSDictionary<NSString *,id> *)info{
    UIImage *resultImage = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    [self.imageView setImage: resultImage];
    [self.navigationController dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - textFileDelegate

- (BOOL)textFieldShouldReturn: (UITextField *)textField {
    UITextField *nextTextField = [self getNextTextField: textField];
    nextTextField ? [nextTextField becomeFirstResponder]: [textField resignFirstResponder];
    return YES;
}

-(UITextField *)getNextTextField: (UITextField *)textField {
    if (textField == self.location)
        return nil;
    return textField == self.name ? self.price : self.location ;
}

- (BOOL)textFieldShouldBeginEditing: (UITextField *)textField{
    [SVProgressHUD dismiss];
    return YES;
}

- (BOOL)textField: (UITextField *)textField shouldChangeCharactersInRange: (NSRange)range replacementString:(NSString *)string {
    if (textField == self.price) {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return [newString checkStringIsNumber];
    }
    return YES;
}

#pragma mark - action

- (IBAction)back: (id)sender {
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickPicture: (UIButton *)sender {
    [self presentViewController: self.sheet animated: YES completion: nil];
}

- (IBAction)save: (id)sender {
    if ([self checkText: self.name andInfo: @"名字"] && [self checkText: self.price andInfo: @"价格"] && [self checkText: self.location andInfo:@"地点"]){
        [self.viewModel saveTheImage: self.imageView.image andName: self.name.text andLocation: self.location.text andPrice: self.price.text andSuccess: ^(NSString *successInfo) {
            [SVProgressHUD showSuccessWithStatus: successInfo];
            self.needUpdate();
            [self performSelector: @selector(back:) withObject: nil afterDelay: 0.2];
        } andError: ^(NSString *errorInfo) {
            [SVProgressHUD showErrorWithStatus: errorInfo];
        }];
    }
}

-(BOOL)checkText: (UITextField *)field andInfo: (NSString *)info {
    if ([field.text isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat: @"未填写%@",info]];
        return false;
    }
    return YES;
}

- (void)setImageStyle{
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.height / 10;
}

@end
