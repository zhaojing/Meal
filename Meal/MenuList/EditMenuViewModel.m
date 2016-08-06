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

- (instancetype)initWithMenu: (Menu *)menu {
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

- (void)saveTheImage: (UIImage *)image
             andName: (NSString *)name
         andLocation: (NSString *)location
            andPrice: (NSString *)price
          andSuccess: (void(^)(NSString *successInfo))success
            andError:(void(^)(NSString* errorInfo))error {
    if ([self getTheType] == editType)
        [self saveEditTypeTheImage:image andName:name andLocation:location andPrice:price andSuccess:success andError:error];
    else
        [self saveAddTypeTheImage:image andName:name andLocation:location andPrice:price andSuccess:success andError:error];
}
- (Type )getTheType {
    if (self.menu) {
        return editType;
    }
    return addType;
}

- (NSString *)getTitleName {
    return [self getTheType] == editType ? @"编辑界面" : @"添加界面";
}

- (void)saveEditTypeTheImage: (UIImage *)image
                     andName: (NSString *)name
                 andLocation: (NSString *)location
                    andPrice: (NSString *)price
                  andSuccess: (void(^)(NSString *successInfo))success
                    andError: (void(^)(NSString* errorInfo))error {
    if(![self checkMenuModify: image andName: name andLocation: location andPrice: price])
        error(@"没有修改任何内容");
    else
        [[[MenuRequest alloc]init] modifyMenu:[[Menu alloc] initWithId:self.menu.menuId andName:name andprice:price andLocation:location andImage:image]] ? success(@"修改成功") :error(@"修改失败");
}

- (void)saveAddTypeTheImage: (UIImage *)image
                    andName: (NSString *)name
                andLocation: (NSString *)location
                   andPrice: (NSString *)price
                 andSuccess: (void(^)(NSString *successInfo))success
                   andError: (void(^)(NSString* errorInfo))error {
    [[[MenuRequest alloc]init] addMenu:[[Menu alloc] initWithId:[self getRandom] andName:name andprice:price andLocation:location andImage:image]] ? success(@"添加成功") : error(@"添加失败");
}

-(BOOL)checkMenuModify: (UIImage *)image
               andName: (NSString *)name
           andLocation: (NSString *)location
              andPrice: (NSString *)price {
    return [self.menu.image isEqual: image] && [self.menu.name isEqual: name] && [self.menu.location isEqual: location] && [self.menu.price isEqual: price] ? false : true;
}

- (NSString *)getRandom {
    NSString *interval = [NSString stringWithFormat: @"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    return [NSString stringWithFormat: @"%1.0f", [interval doubleValue]*100 + arc4random() % 100];
}

#pragma mark- getAlbumController

- (UIImagePickerController *)getAlbumController {
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]){
        return nil;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    return picker;
}

- (UIImagePickerController *)getImageController {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        return nil;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    return picker;
}

@end
