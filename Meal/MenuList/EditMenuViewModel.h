//
//  EditMenuViewModel.h
//  Meal
//
//  Created by Lvju Wang on 8/5/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Menu.h"

@interface EditMenuViewModel : NSObject

@property (assign, nonatomic)NSInteger menuId;
@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)NSString *location;
@property (strong, nonatomic)NSString *price;
@property (strong, nonatomic)UIImage *image;

-(instancetype)initWithMenu: (Menu *)menu;
-(UIImagePickerController *)getAlbumController;
-(UIImagePickerController *)getImageController;
-(BOOL )saveTheImage:(UIImage *)image
             andName:(NSString *)name
         andLocation:(NSString *)location
            andPrice:(NSString *)price;

@end
