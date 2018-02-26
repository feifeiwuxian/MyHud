//
//  Toast.h
//  王飞
//
//  Created by Yock Deng on 15/7/9.
//  Copyright (c) 2015年 王飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Toast : NSObject
{
    UIView *_toastView;
    UILabel *_lbMsg;
    BOOL _viewIsShow;
    
    NSTimer *_timer;
    NSString *_text;
    int _duration;
}

+(Toast *)shareToast;
-(void)makeText:(NSString *)text aDuration:(int)duration;
-(Toast *)makeText:(NSString *)text;
-(Toast *)makeDuration:(int)duration;
-(void)show;

@end
