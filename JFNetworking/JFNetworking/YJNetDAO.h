//
//  YJNetDAO.h
//  HXZ
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 pengf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNetManage.h"
typedef void(^complite)(id complite);

@interface YJNetDAO : NSObject
@property (nonatomic,weak) complite complite;

//MARK:所有的网络请求都放在这个地方
+ (void)carTypeWithBlock:(complite)complite;

@end
