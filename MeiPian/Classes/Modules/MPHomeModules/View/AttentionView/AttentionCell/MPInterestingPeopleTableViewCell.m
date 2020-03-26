//
//  MPInterestingPeopleTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPInterestingPeopleTableViewCell.h"

@implementation MPInterestingPeopleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
