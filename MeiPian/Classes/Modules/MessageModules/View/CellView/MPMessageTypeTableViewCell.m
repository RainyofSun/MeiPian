//
//  MPMessageTypeTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMessageTypeTableViewCell.h"

@interface MPMessageTypeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *ZYDSBtn;
@property (weak, nonatomic) IBOutlet UIButton *PLBtn;
@property (weak, nonatomic) IBOutlet UIButton *FSBtn;
@property (weak, nonatomic) IBOutlet UIButton *SCZFBtn;

/** btnSource */
@property (nonatomic,strong) NSArray <UIButton *>*btnSource;

@end

@implementation MPMessageTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.btnSource = @[self.ZYDSBtn,self.PLBtn,self.FSBtn,self.SCZFBtn];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadMessageTypeCellSource:(NSArray<MPMessageTypeModel *> *)typeModelSource {
    WeakSelf;
    [typeModelSource enumerateObjectsUsingBlock:^(MPMessageTypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (idx) {
            case 0:
            {
                [weakSelf.ZYDSBtn setTitle:obj.title forState:UIControlStateNormal];
                [weakSelf.ZYDSBtn setTitleColor:MAIN_BLACK_COLOR forState:UIControlStateNormal];
                [weakSelf.ZYDSBtn setImageWithURL:[NSURL URLWithString:obj.icon] forState:UIControlStateNormal placeholder:nil options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                    [weakSelf.ZYDSBtn changeButtonImgTopAndTextBottom:8];
                }];
            }
                break;
            case 1:
            {
                [weakSelf.PLBtn setTitle:obj.title forState:UIControlStateNormal];
                [weakSelf.PLBtn setTitleColor:MAIN_BLACK_COLOR forState:UIControlStateNormal];
                [weakSelf.PLBtn setImageWithURL:[NSURL URLWithString:obj.icon] forState:UIControlStateNormal placeholder:nil options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                    [weakSelf.PLBtn changeButtonImgTopAndTextBottom:8];
                }];
            }
                break;
            case 2:
            {
                [weakSelf.FSBtn setTitle:obj.title forState:UIControlStateNormal];
                [weakSelf.FSBtn setTitleColor:MAIN_BLACK_COLOR forState:UIControlStateNormal];
                [weakSelf.FSBtn setImageWithURL:[NSURL URLWithString:obj.icon] forState:UIControlStateNormal placeholder:nil options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                    [weakSelf.FSBtn changeButtonImgTopAndTextBottom:8];
                }];
            }
                break;
            case 3:
            {
                [weakSelf.SCZFBtn setTitle:obj.title forState:UIControlStateNormal];
                [weakSelf.SCZFBtn setTitleColor:MAIN_BLACK_COLOR forState:UIControlStateNormal];
                [weakSelf.SCZFBtn setImageWithURL:[NSURL URLWithString:obj.icon] forState:UIControlStateNormal placeholder:nil options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                    [weakSelf.SCZFBtn changeButtonImgTopAndTextBottom:8];
                }];
            }
                break;
            default:
                break;
        }
    }];
}

- (void)cellAlphaAnimation {
    for (UIButton *btn in self.btnSource) {
        btn.alpha = 0.4;
        [UIView animateWithDuration:ALPHAANIMATIONTIME animations:^{
            btn.alpha = 1;
        }];
    }
}

- (IBAction)touchMessageTypeBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(selectedMessageType:) params:[NSNumber numberWithInteger:sender.tag]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
