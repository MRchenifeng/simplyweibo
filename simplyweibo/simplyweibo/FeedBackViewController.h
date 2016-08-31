//
//  FeedBackViewController.h
//  simplyweibo
//
//  Created by administrator on 16/8/11.
//  Copyright © 2016年 administrator. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,change){
    FB=0,
    WB,
    
};

@interface FeedBackViewController : UIViewController
{
    UIView *myView;
}

@property (nonatomic,assign)change change1;

@property (weak, nonatomic) IBOutlet UIView *locationView;

@property (weak, nonatomic) IBOutlet UIView *publicView;

@property (nonatomic,strong)NSString *toName;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
