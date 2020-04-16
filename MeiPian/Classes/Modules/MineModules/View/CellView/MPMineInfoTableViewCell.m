//
//  MPMineInfoTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/16.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineInfoTableViewCell.h"

@implementation MPMineInfoTableViewCell

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
