//
//  AdvertisingScrollView.m
//  LiJian
//
//  Created by 李健 on 15/9/14.
//  Copyright (c) 2015年 108. All rights reserved.
//

#import "AdvertisingScrollView.h"

@implementation AdvertisingScrollView
{
    NSTimer *_myTimer;
    CGFloat _timerCount;  //计时基数
    CGFloat nowContentx;  //当前contentOffSet
    CGRect _tmpRect;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tmpRect = frame;
        [self initSet:frame];
    }
    return self;
}

- (void)initSet:(CGRect)frame
{
    
    //布局轮播控件
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,__kScreenWidth, frame.size.height)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.delaysContentTouches=YES;
    _scrollView.delegate = self;
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(__kScreenWidth/2 - 50, frame.size.height-32, 100,30 )];
                    
    _pageControl.currentPage = 0;
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
}


//有图片之后开始倒入图片
- (void)build
{
    
    //收到图片为0的时候
    if(_imageCount == 0)
    {
        [_scrollView removeFromSuperview];
        self.frame = CGRectMake(0, 0, 0, 0);
        return;
    }else if (_imageCount == 1)
        //图片仅为一张
    {
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.contentSize = CGSizeMake(__kScreenWidth * _imageCount, _tmpRect.size.height);
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, __kScreenWidth, _tmpRect.size.height)];
        [_imageView sd_setImageWithURL:_imgUrlArr[0] placeholderImage:nil];
        [_scrollView addSubview:_imageView];
        
        _pageControl.numberOfPages = _imgUrlArr.count;
        
        
    }else{
        
        //图片多余一张
        /*
         我的轮播思路是：收取到图片之后，第一张的前面放置最后一张图，最后一张图片的后面放置第一张图，也就是说如果收到四张图片，那么scrollview上会放置6张图片，基于人眼的视觉误差，当从第四张展示图片再向右滑动的时候，也就是滑倒实际存在的第五张图片之时，正好是我们要展示的第一张视图，此时就直接将此刻的contentoffset设置为实际scrollview中第二张图片，也就是我们正要展示的第一张图片。
         
         详情见scrollview代理方法
         
         */
        
        
        _pageControl.numberOfPages = _imgUrlArr.count;
        _scrollView.contentOffset = CGPointMake(__kScreenWidth, 0);
        nowContentx = _scrollView.contentOffset.x;

        _scrollView.contentSize = CGSizeMake(__kScreenWidth * (_imageCount+2), _tmpRect.size.height);
        for (NSInteger i = 0 ; i < _imageCount+2; i++) {
            
            _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*__kScreenWidth, 0, __kScreenWidth, _tmpRect.size.height)];

            if(i == 0)
                //第一张图片
            {
                [_imageView sd_setImageWithURL:[NSURL URLWithString:_imgUrlArr.lastObject] placeholderImage:nil];
                
            }else if(i > 0 && i < _imageCount+1)
                //中间区段图片
            {
                [_imageView sd_setImageWithURL:[NSURL URLWithString:_imgUrlArr[i-1]] placeholderImage:nil];
            }else if(i == _imageCount+1)
                //最后一张图片
            {
                [_imageView sd_setImageWithURL:[NSURL URLWithString:_imgUrlArr[0]] placeholderImage:nil];
            }
            
            
            [_scrollView addSubview:_imageView];
            
        }
        
        //图片放置完毕开启自动轮播
        [self autoScrollTheImage];
    }

}

#pragma mark --自动轮播设置启动timer

- (void)autoScrollTheImage
{

    
    _timerCount = nowContentx/__kScreenWidth;
    //timer启动
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(handleMaxShowTimer) userInfo:nil repeats:YES];
    
}


#pragma mark --实现自动滚动方法

- (void)handleMaxShowTimer
{
    _timerCount++;
    if(_timerCount == _imageCount+2)
    {
        _timerCount = 2;
        [_scrollView scrollRectToVisible:CGRectMake(_timerCount * __kScreenWidth, 0, __kScreenWidth, _imageView.frame.size.height) animated:YES];
    }else
    {
        [_scrollView scrollRectToVisible:CGRectMake(_timerCount * __kScreenWidth, 0, __kScreenWidth, _imageView.frame.size.height) animated:YES];
    }

}


#pragma mark --scrollview代理方法

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
        int page = scrollView.contentOffset.x/__kScreenWidth-1;
        _pageControl.currentPage = page;
        
        if(scrollView.contentOffset.x/__kScreenWidth == _imageCount+1)
        {
            scrollView.contentOffset = CGPointMake(__kScreenWidth, 0);
        }else if (scrollView.contentOffset.x/__kScreenWidth == 0)
        {
            scrollView.contentOffset = CGPointMake(_imageCount*__kScreenWidth, 0);
        }
    
    
    
    
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    //手动拖拽情况下取消timer;
    
    [_myTimer invalidate];
    _myTimer = nil;

}
#pragma mark -- 重新开启timer
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self autoScrollTheImage];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%f",_scrollView.contentOffset.x);

    //取到scrollview滚动停止后的contentoffset以此当下次开启timer后滚动的起点位置
    
    nowContentx = scrollView.contentOffset.x;
    _timerCount = nowContentx/__kScreenWidth - 1;
}






@end
