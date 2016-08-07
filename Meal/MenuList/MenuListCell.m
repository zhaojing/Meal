//
//  MenuListCell.m
//  Meal
//
//  Created by JingZhao on 8/5/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "MenuListCell.h"

@interface MenuListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *location;

@end

@implementation MenuListCell

+ (NSString *)identifierCell {
    return @"MenuListCell";
}

- (void)configureViewModel:  (MenuListCellViewModel *)viewModel {
    self.image.image = [viewModel getImage];
    self.name.text = [viewModel getName];
    self.price.text = [viewModel getPrice];
    self.location.text = [viewModel getLocation];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.image.image = nil;
    self.name.text = @"";
    self.price.text = @"";
    self.location.text = @"";
}

- (void)setSelected: (BOOL)selected animated: (BOOL)animated {
    [super setSelected: selected animated: animated];
}

@end
