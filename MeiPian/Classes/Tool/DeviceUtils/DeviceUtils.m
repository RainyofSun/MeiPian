//
//  DeviceUtils.m
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/27.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import "DeviceUtils.h"
#import <AdSupport/ASIdentifierManager.h>
#import <CoreTelephony/CoreTelephonyDefines.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>

extern NSString* CTSIMSupportCopyMobileSubscriberIdentity(void);
extern NSString* CTSettingCopyMyPhoneNumber(void);

@implementation DeviceUtils

#pragma mark - About App Config Info Method
/*获取当前App的版本号信息*/
+ (NSString *)getAppVersion {
    NSBundle *currentBundle = [NSBundle mainBundle];
    NSDictionary *infoDictionary = [currentBundle infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

/*获取当前App的build版本号信息*/
+ (NSString *)getAppBuildVersion {
    NSBundle *currentBundle = [NSBundle mainBundle];
    NSDictionary *infoDictionary = [currentBundle infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

/*获取当前App的包名信息*/
+ (NSString *)getAppBundleId {
    NSBundle *currentBundle = [NSBundle mainBundle];
    NSDictionary *infoDictionary = [currentBundle infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleIdentifier"];
}

/*获取当前App的名称信息*/
+ (NSString *)getAppDisplayName {
    NSBundle *currentBundle = [NSBundle mainBundle];
    NSDictionary *infoDictionary = [currentBundle infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

/*获取IDFA*/
- (NSString *)getDeviceIDFAValue {
    ASIdentifierManager *object = nil;
    object = [ASIdentifierManager sharedManager];
    return [[object advertisingIdentifier] UUIDString];
}

#pragma mark - About Device Config Info Method
/*获取当前设备的IMSI值*/
+ (NSString *)getDeviceIMSIValue {
    return nil;
}

/*获取当前设备的IMEI值*/
+ (NSString *)getDeviceIMEIValue {
    return CTSIMSupportCopyMobileSubscriberIdentity();
}

/*本机电话号码*/
+ (NSString*)getPhoneCodeByCT {
    return CTSettingCopyMyPhoneNumber();
}

/*获取当前设备的MacId值*/
+ (NSString *)getDeviceMacIdValue {
    return nil;
}

/*获取当前设备的通讯运营商名称*/
+ (NSString *)getDeviceCarrierName {
    CTTelephonyNetworkInfo *info = [CTTelephonyNetworkInfo new];
    CTCarrier *carrier = [info serviceSubscriberCellularProviders];
    return [carrier carrierName];
}

/*获取当前设备的网络通讯名称值*/
+ (NSString *)getDeviceNetworkName {
    /*
     CTRadioAccessTechnologyGPRS             //介于2G和3G之间(2.5G)
     CTRadioAccessTechnologyEdge             //GPRS到第三代移动通信的过渡(2.75G)
     CTRadioAccessTechnologyWCDMA
     CTRadioAccessTechnologyHSDPA            //亦称为3.5G(3?G)
     CTRadioAccessTechnologyHSUPA            //3G到4G的过度技术
     CTRadioAccessTechnologyCDMA1x           //3G
     CTRadioAccessTechnologyCDMAEVDORev0     //3G标准
     CTRadioAccessTechnologyCDMAEVDORevA
     CTRadioAccessTechnologyCDMAEVDORevB
     CTRadioAccessTechnologyeHRPD            //电信一种3G到4G的演进技术(3.75G)
     CTRadioAccessTechnologyLTE              //接近4G
     */
    CTTelephonyNetworkInfo *info = [CTTelephonyNetworkInfo new];
    return [info currentRadioAccessTechnology];
}

/*获取当前设备的横向最大值*/
+ (NSNumber *)getDeviceXMaxValue {
    CGFloat xoffset = CGRectZero.origin.x;
    xoffset = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    return [NSNumber numberWithFloat:xoffset];
}

/*获取当前设备的纵向最大值*/
+ (NSNumber *)getDeviceYMaxValue {
    CGFloat yoffset = CGRectZero.origin.x;
    yoffset = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    return [NSNumber numberWithFloat:yoffset];
}

/*获取当前设备的横向分辨率值*/
+ (NSNumber *)getDeviceXResolution {
    CGFloat width = CGRectZero.size.width;
    CGFloat scale = [[UIScreen mainScreen] scale];
    width = [[[self class] getDeviceXMaxValue] floatValue];
    return [NSNumber numberWithFloat:(width * scale)];
}

/*获取当前设备的纵向分辨率值*/
+ (NSNumber *)getDeviceYResolution {
    CGFloat height = CGRectZero.size.height;
    CGFloat scale = [[UIScreen mainScreen] scale];
    height = [[[self class] getDeviceYMaxValue] floatValue];
    return [NSNumber numberWithFloat:(height * scale)];
}

/*获取当前设备的型号名称*/
+ (NSString *)getDeviceModel {
    NSString *platform = nil;
    struct utsname systemInfo;
    uname(&systemInfo);
    platform = [NSString stringWithCString:systemInfo.machine
                                  encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@",platform];
}

/*获取当前设备的操作系统名称*/
+ (NSString *)getDeviceOSName {
    return @"ios";
}

/*获取当前设备的操作系统版本号*/
+ (NSString *)getDeviceOSVersion {
    return [[UIDevice currentDevice] systemVersion];
}

/*获取当前设备的唯一编号*/
+ (NSString *)getDeviceTerminalId {
    UIDevice *device = [UIDevice currentDevice];
    NSString *package = [[self class] getAppBundleId];
    NSString *vendor = [[device identifierForVendor] UUIDString];
    return [NSString stringWithFormat:@"%@%@",package,vendor];
}

/*获取设备已安装的app信息列表*/
+ (NSArray *)getDeviceInstalledAppInformation {
    id space = [NSClassFromString(@"LSApplicationWorkspace") performSelector:@selector(defaultWorkspace)];
    NSArray *plugins = [space performSelector:@selector(installedPlugins)];
    NSMutableSet *list = [[NSMutableSet alloc] init];
    for (id plugin in plugins) {
        id bundle = [plugin performSelector:@selector(containingBundle)];
        if (bundle)
            [list addObject:bundle];
    }
    NSMutableArray * infoList = [NSMutableArray array];
    NSString *itemName = nil;
    int a = 1;
    for (id plugin in list) {
        NSLog(@"🐒 %d--",a);
        a++;
        NSLog(@"bundleIdentifier =%@", [plugin performSelector:@selector(bundleIdentifier)]);//bundleID
        
        NSLog(@"applicationDSID =%@", [plugin performSelector:@selector(applicationDSID)]);
        NSLog(@"applicationIdentifier =%@", [plugin performSelector:@selector(applicationIdentifier)]);
        NSLog(@"applicationType =%@", [plugin performSelector:@selector(applicationType)]);
        NSLog(@"dynamicDiskUsage =%@", [plugin performSelector:@selector(dynamicDiskUsage)]);

        NSLog(@"itemID =%@", [plugin performSelector:@selector(itemID)]);
        NSLog(@"itemName =%@", [plugin performSelector:@selector(itemName)]);
        NSLog(@"minimumSystemVersion =%@", [plugin performSelector:@selector(minimumSystemVersion)]);
        
        NSLog(@"requiredDeviceCapabilities =%@", [plugin performSelector:@selector(requiredDeviceCapabilities)]);
        NSLog(@"sdkVersion =%@", [plugin performSelector:@selector(sdkVersion)]);
        NSLog(@"shortVersionString =%@", [plugin performSelector:@selector(shortVersionString)]);
        
        NSLog(@"sourceAppIdentifier =%@", [plugin performSelector:@selector(sourceAppIdentifier)]);
        NSLog(@"staticDiskUsage =%@", [plugin performSelector:@selector(staticDiskUsage)]);
        NSLog(@"teamID =%@", [plugin performSelector:@selector(teamID)]);
        NSLog(@"vendorName =%@", [plugin performSelector:@selector(vendorName)]);
        itemName = [plugin performSelector:@selector(itemName)];
        if (itemName.length) {
            [infoList addObject:@{[NSNumber numberWithInt:a]:itemName}];
        }
    }
    return [infoList copy];
}

+ (NSNumber *)bootTime {
    NSProcessInfo *pi = [NSProcessInfo processInfo];
    unsigned long ul_time = pi.systemUptime;
    unsigned long ul_bootTime = [[self getCurrentTimeMills] longValue] - ul_time;
    NSNumber *numberTime = [NSNumber numberWithLong:ul_bootTime];
    return numberTime;
}

#pragma mark - private method
+ (NSNumber *)getCurrentTimeMills {
    NSDate *date = [NSDate date];
    NSTimeInterval time_interval = [date timeIntervalSince1970];
    NSNumber *numeber = [NSNumber numberWithLong:time_interval];
    return numeber;
}

@end
