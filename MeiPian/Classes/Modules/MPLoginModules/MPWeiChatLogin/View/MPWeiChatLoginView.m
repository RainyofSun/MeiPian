//
//  MPWeiChatLoginView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPWeiChatLoginView.h"

@interface MPWeiChatLoginView ()

@property (weak, nonatomic) IBOutlet UIButton *weiChatLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreLoginWayBtn;
@property (weak, nonatomic) IBOutlet YYLabel *protocolLab;

@end

@implementation MPWeiChatLoginView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 协议富文本
- (void)updateProtocolAttributeText:(NSAttributedString *)attributeProtocol {
    self.protocolLab.attributedText = attributeProtocol;
}

- (IBAction)touchLoginViewBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(touchWeiChatLoginViewBtn:) params:[NSNumber numberWithInteger:sender.tag]];
}

#pragma mark - private methods
- (void)setupUI {
    self.weiChatLoginBtn.layer.cornerRadius = 25.f;;
    self.weiChatLoginBtn.clipsToBounds = YES;
    self.weiChatLoginBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [self.phoneLoginBtn changeButtonImgTopAndTextBottom:5];
    [self.moreLoginWayBtn changeButtonImgTopAndTextBottom:5];
}

@end
