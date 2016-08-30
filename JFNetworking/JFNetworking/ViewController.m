//
//  ViewController.m
//  JFNetworking
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 pengjf. All rights reserved.
//

#import "ViewController.h"
#import "YJNetDAO.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //网络请求
    [YJNetDAO carTypeWithBlock:^(id complite) {
        //封装好的数据model
        NSLog(@"%@",complite);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
