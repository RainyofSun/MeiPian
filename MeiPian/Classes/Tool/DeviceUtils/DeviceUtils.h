//
//  DeviceUtils.h
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/27.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceUtils : NSObject

#pragma mark - About App Config Info Method
/**
 *  获取当前App的版本号信息
 */
+ (NSString *)getAppVersion;

/**
 *  获取当前App的build版本号信息
 */
+ (NSString *)getAppBuildVersion;

/**
 *  获取当前App的包名信息
 */
+ (NSString *)getAppBundleId;

/**
 *  获取当前App的名称信息
 */
+ (NSString *)getAppDisplayName;

/**
 * 获取IDFA
 */
- (NSString *)getDeviceIDFAValue;

/**
 *  获取当前设备的IMSI值
 */
+ (NSString *)getDeviceIMSIValue;

/**
 * 获取本机电话号码
 */
+ (NSString*)getPhoneCodeByCT;

/**
 *  获取当前设备的IMEI值
 */
+ (NSString *)getDeviceIMEIValue;

/**
 *  获取当前设备的MacId值
 */
+ (NSString *)getDeviceMacIdValue;

/**
 *  获取当前设备的通讯运营商名称 12.0以上
 */
+ (NSString *)getDeviceCarrierName;

/**
 *  获取当前设备的网络通讯名称值
 */
+ (NSString *)getDeviceNetworkName;

/**
 *  获取当前设备的横向最大值
 */
+ (NSNumber *)getDeviceXMaxValue;

/**
 *  获取当前设备的纵向最大值
 */
+ (NSNumber *)getDeviceYMaxValue;

/**
 *  获取当前设备的横向分辨率值
 */
+ (NSNumber *)getDeviceXResolution;

/**
 *  获取当前设备的纵向分辨率值
 */
+ (NSNumber *)getDeviceYResolution;

/**
 *  获取当前设备的型号名称
 */
+ (NSString *)getDeviceModel;

/**
 *  获取当前设备的操作系统名称
 */
+ (NSString *)getDeviceOSName;

/**
 *  获取当前设备的操作系统版本号
 */
+ (NSString *)getDeviceOSVersion;

/**
 *  获取当前设备的唯一编号
 */
+ (NSString *)getDeviceTerminalId;

/**
 * 获取设备已安装的app信息列表
 */
+ (NSArray *)getDeviceInstalledAppInformation;

/**
 * 获取程序启动时间
 */
+ (NSNumber *)bootTime;

@end

NS_ASSUME_NONNULL_END
