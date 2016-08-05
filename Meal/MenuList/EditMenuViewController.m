//
//  EditMenuViewController.m
//  Meal
//
//  Created by Lvju
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "EditMenuViewController.h"

@interface EditMenuViewController ()

@property (strong, nonatomic) EditMenuViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *price;
@property (strong, nonatomic) IBOutlet UITextField *location;
@property (strong, nonatomic) UIAlertController *sheet;
@property (strong, nonatomic) IBOutlet UIButton *pictureButton;

@end

@implementation EditMenuViewController

-(void)configure:(EditMenuViewModel *)viewModel {
    self.viewModel = viewModel;
    self.name.text =  viewModel.name;
    self.price.text = viewModel.price;
    self.location.text = viewModel.location;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self addChoosePhotoType];
}

- (IBAction)clickPicture:(UIButton *)sender {
    [self presentViewController:self.sheet animated:YES completion:nil];
}

-(void)addChoosePhotoType {
    self.sheet = [UIAlertController alertControllerWithTitle: @"请选择方式"
                                                     message: @""
                                              preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle: @"取消"
                                                     style: UIAlertActionStyleCancel handler:nil];
    __weak EditMenuViewController *weakSelf = self;
    UIAlertAction *album = [UIAlertAction actionWithTitle: @"从相册选择"
                                                    style:UIAlertActionStyleDestructive
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

-(void)addAlbumWithController:(EditMenuViewController *)controller {
    UIImagePickerController *picker = [self.viewModel getAlbumController];
    picker.delegate = controller;
    [controller presentViewController:picker animated:YES completion:nil];
}

-(void)addPickerWithController:(EditMenuViewController *)controller {
    UIImagePickerController *picker = [self.viewModel getImageController];
    picker.delegate = controller;
    [controller presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *resultImage = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    [self.pictureButton setImage: [resultImage imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]forState: UIControlStateNormal];
    [self.navigationController dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
