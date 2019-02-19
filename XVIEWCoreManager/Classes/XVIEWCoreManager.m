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
NSString * const ComponentNetwork   = @"XVIEWNetworkManager";
/* 基础库 */
NSString * const ComponentPublic    = @"XVIEWPublicComponent";
/* 图片库 */
NSString * const ComponentImage     = @"XVIEWMultiImageManager";
/* 音频库 */
NSString * const ComponentAvido     = @"XVIEWAvdioManager";
/* 视频库 */
NSString * const ComponentVideo     = @"XVIEWVideoManager";
/* 扫码库 */
NSString * const ComponentScanCode  = @"XVIEWScanCodeManager";
/* QQ库 */
NSString * const ComponentQQ        = @"XVIEWTencentManager";
/* 微信库 */
NSString * const ComponentWechat    = @"XVIEWWeChatManager";
/* 微博库 */
NSString * const ComponentSina      = @"XVIEWWeiboManager";
/* 阿里库 */
NSString * const ComponentAli       = @"XVIEWAliManager";
/* 连连库 */
NSString * const ComponentLLpay     = @"XVIEWLLPayManager";
/* 定位库 */
NSString * const ComponentALocation = @"XVIEWLocationManager";
/* 导航库 */
NSString * const ComponentNavi      = @"XVIEWNaviManager";
/* 高德库 */
NSString * const ComponentAmap      = @"XVIEWAMapManager";
/* 友盟库 */
NSString * const ComponentUmeng     = @"XVIEWUmengManager";
/* 统计库 */
NSString * const ComponentAnaly     = @"XVIEWAnalyzeManager";
/* 推送库 */
NSString * const ComponentPush      = @"XVIEWPushManager";

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
        type = ComponentAnaly;
        break;
        default:
        break;
    }
    [[ZDRouter sharedRouter] performTarget:type withAction:@"registerApp:" andParam:dict];
}
    
- (BOOL) handleUrl:(NSURL *)url {
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
