//
//  EditMenuViewController.m
//  Meal
//
//  Created by Lvju
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "EditMenuViewController.h"

@interface EditMenuViewController ()

@property (strong, nonatomic) UIAlertController *sheet;
@property (strong, nonatomic) IBOutlet UIButton *pictureButton;

@end

@implementation EditMenuViewController

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
    UIAlertAction *album = [UIAlertAction actionWithTitle: @"从相册选择"
                                                    style:UIAlertActionStyleDestructive
                                                  handler: ^(UIAlertAction * _Nonnull action) {
                                [self addAlbum];
                            }];
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle: @"拍照"
                                                        style: UIAlertActionStyleDestructive
                                                      handler: ^(UIAlertAction * _Nonnull action) {
                                    [self addTakePhoto];
                                }];
    [self.sheet addAction: cancel];
    [self.sheet addAction: album];
    [self.sheet addAction: takePhoto];
}

-(BOOL)addAlbum {
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]){
        NSLog(@"相册不可用");
        return NO;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController: picker animated: YES completion: nil];
    return YES;
}

-(BOOL)addTakePhoto {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        NSLog(@"相册不可用");
        return NO;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion: nil];
    return YES;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *resultImage = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    [self.pictureButton setImage: [resultImage imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]forState: UIControlStateNormal];
    [self.navigationController dismissViewControllerAnimated: YES completion: nil];
}

@end
