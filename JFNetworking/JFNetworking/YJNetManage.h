//
//  YJNetManage.h
//  HXZ
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 pengf. All rights reserved.
//
#import <Foundation/Foundation.h>
typedef void(^success)(BOOL successCode,NSDictionary *dataDic);
typedef void(^failure)(BOOL failCode,NSString *errorString);
typedef NS_ENUM(NSUInteger,NetTypes) {
    GetNetType = 0,
    PostNetType = 1,
};

@interface YJNetManage : NSObject
@property (nonatomic,weak) success success;
@property (nonatomic,weak) failure failure;
/**
 *上传到服务器之后文件的名字，格式
 */
@property (nonatomic,strong)NSData *fileData;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *fileName;
@property (nonatomic,copy)NSString *fileType;


+ (instancetype)shareManage;

//get
- (void)GET:(NSString *)URLString paramater:(id)paramater showHUD:(BOOL)isShowHUD success:(success)success ;
//post
- (void)POST:(NSString *)URLString paramater:(id)paramater showHUD:(BOOL)isShowHUD success:(success)success ;


/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(success)success
                 failure:(failure)failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(success)success
                  failure:(failure)failure;

/**
 *  发送网络请求
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param resultBlock 请求的结果
 */
- (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(NetTypes)type
                     success:(success)success
                     failure:(failure)failure;

/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParam 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
- (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(YJNetManage *)uploadInfo
                    success:(success)success
                    failure:(failure)failure;
@end
