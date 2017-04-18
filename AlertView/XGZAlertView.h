//
//  XGZAlertView.h
//  AlertView
//
//  Created by everp2p on 2017/4/18.
//  Copyright © 2017年 TangLiHua. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UILabel+XGZAdd.h"

typedef void(^alertReturn)(NSInteger index);

@interface XGZAlertView : UIView

@property (nonatomic,copy) alertReturn returnIndex;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureBtn cancleBtn:(UIImage *)cancleBtn;

- (void)showAlertView;

@end
