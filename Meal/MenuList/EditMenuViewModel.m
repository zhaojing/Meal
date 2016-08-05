//
//  EditMenuViewModel.m
//  Meal
//
//  Created by Lvju Wang on 8/5/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "EditMenuViewModel.h"

@interface EditMenuViewModel ()

@property (strong, nonatomic)Menu *menu;

@end

@implementation EditMenuViewModel

-(instancetype)initWithMenu: (Menu *)menu {
    self = [super init];
    if (self) {
        self.menu = menu;
        self.name = menu.name;
        self.image = menu.image;
        self.location = menu.location;
        self.price = menu.price;
    }
    return self;
}

-(UIImagePickerController *)getAlbumController {
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]){
        NSLog(@"相册不可用");
        return nil;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    return picker;
}

-(UIImagePickerController *)getImageController {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        NSLog(@"相册不可用");
        return nil;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    return picker;
}

@end
