//
//  ZDRouter.m
//  XVIEWPodsApp
//
//  Created by yyj on 2018/6/27.
//  Copyright © 2018年 Lianghao An. All rights reserved.
//

#import "ZDRouter.h"
#import "Component.h"
#import <objc/message.h>
#import <objc/runtime.h>

@interface ZDRouter ()
    
@end

@implementation ZDRouter

+(instancetype)sharedRouter{
    static ZDRouter *router;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[ZDRouter alloc]init];
    });
    return router;
}

- (id)performTarget:(NSString *)targetName withAction:(NSString *)actionName withCallBack:(void(^)(NSDictionary *dict))callback{
    return [self performTarget:targetName withAction:actionName andParam:nil  andVC:nil withCallBack:callback];
}

- (id)performTarget:(NSString *)targetName withAction:(NSString *)actionName{
    return [self performTarget:targetName withAction:actionName andParam:nil  andVC:nil withCallBack:nil];
}

- (id)performTarget:(NSString *)targetName withAction:(NSString *)actionName andParam:(NSDictionary *)param{
    return [self performTarget:targetName withAction:actionName andParam:param andVC:nil withCallBack:nil];
}

- (id)performTarget:(NSString *)targetName withAction:(NSString *)actionName andVC:(UIViewController *)vc withCallBack:(void(^)(NSDictionary *dict))callback {
    return [self performTarget:targetName withAction:actionName andParam:nil andVC:vc withCallBack:callback];
}

- (id)performTarget:(NSString *)targetName withAction:(NSString *)actionName andParam:(NSDictionary *)param withCallBack:(void(^)(NSDictionary *dict))callback {
    return [self performTarget:targetName withAction:actionName andParam:param andVC:nil withCallBack:callback];
}

- (id)performTarget:(NSString *)targetName withAction:(NSString *)actionName andParam:(NSDictionary *)param andVC:(UIViewController *)vc withCallBack:(void(^)(NSDictionary *dict))callback{
    NSString *target = Name(targetName);
    Class targetClass = NSClassFromString(TARGET(targetName));
    if (targetClass) {
        SEL managerSel = NSSelectorFromString(SharedName(target));
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSObject *object = [targetClass performSelector:managerSel];
        #pragma clang diagnostic pop
        SEL sel = NSSelectorFromString(actionName);
        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        if (callback) [para setObject:callback          forKey:@"callback"];
        if (param)    [para setObject:param             forKey:@"data"];
        if (vc)       [para setObject:vc                forKey:@"currentVC"];
        if (object && [object respondsToSelector:sel]){
            return [self performSafeObject:object withSel:sel andParam:[para copy]];
        }else{
            return nil;
        }
    } else {
        return nil;
    }
}

- (id)performSafeObject:(NSObject *)object withSel:(SEL)sel andParam:(NSDictionary *)param{
    NSMethodSignature *methodSign = [object methodSignatureForSelector:sel];
    if (methodSign == nil){
        return nil;
    }
    const char *returnType = [methodSign methodReturnType];
    if (strcmp(returnType, @encode(void))==0){
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSign];
        [invocation setTarget:object];
        [invocation setSelector:sel];
        [invocation setArgument:&param atIndex:2];
        [invocation invoke];
        return nil;
    }
    else if (strcmp(returnType, @encode(NSUInteger)) == 0){
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSign];
        [invocation setTarget:object];
        [invocation setSelector:sel];
        [invocation setArgument:&param atIndex:2];
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    else if (strcmp(returnType, @encode(float)) == 0){
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSign];
        [invocation setTarget:object];
        [invocation setSelector:sel];
        [invocation setArgument:&param atIndex:2];
        [invocation invoke];
        float result = 0.0f;
        [invocation getReturnValue:&result];
        return @(result);
    }
    else if (strcmp(returnType, @encode(BOOL)) == 0){
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSign];
        [invocation setTarget:object];
        [invocation setSelector:sel];
        [invocation setArgument:&param atIndex:2];
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    else if (strcmp(returnType, @encode(NSInteger)) == 0){
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSign];
        [invocation setTarget:object];
        [invocation setSelector:sel];
        [invocation setArgument:&param atIndex:2];
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    else if (strcmp(returnType, @encode(id)) == 0){
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSign];
        [invocation setTarget:object];
        [invocation setSelector:sel];
        [invocation setArgument:&param atIndex:2];
        [invocation invoke];
        id dic = nil;
        [invocation getReturnValue:&dic];
        return dic;
    }
//    else if (strcmp(returnType, "@") == 0) {
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSign];
//        [invocation setTarget:object];
//        [invocation setSelector:sel];
//        [invocation setArgument:&param atIndex:2];
//        [invocation invoke];
//        NSDictionary *dict = nil;
//        [invocation getReturnValue:&dict];
//        return dict;
//    }
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [object performSelector:sel withObject:object withObject:param];
    #pragma clang diagnostic pop
}


@end
