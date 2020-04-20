//
//  MPMineInfoView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/20.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineInfoView.h"
#import "MPMineSliderBarView.h"

@interface MPMineInfoView ()

@property (weak, nonatomic) IBOutlet UIButton *userImgBtn;
@property (weak, nonatomic) IBOutlet UIButton *mineShareBtn;
@property (weak, nonatomic) IBOutlet UIButton *editInfoBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UIButton *openVipBtn;
@property (weak, nonatomic) IBOutlet UIButton *setSignBtn;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIButton *fanBtn;
@property (weak, nonatomic) IBOutlet UIButton *visitCountBtn;

/** sliderBarView */
@property (nonatomic,strong) MPMineSliderBarView *sliderBarView;
/** infoViewH */
@property (nonatomic,assign,readwrite) CGFloat infoViewH;
/** TopDistance */
@property (nonatomic,readwrite) CGFloat TopDistance;

@end

@implementation MPMineInfoView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.sliderBarView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.sliderBarView autoSetDimension:ALDimensionHeight toSize:50];
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

- (void)loadSliderBarSource:(NSArray<NSString *> *)sliderBarSource {
    [self.sliderBarView loadSliderBarTitleSource:sliderBarSource];
}

- (void)switchSliderbarSelectedItem:(NSNumber *)senderTag {
    [self.sliderBarView switchSliderBarSlectedItem:senderTag];
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

    self.sliderBarView = [[MPMineSliderBarView alloc] init];
    [self addSubview:self.sliderBarView];
    
    self.infoViewH = 270;
    self.TopDistance = self.infoViewH - 50;
}

@end
