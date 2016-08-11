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

- (void)configureViewModel:(HistoryListCellViewModel *)viewModel {
    self.cellImage.image = [viewModel getImage];
    self.cellName.text = [viewModel getName];
    self.cellPrice.text = [viewModel getPrice];
    self.cellLocation.text = [viewModel getLocation];
    self.cellDate.text = [viewModel getDate];
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
