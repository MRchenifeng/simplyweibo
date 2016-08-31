//
//  AppDelegate.h
//  simplyweibo
//
//  Created by administrator on 16/8/8.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainNavViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
}
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)NSString *access_token;
@property(nonatomic,strong)NSString *user_id;


@property(nonatomic,strong)mainNavViewController *homeNAVC;

@property(nonatomic,strong)mainNavViewController *issueNAVC;

@property(nonatomic,strong)mainNavViewController *myNAVC;

@property(nonatomic,strong)mainNavViewController *loginNAVC;

@property(nonatomic,strong)NSArray *names;

@property(nonatomic,strong)NSArray *images;


@end

