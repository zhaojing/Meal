//
//  HistoryListCell.m
//  Meal
//
//  Created by Wei Fan on 8/7/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "HistoryListCell.h"

@interface HistoryListCell ()

@property (weak,nonatomic) IBOutlet UIImageView *image;
@property (weak,nonatomic) IBOutlet UILabel *name;
@property (weak,nonatomic) IBOutlet UILabel *price;
@property (weak,nonatomic) IBOutlet UILabel *location;
@property (weak,nonatomic) IBOutlet UILabel *date;

@end

@implementation HistoryListCell

+ (NSString *)identifierCell{
    return @"HistoryListCell";
}

- (void)configureViewModel: (HistoryListViewModel *)viewModel andIndex: (NSIndexPath *)index{
    self.image.image = [viewModel getImageWithIndex: index];
    self.name.text = [viewModel getNameWithIndex: index];
    self.price.text = [viewModel getPriceWithIndex: index];
    self.location.text =[viewModel getLocationWithIndex: index];
    self.date.text = [viewModel getDateWithIndex: index] ;
    
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.image.image = nil;
    self.name.text = @"";
    self.price.text = @"";
    self.location.text = @"";
    self.date.text = @"";}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
