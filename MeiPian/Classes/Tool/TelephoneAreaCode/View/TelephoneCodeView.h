//
//  TelephoneCodeView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TelephoneCodeCellView : UITableViewCell

- (void)loadCodeCellSource:(NSArray *)cellSource;

@end

@protocol TelephoneCodeSelectedDelegate <NSObject>

/// 选择国家地区回调
- (void)didSelectedCountryArea:(NSString *)areaCode;

@end

@interface TelephoneCodeView : UIView

/** codeDelegate */
@property (nonatomic,weak) id<TelephoneCodeSelectedDelegate> codeDelegate;
/** isSearchActive */
@property (nonatomic,assign) BOOL isSearchActive;

/// 刷新数据源
- (void)loadCodeSources:(NSArray <NSArray *>*)codeSource;
/// sectine数据
- (void)loadSectionTitleSource:(NSArray <NSString *>*)sectionTitleSource;
/// 添加searchView
- (void)addHeaderSearchView:(UISearchBar *)searchBar;

@end

NS_ASSUME_NONNULL_END
