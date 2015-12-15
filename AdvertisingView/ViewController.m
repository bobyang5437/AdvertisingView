//
//  ViewController.m
//  AdvertisingView
//
//  Created by 李健 on 15/9/15.
//  Copyright (c) 2015年 JasonLee. All rights reserved.
//

#import "ViewController.h"
#import "AdvertisingScrollView.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //广告栏
    AdvertisingScrollView *advScrView = [[AdvertisingScrollView alloc] initWithFrame:CGRectMake(0, 20, __kScreenWidth, 100)];

    //设置图片（也可以从网络请求后 对其imgUrlArr赋值）
    advScrView.imgUrlArr = @[@"http://pic.nipic.com/2008-08-12/200881211331729_2.jpg",
                             @"http://pic1.ooopic.com/uploadfilepic/sheji/2010-01-12/OOOPIC_1982zpwang407_20100112ae3851a13c83b1c4.jpg",
                             @"http://pic1.ooopic.com/uploadfilepic/sheji/2009-09-12/OOOPIC_wenneng837_200909122b2c8368339dd52a.jpg",
                             @"http://img.xiaba.cvimage.cn/4cbc56c1a57e26873c140000.jpg"];
    
    //设置图片数量
    advScrView.imageCount = advScrView.imgUrlArr.count;
    
    //获取图片后构建完整scrollview
    [advScrView build];

    [self.view addSubview:advScrView];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
