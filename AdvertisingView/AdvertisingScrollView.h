//
//  AdvertisingScrollView.h
//  LiJian
//
//  Created by 李健 on 15/9/14.
//  Copyright (c) 2015年 108. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#define __kScreenWidth [[UIScreen mainScreen]bounds].size.width
#define __kScreenHeight [[UIScreen mainScreen]bounds].size.height

@interface AdvertisingScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,assign)NSInteger imageCount; //图片个数
@property (nonatomic,copy)NSArray *imgUrlArr;      //图片链接
@property (nonatomic,strong)UIPageControl *pageControl;


//得到图片之后开始构建
- (void)build;

@end
