//
//  AppDelegate.m
//  simplyweibo
//
//  Created by administrator on 16/8/8.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "AppDelegate.h"
#import <WeiboSDK.h>
#import "TabbarViewController.h"
#import "HomeViewController.h"
#import "IssueViewController.h"
#import "MyViewController.h"
#import "mainNavViewController.h"
#import "LoginViewController.h"
#import <MBProgressHUD.h>

#define kAPPKey @"429491909"
#define kRedirectURI @"https://api.weibo.com/oauth2/default.html"
#define KRedirectURI @"http://www.sina.com"

@interface AppDelegate ()<WeiboSDKDelegate>
{
    TabbarViewController *mainVC;
//    mainNavViewController *homeNAVC;
//    mainNavViewController *issueNAVC;
//    mainNavViewController *myNAVC;
//    mainNavViewController *loginNAVC;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    mainVC=[TabbarViewController new];
    _homeNAVC = [[mainNavViewController alloc]initWithRootViewController:[HomeViewController new]];
    _issueNAVC = [[mainNavViewController alloc]initWithRootViewController:[IssueViewController new]];
    _loginNAVC=[[mainNavViewController alloc]initWithRootViewController:[LoginViewController new] ];
    _myNAVC = [[mainNavViewController alloc]initWithRootViewController:[MyViewController new]];

    if([[NSUserDefaults standardUserDefaults]objectForKey:@"ACCESS_TOKEN"]) {
        mainVC.viewControllers=@[_homeNAVC,_issueNAVC,_loginNAVC];
    }else{
    mainVC.viewControllers=@[_homeNAVC,_issueNAVC,_myNAVC];
    }
    
    
    
    
    _names=@[@"首页",@"发布",@"我"];
    
    //让图片维持原图模样。通过方法 UIImage的实例方法 imageWithRenderingMode
                             
    _images=@[[UIImage imageNamed:@"home"],[[UIImage imageNamed:@"arrow-up"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],[UIImage imageNamed:@"user"] ];
    
    for (int i=0; i<mainVC.viewControllers.count; i++) {
        mainVC.viewControllers[i].tabBarItem.title=self.names[i];
        mainVC.viewControllers[i].tabBarItem.image=self.images[i];
        if(i==1){
            mainVC.viewControllers[1].tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0, -6, 0);
            mainVC.viewControllers[1].tabBarItem.title=nil;
        }
    }
    //将 tabBarController 的线条颜色为橙色
    mainVC.tabBar.tintColor=[UIColor orangeColor];
    self.window.rootViewController=mainVC;
    
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAPPKey];
    
    return YES;
}

//下面两个方法都是被别的应用打开的时候被调用
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    NSLog(@"收到请求");
}


-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    NSLog(@"收到响应");
    if([response isMemberOfClass:[WBAuthorizeResponse class] ]){
    WBAuthorizeResponse *authorizeResponse=(WBAuthorizeResponse *)response;
        self.access_token=authorizeResponse.accessToken;
        self.user_id=authorizeResponse.userID;
        NSLog(@"ACCESS_TOKEN=%@",authorizeResponse.accessToken);
        NSLog(@"user_id=%@",authorizeResponse.userID);
        
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        [user setObject:authorizeResponse.accessToken forKey:@"ACCESS_TOKEN"];
        [user setObject:authorizeResponse.userID forKey:@"USERID"];
        [user synchronize];
        
        [MBProgressHUD hideHUDForView:mainVC.viewControllers[2].view animated:YES];
        
        
        
        if(response.statusCode==WeiboSDKResponseStatusCodeSuccess){
            _loginNAVC=[[mainNavViewController alloc]initWithRootViewController:[LoginViewController new]];
            mainVC.viewControllers=@[_homeNAVC,_issueNAVC,_loginNAVC];
            mainVC.viewControllers[2].tabBarItem.title=@"我";
            mainVC.viewControllers[2].tabBarItem.image=[[UIImage imageNamed:@"user"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            mainVC.selectedIndex=0;
        }
    }
    
    
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return  [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
