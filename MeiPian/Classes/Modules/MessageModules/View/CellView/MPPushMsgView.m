//
//  MPPushMsgView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPPushMsgView.h"

@interface MPPushMsgView ()

@property (weak, nonatomic) IBOutlet UIImageView *msgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *beageImgView;
@property (weak, nonatomic) IBOutlet UILabel *msgTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *msgInfoLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *msgNumLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *msgNumLabW;

@end

@implementation MPPushMsgView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadPushMsgViewSource:(MPPushMessageModel *)modelSource {
    [self.msgImgView MPSetImageWithURL:modelSource.icon];
    [self.beageImgView MPSetImageWithURL:modelSource.bedge_icon];
    self.msgTitleLab.text = modelSource.title;
    self.msgInfoLab.text = modelSource.info;
    self.timeLab.text = modelSource.time;
    self.msgNumLab.text = modelSource.unread_count.stringValue;
    self.msgNumLabW.constant = modelSource.unreadNumW;
}

- (void)cellAlphaAnimation {
    self.msgImgView.alpha = self.beageImgView.alpha = 0.4;
    [UIView animateWithDuration:ALPHAANIMATIONTIME animations:^{
        self.msgImgView.alpha = self.beageImgView.alpha = 1;
    }];
}

#pragma mark - private methods
- (void)setupUI {
    self.msgNumLab.layer.cornerRadius = CGRectGetHeight(self.msgNumLab.bounds)/2;
    self.msgNumLab.clipsToBounds = YES;
}

@end
