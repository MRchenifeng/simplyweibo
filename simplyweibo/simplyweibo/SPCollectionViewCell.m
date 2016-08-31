//
//  SPCollectionViewCell.m
//  simplyweibo
//
//  Created by administrator on 16/8/22.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "SPCollectionViewCell.h"

@implementation SPCollectionViewCell



- (IBAction)selectBtnAction:(UIButton *)sender {
    sender.selected=!sender.selected;
    self.selectBtnClickBlock(sender.selected);
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
