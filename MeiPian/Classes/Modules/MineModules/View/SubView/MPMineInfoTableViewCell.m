//
//  MPMineInfoTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/16.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineInfoTableViewCell.h"

@interface MPMineInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *userImgBtn;
@property (weak, nonatomic) IBOutlet UIButton *mineShareBtn;
@property (weak, nonatomic) IBOutlet UIButton *editInfoBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UIButton *openVipBtn;
@property (weak, nonatomic) IBOutlet UIButton *setSignBtn;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIButton *fanBtn;
@property (weak, nonatomic) IBOutlet UIButton *visitCountBtn;

@end

@implementation MPMineInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadMineInfoSource:(MPMineInfoModel *)infoModel {
    [self.userImgBtn setImageWithURL:[NSURL URLWithString:infoModel.head_img_url] forState:UIControlStateNormal options:YYWebImageOptionSetImageWithFadeAnimation];
    self.userNameLab.text = infoModel.nickname;
    [self.attentionBtn setAttributedTitle:infoModel.attentionStr forState:UIControlStateNormal];
    [self.fanBtn setAttributedTitle:infoModel.fansStr forState:UIControlStateNormal];
    [self.visitCountBtn setAttributedTitle:infoModel.visitStr forState:UIControlStateNormal];
}

- (IBAction)touchUserImgBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(replaceUserImg)];
}

- (IBAction)touchMineShareBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(shareMineArticle)];
}

- (IBAction)touchEditInfoBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(editMineInfo)];
}

- (IBAction)touchOpenVipBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(openVIP)];
}

- (IBAction)touchSetSignBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(editMineInfo)];
}

- (IBAction)touchAttentionBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(attentionMinePeople)];
}

- (IBAction)touchFanBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(myFans)];
}

- (IBAction)touchVisitCountBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(readMyArticleCount)];
}

#pragma mark - private methods
- (void)setupUI {
    self.userImgBtn.layer.cornerRadius = CGRectGetWidth(self.userImgBtn.bounds)/2;
    self.userImgBtn.clipsToBounds = YES;
    
    self.editInfoBtn.layer.cornerRadius = CGRectGetHeight(self.editInfoBtn.bounds)/2;
    self.editInfoBtn.clipsToBounds = YES;
    self.editInfoBtn.layer.borderColor = HexColor(0xEEEEEE).CGColor;
    self.editInfoBtn.layer.borderWidth = 1.f;
    
    self.mineShareBtn.layer.cornerRadius = CGRectGetWidth(self.mineShareBtn.bounds)/2;
    self.mineShareBtn.clipsToBounds = YES;
    self.mineShareBtn.layer.borderColor = HexColor(0xEEEEEE).CGColor;
    self.mineShareBtn.layer.borderWidth = 1.f;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
