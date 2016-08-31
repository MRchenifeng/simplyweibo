//
//  SPCollectionViewCell.h
//  simplyweibo
//
//  Created by administrator on 16/8/22.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectedBtnClickBlock)(BOOL isSelected);



@interface SPCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *selectView;

@property(nonatomic,copy)SelectedBtnClickBlock selectBtnClickBlock;

@end
