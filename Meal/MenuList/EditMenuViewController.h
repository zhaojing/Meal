//
//  EditMenuViewController.h
//  Meal
//
//  Created by Lvju
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditMenuViewModel.h"

@interface EditMenuViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

-(void)configure:(EditMenuViewModel *)viewModel;

@end
