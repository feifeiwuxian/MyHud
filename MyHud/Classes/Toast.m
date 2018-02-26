//
//  Toast.m
//  王飞
//
//  Created by Yock Deng on 15/7/9.
//  Copyright (c) 2015年 王飞. All rights reserved.
//

#import "Toast.h"
#import "YiTuo_Swift-Swift.h"

//定义一个静态变量用于接收实例对象，初始化为nil
static Toast *singleInstance=nil;

@implementation Toast

+(Toast *)shareToast{
    @synchronized(self){//线程保护，增加同步锁
        if (singleInstance==nil) {
            singleInstance=[[self alloc] init];
        }
    }
    return singleInstance;
}

-(void)makeText:(NSString *)text aDuration:(int)duration{
    _text=text;
    _duration=duration;
    [self show];
}
-(Toast *)makeText:(NSString *)text{
    _text=text;
    return singleInstance;
}
-(Toast *)makeDuration:(int)duration{
    _duration=duration;
    return singleInstance;
}
-(void)show{
    if (!_viewIsShow) {
        _viewIsShow=YES;
        UIFont *font=[UIFont systemFontOfSize:16];
        CGRect rect=[_text boundingRectWithSize:CGSizeMake(280, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        
        _lbMsg=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        _lbMsg.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        _lbMsg.font=font;
        _lbMsg.textColor=[UIColor whiteColor];
        _lbMsg.numberOfLines=0;
        _lbMsg.text=_text;
        
        _toastView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width + 20, rect.size.height + 20)];
        _toastView.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-(49+50+((rect.size.height+20)/2)));
        _lbMsg.center = CGPointMake(_toastView.frame.size.width / 2, _toastView.frame.size.height / 2);
        _toastView.backgroundColor=[UIColor blackColor];
        _toastView.alpha=0.6f;
        _toastView.layer.cornerRadius = 5;
        _toastView.layer.masksToBounds=YES;
        [_toastView addSubview:_lbMsg];
        
        AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.window addSubview:_toastView];
        
        _timer=[NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(hideToast) userInfo:nil repeats:NO];
    }else{
        _lbMsg.text=_text;
        [self resizeFrame];
        [_timer invalidate];
        _timer=[NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(hideToast) userInfo:nil repeats:NO];
    }
    
}
- (void)resizeFrame{
    UIFont *font=[UIFont systemFontOfSize:16];
    CGRect rect=[_text boundingRectWithSize:CGSizeMake(280, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    _lbMsg.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    _lbMsg.text=_text;
    
    _toastView.frame = CGRectMake(0, 0, rect.size.width + 20, rect.size.height + 20);
    _toastView.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-(49+50+((rect.size.height+20)/2)));
    _lbMsg.center = CGPointMake(_toastView.frame.size.width / 2, _toastView.frame.size.height / 2);
}
-(void)hideToast{
    _viewIsShow=NO;
    [_toastView removeFromSuperview];
}

@end
