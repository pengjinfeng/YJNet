//
//  YJNetDAO.m
//  HXZ
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 pengf. All rights reserved.
//

#define url @"http://api2.hichao.com/stars?category=全部&page=1"
#import "YJNetDAO.h"
@implementation YJNetDAO
//所有的网络请求
+ (void)carTypeWithBlock:(complite)complite{
    YJNetManage * manager = [YJNetManage shareManage];
    [manager GET:url paramater:nil showHUD:YES success:^(BOOL successCode, NSDictionary *dataDic) {
        
    }];
}



@end
