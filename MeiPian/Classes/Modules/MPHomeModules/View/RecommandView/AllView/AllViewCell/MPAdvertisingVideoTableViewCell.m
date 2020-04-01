//
//  MPAdvertisingVideoTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPAdvertisingVideoTableViewCell.h"

@interface MPAdvertisingVideoTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *atricleTitleLab;
@property (weak, nonatomic) IBOutlet UIView *adContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *adLogoImg;
@property (weak, nonatomic) IBOutlet UILabel *adNameLab;
@property (weak, nonatomic) IBOutlet UILabel *lookLab;

@end

@implementation MPAdvertisingVideoTableViewCell

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
