//
//  SPViewController.h
//  simplyweibo
//
//  Created by administrator on 16/8/19.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ImagesHandle)(NSArray *images);
@interface SPViewController : UIViewController
@property(nonatomic,copy)ImagesHandle imagesHandle;
@end
