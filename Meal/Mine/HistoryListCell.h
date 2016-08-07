//
//  HistoryListCell.h
//  Meal
//
//  Created by Wei Fan on 8/7/16.
//  Copyright © 2016 JingZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryListCellViewModel.h"

@interface HistoryListCell : UITableViewCell

+(NSString *)identifierCell;
-(void)configureViewModel:(HistoryListCellViewModel *)viewModel;

@end
