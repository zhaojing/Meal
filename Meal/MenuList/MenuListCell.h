//
//  MenuListCell.h
//  Meal
//
//  Created by JingZhao on 8/5/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuListCellViewModel.h"

@interface MenuListCell : UITableViewCell

+ (NSString *)identifierCell;

- (void)configureViewModel: (MenuListCellViewModel *)viewModel;

@end
