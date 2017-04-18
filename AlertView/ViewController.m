//
//  ViewController.m
//  AlertView
//
//  Created by everp2p on 2017/4/18.
//  Copyright © 2017年 TangLiHua. All rights reserved.
//

#import "ViewController.h"
#import "XGZAlertView.h"

@interface ViewController ()
{
    XGZAlertView *alertView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createAlertView];
}

- (void)createAlertView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HiddenIsNo) name:UIApplicationDidBecomeActiveNotification object:nil];
    //强制更新
    NSString *downloadUrl = @"http://www.baidu.com";
    alertView = [[XGZAlertView alloc] initWithTitle:@"当前版本需要升级" message:@"修复了一些已知bug" sureBtn:@"确定升级" cancleBtn:nil];
    alertView.returnIndex = ^(NSInteger index) {
        if (index == 0) {
            [self openURL:downloadUrl];
        }
    };
    [alertView showAlertView];
    
    //非强制更新
//    alertView = [[XGZAlertView alloc] initWithTitle:@"当前版本需要升级" message:@"修复了一些已知bug" sureBtn:@"确认升级" cancleBtn:[UIImage imageNamed:@"clace"]];
//    alertView.returnIndex = ^(NSInteger index){
//        if (index == 0) {
//            [self openURL:downloadUrl];
//        }
//    };
//    [alertView showAlertView];
}

#pragma mark - openURL
- (void)openURL:(NSString *)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)HiddenIsNo
{
    [alertView showAlertView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
