//
//  EditMenuViewModel.h
//  Meal
//
//  Created by Lvju Wang on 8/5/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Menu.h"

typedef enum : NSUInteger {
    editType,
    addType
} Type;

@interface EditMenuViewModel : NSObject

@property (assign, nonatomic)NSString *menuId;
@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)NSString *location;
@property (strong, nonatomic)NSString *price;
@property (strong, nonatomic)UIImage *image;
@property (strong, nonatomic)Menu *menu;

- (instancetype)initWithMenu: (Menu *)menu;
- (UIImagePickerController *)getAlbumController;
- (UIImagePickerController *)getImageController;
- (Type )getTheType;
- (NSString *)getTitleName;
- (void )saveTheImage: (UIImage *)image
              andName: (NSString *)name
          andLocation: (NSString *)location
             andPrice: (NSString *)price
           andSuccess: (void(^)(NSString *successInfo))success
             andError: (void(^)(NSString* errorInfo))error;

@end
