//
//  HomeViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/9.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "HomeViewController.h"
#import "FriendAttentionViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=RGB(227,227,227);
    [self setUI];
    
    //1
}

-(void)addFriendsAction:(UIBarButtonItem *)sender{
    FriendAttentionViewController *favc=[FriendAttentionViewController new];
    [self.navigationController pushViewController:favc animated:YES];
    
}

-(void)setUI{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"person"] style:UIBarButtonItemStyleDone target:self action:@selector(addFriendsAction:)];

//    self.navigationController.navigationBar.tintColor=[UIColor darkGrayColor];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"radar"] style:UIBarButtonItemStyleDone target:self action:@selector(sweepAction)];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
