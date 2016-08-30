//
//  YJNetManage.m
//  HXZ
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 pengf. All rights reserved.
//
#define TIMEOUT 30
#import "YJNetManage.h"
#import "AFNetWorking.h"
#import "MBProgressHUD.h"

@interface YJNetManage ()
@property (nonatomic,strong)MBProgressHUD * HUD;
@property (nonatomic,assign)NSInteger netStatus;
@end

@implementation YJNetManage
+ (instancetype)shareManage{
    static YJNetManage *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manage) {
            manage = [[YJNetManage alloc] init];
            [manage checkNetStatus];
        }
    });
    return manage;
}

- (void)showHUD:(BOOL)isShowHUD manage:(YJNetManage *)manage{
    if (isShowHUD) {
        manage.HUD = [[MBProgressHUD alloc] init];
        manage.HUD.labelText = @"加载中...";
        [[UIApplication sharedApplication].delegate.window addSubview:manage.HUD];
    }
}

#pragma mark -- 使用前封装，对请求成功时候作反应，更加简洁
- (void)GET:(NSString *)URLString paramater:(id)paramater showHUD:(BOOL)isShowHUD success:(success)success {
    //网络断开无需发送请求
    if (self.netStatus<1) return;
    [self showHUD:isShowHUD manage:self];
    [self getWithURLString:URLString parameters:paramater success:^(BOOL successCode, NSDictionary *dataDic) {
        if (success) {
            if (isShowHUD) {
                [self.HUD hide:YES];
            }
            success(YES,dataDic);
        }
    } failure:^(BOOL failCode, NSString *errorString) {
        if (isShowHUD) {
            [self.HUD hide:YES];
        }
        NSLog(@"\n=================\n%@\n==================\n",errorString);
    }];
}
- (void)POST:(NSString *)URLString paramater:(id)paramater showHUD:(BOOL)isShowHUD success:(success)success {
    //网络断开无需发送请求
    if (self.netStatus<1) return;
    [self showHUD:isShowHUD manage:self];
    [self postWithURLString:URLString parameters:paramater success:^(BOOL successCode, NSDictionary *dataDic) {
        if (success) {
            if (isShowHUD) {
                [self.HUD hide:YES];
            }
            success(YES,dataDic);
        }
    } failure:^(BOOL failCode, NSString *errorString) {
        if (isShowHUD) {
            [self.HUD hide:YES];
        }
        NSLog(@"\n=================\n%@\n==================\n",errorString);
    }];
}

//网络监测
- (void)checkNetStatus{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"www.baidu.com"]];
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSArray *array = @[@"未知网络",@"网络断开",@"移动数据",@"链接Wifi"];
        NSLog(@"状态 = %@",array[status + 1]);
        self.netStatus = status;
    }];
    [manager.reachabilityManager startMonitoring];
    
}


//基于AF的封装
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(success)success
                 failure:(failure)failure{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manage.requestSerializer.timeoutInterval = TIMEOUT;
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manage GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //返回结果数据
        if (success) {
            success(YES,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(NO,[NSString stringWithFormat:@"错误信息：\n=============================\n%@\n============================\n",error]);
        }
    }];
    
}
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(success)success
                  failure:(failure)failure{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manage.requestSerializer.timeoutInterval = TIMEOUT;
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manage POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(YES,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(NO,[NSString stringWithFormat:@"错误信息：\n=============================\n%@\n============================\n",error]);
        }
    }];

}

- (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(NetTypes)type
                     success:(success)success
                     failure:(failure)failure{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manage.requestSerializer.timeoutInterval = TIMEOUT;
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    switch (type) {
        case GetNetType:
        {
            [manage GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(YES,responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(NO,[NSString stringWithFormat:@"错误信息：\n=============================\n%@\n============================\n",error]);
                }
            }];
        }
            break;
        case PostNetType:
        {
            [manage POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(YES,responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(NO,[NSString stringWithFormat:@"错误信息：\n=============================\n%@\n============================\n",error]);
                }
            }];
        }
            break;
    }

}
- (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(YJNetManage *)uploadInfo
                    success:(success)success
                    failure:(failure)failure{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manage.requestSerializer.timeoutInterval = TIMEOUT;
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manage POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:uploadInfo.fileData name:uploadInfo.name fileName:uploadInfo.fileType mimeType:uploadInfo.fileType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(YES,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(NO,[NSString stringWithFormat:@"错误信息：\n=============================\n%@\n============================\n",error]);
        }

    }];

}


@end
