//
//  EditMenuViewModel.m
//  Meal
//
//  Created by Lvju Wang on 8/5/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "EditMenuViewModel.h"
#import "SVProgressHUD.h"
#import "MenuRequest.h"

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

-(BOOL )saveTheImage:(UIImage *)image
            andName:(NSString *)name
        andLocation:(NSString *)location
           andPrice:(NSString *)price {
    MenuRequest *menuRequest = [[MenuRequest alloc]init];
    if (self.menu.menuId)
       return [menuRequest modifyMenu:[[Menu alloc] initWithId:self.menu.menuId andName:name andprice:price andLocation:location andImage:image]];
    else
      return [menuRequest addMenu:[[Menu alloc] initWithId:[self getRandom] andName:name andprice:price andLocation:location andImage:image]];
}

-(NSString *)getRandom {
    NSString *interval = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    return [NSString stringWithFormat:@"%1.0f",[interval doubleValue]*100 + arc4random() % 100];
}

#pragma mark- getAlbumController

-(UIImagePickerController *)getAlbumController {
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]){
        return nil;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    return picker;
}

-(UIImagePickerController *)getImageController {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        return nil;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    return picker;
}

@end
