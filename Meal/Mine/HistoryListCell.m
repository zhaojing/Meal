//
//  HistoryListCell.m
//  Meal
//
//  Created by Wei Fan on 8/7/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import "HistoryListCell.h"

@interface HistoryListCell ()

@property (weak,nonatomic) IBOutlet UIImageView *cellImage;
@property (weak,nonatomic) IBOutlet UILabel *cellName;
@property (weak,nonatomic) IBOutlet UILabel *cellPrice;
@property (weak,nonatomic) IBOutlet UILabel *cellLocation;
@property (weak,nonatomic) IBOutlet UILabel *cellDate;

@end

@implementation HistoryListCell

+ (NSString *)identifierCell{
    return @"HistoryListCell";
}

- (void)configureViewModel: (HistoryListViewModel *)viewModel andIndex: (NSIndexPath *)index{
    self.cellImage.image = [viewModel getImageWithIndex: index];
    self.cellName.text = [viewModel getNameWithIndex: index];
    self.cellPrice.text = [viewModel getPriceWithIndex: index];
    self.cellLocation.text =[viewModel getLocationWithIndex: index];
    self.cellDate.text = [viewModel getDateWithIndex: index] ;
    
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.cellImage.image = nil;
    self.cellName.text = @"";
    self.cellPrice.text = @"";
    self.cellLocation.text = @"";
    self.cellDate.text = @"";}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
