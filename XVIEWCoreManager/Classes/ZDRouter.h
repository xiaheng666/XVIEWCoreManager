//
//  ZDRouter.h
//  XVIEWPodsApp
//
//  Created by yyj on 2018/6/27.
//  Copyright © 2018年 Lianghao An. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//路由处理
@interface ZDRouter : NSObject

+(instancetype)sharedRouter;


- (id)performTarget:(NSString *)targetName withAction:(NSString *)actionName;

- (id)performTarget:(NSString *)targetName withAction:(NSString *)actionName andParam:(NSDictionary *)param;

- (id)performTarget:(NSString *)targetName withAction:(NSString *)actionName withCallBack:(void(^)(NSDictionary *dict))callback;

- (id)performTarget:(NSString *)targetName withAction:(NSString *)actionName andParam:(NSDictionary *)param withCallBack:(void(^)(NSDictionary *dict))callback;

- (id)performTarget:(NSString *)targetName withAction:(NSString *)actionName andVC:(UIViewController *)vc withCallBack:(void(^)(NSDictionary *dict))callback;

- (id)performTarget:(NSString *)targetName withAction:(NSString *)actionName andParam:(NSDictionary *)param andVC:(UIViewController *)vc withCallBack:(void(^)(NSDictionary *dict))callback;

@end
