//
//  ContantViewController.h
//  simplyweibo
//
//  Created by administrator on 16/8/22.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^aBlock)(NSString *value);
@interface ContantViewController : UIViewController
@property(nonatomic,copy)aBlock block;
@end
