//
//  ViewController.m
//  字迹绘制动画
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 雷晏. All rights reserved.
//
#define KWIDTH     [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "LYCoreText.h"

@interface ViewController ()
{
    BOOL start;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    start = YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(start){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LYCoreText *coreText = [[LYCoreText alloc]initWithFrame:CGRectMake(30, 20, KWIDTH - 60, 50)];
            [self.view addSubview:coreText];
            [coreText setTextString:@"蜀道难" font:30];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3*1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LYCoreText *coreText = [[LYCoreText alloc]initWithFrame:CGRectMake(30, 60, KWIDTH - 60, 50)];
            [self.view addSubview:coreText];
            [coreText setTextString:@"作者：李白" font:18];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((5+3) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LYCoreText *coreText = [[LYCoreText alloc]initWithFrame:CGRectMake(30, 100, KWIDTH - 60, 50)];
            [self.view addSubview:coreText];
            [coreText setTextString:@"噫吁嚱，危乎高哉！蜀道之难，难于上青天！" font:16];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((5+3+20) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LYCoreText *coreText = [[LYCoreText alloc]initWithFrame:CGRectMake(30, 140, KWIDTH - 60, 50)];
            [self.view addSubview:coreText];
            [coreText setTextString:@"蚕丛及鱼凫，开国何茫然！" font:16];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((5+3+20+12) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LYCoreText *coreText = [[LYCoreText alloc]initWithFrame:CGRectMake(30, 180, KWIDTH - 60, 50)];
            [self.view addSubview:coreText];
            [coreText setTextString:@"尔来四万八千岁，不与秦塞通人烟。" font:16];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((5+3+20+12+15) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LYCoreText *coreText = [[LYCoreText alloc]initWithFrame:CGRectMake(30, 220, KWIDTH - 60, 50)];
            [self.view addSubview:coreText];
            [coreText setTextString:@"西当太白有鸟道，可以横绝峨眉巅。" font:16];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((5+3+20+12+15+16) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LYCoreText *coreText = [[LYCoreText alloc]initWithFrame:CGRectMake(30, 260, KWIDTH - 60, 50)];
            [self.view addSubview:coreText];
            [coreText setTextString:@"地崩山摧壮士死，然后天梯石栈相钩连。" font:16];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((5+3+20+12+15+16+18) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LYCoreText *coreText = [[LYCoreText alloc]initWithFrame:CGRectMake(30, 300, KWIDTH - 60, 50)];
            [self.view addSubview:coreText];
            [coreText setTextString:@"上有六龙回日之高标，下有冲波逆折之回川。" font:16];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((5+3+20+12+15+16+18+20) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LYCoreText *coreText = [[LYCoreText alloc]initWithFrame:CGRectMake(30, 340, KWIDTH - 60, 50)];
            [self.view addSubview:coreText];
            [coreText setTextString:@"......." font:16];
        });

    }
    
    start = NO;

}
@end
