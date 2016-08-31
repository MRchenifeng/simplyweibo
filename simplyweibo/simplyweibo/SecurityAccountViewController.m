//
//  SecurityAccountViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "SecurityAccountViewController.h"

@interface SecurityAccountViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *saTV;
    NSArray *dataSource;
}
@end

@implementation SecurityAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self initData];
}

-(void)setUI{
    self.title=@"账号安全";
    saTV=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    saTV.dataSource=self;
    saTV.delegate=self;
    [self.view addSubview:saTV];
}

-(void)initData{
    dataSource=@[@[@"登录名"],@[@"修改密码",@"绑定手机",@"证件信息"],@[@"登录保护",@"威顿保护"]];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr=dataSource[section];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"resuee1234"];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"resuee1234"];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
