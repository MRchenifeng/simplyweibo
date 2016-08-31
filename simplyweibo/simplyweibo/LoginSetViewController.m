//
//  LoginSetViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/10.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "LoginSetViewController.h"
#import "NoficationViewController.h"
#import "PrivacyViewController.h"
#import "GeneralSettingsViewController.h"
#import "FeedBackViewController.h"
#import "AccountManagementViewController.h"
#import "ViewController.h"

@interface LoginSetViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataSource;
    
    UITableView *loginTV;
}
@end

@implementation LoginSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setUI];
}


-(void)setUI{
    self.title=@"设置";
    loginTV=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    loginTV.dataSource=self;
    loginTV.delegate=self;
    [self.view addSubview:loginTV];
}

-(void)initData{
    dataSource=@[@[@"账号管理",@"账号安全"],@[@"通知",@"隐私",@"通用设置"],@[@"意见反馈",@"关于微博"],@[@"消除缓存"],@[@"退出微博"]];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        switch (indexPath.row) {
            case 0:{
    AccountManagementViewController*mvc=[AccountManagementViewController new];
                [self.navigationController pushViewController:mvc animated:YES];                                       }
                break;
                
            default:
                break;
        }
    }
if(indexPath.section==1){
    switch (indexPath.row) {
            case 0:
        {
        NoficationViewController *nvc=[NoficationViewController new];
        [self.navigationController pushViewController:nvc animated:YES];
        }
            break;
            case 1:
        {
            PrivacyViewController *pvc=[PrivacyViewController new];
            [self.navigationController pushViewController:pvc animated:YES];
            
        }
            break;
            case 2:
        {
            GeneralSettingsViewController *svc=[GeneralSettingsViewController new];
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        default:
                break;
        }
    }
    if(indexPath.section==2){
        switch (indexPath.row) {
            case 0:
            {
                FeedBackViewController*bvc=[[FeedBackViewController alloc]initWithNibName:@"FeedBackViewController" bundle:[NSBundle mainBundle]];
                bvc.change1=0;
                [self.navigationController pushViewController:bvc animated:YES];

                            }
                break;
               
            default:
                break;
        }
    }
    if (indexPath.section==dataSource.count-1) {
        NSLog(@"退出");
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr=dataSource[section];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"resuee123"];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"resuee123"];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text=dataSource[indexPath.section][indexPath.row];
    }
    if(indexPath.section==dataSource.count-1){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"exit"];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.textColor=[UIColor redColor];
    }
    cell.textLabel.text=dataSource[indexPath.section][indexPath.row];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
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
