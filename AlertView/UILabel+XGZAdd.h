//
//  UILabel+XGZAdd.h
//  AlertView
//
//  Created by everp2p on 2017/4/18.
//  Copyright © 2017年 TangLiHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (XGZAdd)

@property (nonatomic,assign) CGFloat characterSpace;

@property (nonatomic,assign) CGFloat lineSpace;

@property (nonatomic,copy) NSString *keywords;

@property (nonatomic,strong) UIFont *keywordsFont;

@property (nonatomic,strong) UIColor *keywordsColor;

@property (nonatomic,copy) NSString *underlineStr;

@property (nonatomic,strong) UIColor *underlineColor;

-(CGSize)getLabelRectWithMaxWidth:(CGFloat)maxWidth;

@end
