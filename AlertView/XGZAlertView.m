//
//  XGZAlertView.m
//  AlertView
//
//  Created by everp2p on 2017/4/18.
//  Copyright © 2017年 TangLiHua. All rights reserved.
//

#import "XGZAlertView.h"
#import "UIView+Extension.h"

#define LAVSCREEN [UIScreen mainScreen].bounds
#define kDeviceWidth                [UIScreen mainScreen].bounds.size.width      // 界面宽度
#define kDeviceHeight               [UIScreen mainScreen].bounds.size.height

#define KScale                      kDeviceWidth / 375

//默认宽度
#define LAVWIDTH LAVSCREENW-60
///各个栏目之间的距离
#define LAVSPACE 10.0

@interface  XGZAlertView()

//根window
@property (nonatomic) UIWindow *rootWindow;

//弹窗
@property (nonatomic) UIView *alertView;

//title,默认为一行，多行还未做
@property (nonatomic) UILabel *titleLabel;
//内容
@property (nonatomic) UILabel *mesLabel;
//确认按钮
@property (nonatomic) UIButton *sureBtn;
//取消按钮
@property (nonatomic) UIButton *cancleBtn;
///闲的记录一下高度吧
@property (nonatomic) CGFloat alertHeight;

@property(nonatomic,strong) UIView * bg;
@property(nonatomic,strong) UIView * content;
@property(nonatomic,strong) UIImageView * headImg;
@property(nonatomic,strong) UILabel * title;
@property(nonatomic,strong) UILabel * contentLabel;
@property(nonatomic,strong) UIButton * btn;
@property(nonatomic,strong) UIButton * cancel;


@end

@implementation XGZAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureBtn cancleBtn:(UIImage *)cancleBtn{
    if (self == [super init]) {
        self.frame = LAVSCREEN;
        self.backgroundColor = [UIColor colorWithWhite:.7 alpha:.7];
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 10.0;
        self.alertView.layer.masksToBounds = YES;
        self.alertView.frame = CGRectMake(0, 0, 300 * KScale, 350 * KScale);
        self.alertView.center = self.center;
        [self addSubview:self.alertView];
        
        _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300 * KScale, 155.5 * KScale)];
        _headImg.image = [UIImage imageNamed:@"up"];
        _headImg.center = CGPointMake(_alertView.center.x, CGRectGetMinY(_alertView.frame));
        _headImg.alpha = 1;
        [self addSubview:_headImg];
        
        
        if (title) {
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80 * KScale, 300 * KScale, 20 * KScale)];
            self.titleLabel.text = title;
           // self.titleLabel.font = 14;
            self.titleLabel.textColor = [UIColor blackColor];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            _title.center = CGPointMake(self.center.x, CGRectGetMaxY(_headImg.frame) + 30 * KScale);
            [self.alertView addSubview:self.titleLabel];
        }
        if (message) {
            //首先计算当前字体的高度,默认信息用15号
            CGFloat mesHeight = [self getTextHeightWithText:message AndFont:[UIFont systemFontOfSize:15]];
            self.mesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * KScale, CGRectGetMaxY(self.titleLabel.frame) + 5 * KScale, kDeviceWidth - 40 * KScale, mesHeight)];
            self.mesLabel.textColor = [UIColor cyanColor];
            self.mesLabel.text = message;
            //            self.mesLabel.font = kSystemFont_10;
            self.mesLabel.font = [UIFont systemFontOfSize:10];
            self.mesLabel.numberOfLines = 0;
            [self.alertView addSubview:self.mesLabel];
        }
        
        if (cancleBtn == nil) {
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            //self.mesLabel.bottom + 40 * KScale
            self.sureBtn.frame = CGRectMake(0, 310 * KScale , 300 * KScale, 40 * KScale);
            self.sureBtn.backgroundColor = [UIColor blueColor];
            self.sureBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.sureBtn setTitle:sureBtn forState:UIControlStateNormal];
            [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.sureBtn.tag = 0;
            [self.sureBtn addTarget:self action:@selector(buttonBeClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.alertView addSubview:self.sureBtn];
            
        } else{
            
            if (sureBtn) {
                self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                self.sureBtn.frame = CGRectMake(0, 310 * KScale, 300 * KScale , 40 * KScale);
                self.sureBtn.backgroundColor = [UIColor blueColor];
                [self.sureBtn setTitle:sureBtn forState:UIControlStateNormal];
                [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.sureBtn.tag = 0;
                [self.sureBtn addTarget:self action:@selector(buttonBeClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.alertView addSubview:self.sureBtn];
            }
            if(cancleBtn){
                self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                self.cancleBtn.frame = CGRectMake(0, _sureBtn.bottom + 180 * KScale, 40 * KScale, 40 * KScale);
                _cancleBtn.center = CGPointMake(self.center.x, _cancleBtn.center.y);
                [self.cancleBtn setImage:[UIImage imageNamed:@"clace"] forState:UIControlStateNormal];
                self.cancleBtn.tag = 1;
                [self.cancleBtn addTarget:self action:@selector(buttonBeClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:self.cancleBtn];
            }
            
        }
        
    }
    return self;
}
#pragma mark - 弹出 -
- (void)showAlertView{
    self.rootWindow = [UIApplication sharedApplication].keyWindow;
    [self.rootWindow addSubview:self];
    ///创建动画
    //   [self creatShowAnimation];
}
- (void)creatShowAnimation{
    CGPoint startPoint = CGPointMake(self.frame.size.height, -self.alertHeight);
    //damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
    //velocity:弹性复位的速度
    self.alertView.layer.position = startPoint;
    [UIView animateWithDuration:2.0 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.layer.position = self.center;
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark - 点击按钮的回调 -
- (void)buttonBeClicked:(UIButton *)button
{
    if (self.returnIndex) {
        self.returnIndex(button.tag);
    }
    [self removeFromSuperview];
    
}
#pragma mark - 得到高度 -
-(CGFloat)getTextHeightWithText:(NSString *)text AndFont:(UIFont *)font
{
    return [text boundingRectWithSize:CGSizeMake(kDeviceWidth - 40, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]} context:nil].size.height;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
