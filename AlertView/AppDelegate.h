//
//  AppDelegate.h
//  AlertView
//
//  Created by everp2p on 2017/4/18.
//  Copyright © 2017年 TangLiHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

