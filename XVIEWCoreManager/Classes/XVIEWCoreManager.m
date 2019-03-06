//
//  XVIEWCoreManager.m
//  XVIEWCoreManager
//
//  Created by zd on 2019/2/18.
//  Copyright © 2019 zd. All rights reserved.
//

#import "XVIEWCoreManager.h"
#import "ZDRouter.h"
#import "Component.h"

typedef enum : NSUInteger {
    PlatFormWeChat,
    PlatFormTencent,
    PlatFormWebo,
    PlatFormAli,
    PlatFormAmap,
    PlatFormUmeng,
    PlatFormUAnalyze,
    PlatFormUPush
} Platform;

/* 网络库 */
NSString * const ComponentNetwork   = @"ComponentNetWork";
/* 基础库 */
NSString * const ComponentPublic    = @"ComponentPublic";
/* 图片库 */
NSString * const ComponentImage     = @"ComponentMedia";
/* 音频库 */
NSString * const ComponentAvido     = @"ComponentAvdio";
/* 视频库 */
NSString * const ComponentVideo     = @"ComponentVideo";
/* 扫码库 */
NSString * const ComponentScanCode  = @"ComponentQR";
/* QQ库 */
NSString * const ComponentQQ        = @"ComponentQQ";
/* 微信库 */
NSString * const ComponentWechat    = @"ComponentWeChat";
/* 微博库 */
NSString * const ComponentSina      = @"ComponentSina";
/* 阿里库 */
NSString * const ComponentAli       = @"ComponentAliPay";
/* 连连库 */
NSString * const ComponentLLpay     = @"ComponentLLPay";
/* 定位库 */
NSString * const ComponentALocation = @"ComponentALocation";
/* 导航库 */
NSString * const ComponentNavi      = @"ComponentANavi";
/* 高德库 */
NSString * const ComponentAmap      = @"ComponentAmap";
/* 友盟库 */
NSString * const ComponentUmeng     = @"ComponentUmeng";
/* 统计库 */
NSString * const ComponentAnaly     = @"ComponentAnalytics";
/* 推送库 */
NSString * const ComponentPush      = @"ComponentPush";

@implementation XVIEWCoreManager

+ (instancetype) sharedXVIEWCoreManager {
    static XVIEWCoreManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XVIEWCoreManager alloc]init];
    });
    return manager;
}
    
- (void) initPlatformWithDict:(NSDictionary *)dict {
    NSString *type = nil;
    NSInteger platform = [dict[@"platform"] integerValue];
    switch (platform) {
        case PlatFormWeChat:
            type = ComponentWechat;
            break;
        case PlatFormTencent:
            type = ComponentQQ;
            break;
        case PlatFormWebo:
            type = ComponentSina;
            break;
        case PlatFormAli:
            type = ComponentAli;
            break;
        case PlatFormAmap:
            type = ComponentAmap;
            break;
        case PlatFormUmeng:
            type = ComponentUmeng;
            break;
        case PlatFormUPush:
            type = ComponentPush;
            break;
        default:
            break;
    }
    [[ZDRouter sharedRouter] performTarget:type withAction:@"registerApp:" andParam:dict];
}
    
- (BOOL) handleUrl:(NSDictionary *)dict {
    NSURL *url = dict[@"url"];
    NSString *str = [NSString string];
    if ([url.host isEqualToString:@"safepay"] || [url.host isEqualToString:@"platformapi"]) {
        str = ComponentAli;
    }
    else if ([url.absoluteString hasPrefix:@"tencent"]) {
        str = ComponentQQ;
    }
    else if ([url.absoluteString hasPrefix:@"wx"]) {
        str = ComponentWechat;
    }
    else if ([url.absoluteString hasPrefix:@"wb"]) {
        str = ComponentSina;
    }else {
        return NO;
    }
    return [[ZDRouter sharedRouter] performTarget:str withAction:@"handleUrl:" andParam:@{@"url":url}];
}
    
- (void)registerDevice:(NSDictionary *)dict {
    [[ZDRouter sharedRouter] performTarget:ComponentPush withAction:@"registerDevice:" andParam:dict];
}
    
- (void)handleRemoteNotification:(NSDictionary *)dict {
    [[ZDRouter sharedRouter] performTarget:ComponentPush withAction:@"handleRemoteNotification:" andParam:dict];
}

- (void)callNativeXView:(NSDictionary *)dict {
    NSString *target = dict[@"target"];
    NSString *action = dict[@"action"];
    NSDictionary *param = dict[@"param"];
    void (^myCallback)(NSDictionary *dict) = dict[@"callback"];
    [[ZDRouter sharedRouter] performTarget:target withAction:ACTION(target, action) andParam:param andVC:dict[@"vc"] withCallBack:^(NSDictionary *dict) {
        myCallback(dict);
    }];
}
    
@end
