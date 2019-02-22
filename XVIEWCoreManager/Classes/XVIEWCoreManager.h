//
//  XVIEWCoreManager.h
//  XVIEWCoreManager
//
//  Created by zd on 2019/2/18.
//  Copyright © 2019 zd. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 网络库 */
extern NSString * const ComponentNetwork;
/* 基础库 */
extern NSString * const ComponentPublic;
/* 图片库 */
extern NSString * const ComponentImage;
/* 音频库 */
extern NSString * const ComponentAvido;
/* 视频库 */
extern NSString * const ComponentVideo;
/* 扫码库 */
extern NSString * const ComponentScanCode;
/* QQ库 */
extern NSString * const ComponentQQ;
/* 微信库 */
extern NSString * const ComponentWechat;
/* 微博库 */
extern NSString * const ComponentSina;
/* 阿里库 */
extern NSString * const ComponentAli;
/* 连连库 */
extern NSString * const ComponentLLpay;
/* 定位库 */
extern NSString * const ComponentALocation;
/* 导航库 */
extern NSString * const ComponentNavi;
/* 高德库 */
extern NSString * const ComponentAmap;
/* 友盟库 */
extern NSString * const ComponentUmeng;
/* 统计库 */
extern NSString * const ComponentAnaly;
/* 推送库 */
extern NSString * const ComponentPush;

@interface XVIEWCoreManager : NSObject

+ (instancetype) sharedXVIEWCoreManager;
    
- (void) initPlatformWithDict:(NSDictionary *)dict;
    
- (BOOL) handleUrl:(NSDictionary *)dict;
    
- (void) registerDevice:(NSDictionary *)dict;
    
- (void) handleRemoteNotification:(NSDictionary *)dict;
  
- (void) callNativeXView:(NSDictionary *)dict;
    
@end
