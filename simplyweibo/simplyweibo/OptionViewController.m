//
//  OptionViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/9.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "OptionViewController.h"
#import "SettingViewController.h"
#import "AboutWBViewController.h"
@interface OptionViewController ()

@end

@implementation OptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    [self setUI];
}

-(void)setUI{
    self.view.backgroundColor=RGB(227, 227, 227);
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back-1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
}

- (IBAction)pushAction:(id)sender {
    SettingViewController *svc=[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:svc animated:YES];
}

-(void)backAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)pushwbAction:(id)sender {
    AboutWBViewController*wbv=[[AboutWBViewController alloc]initWithNibName:@"AboutWBViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:wbv animated:YES];
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
