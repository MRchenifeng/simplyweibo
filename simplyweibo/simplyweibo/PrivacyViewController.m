//
//  PrivacyViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "PrivacyViewController.h"

@interface PrivacyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *pvcTV;
    NSArray *dataSource;
}
@end

@implementation PrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self initData];
}

-(void)setUI{
    self.title=@"隐私";
    pvcTV=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    pvcTV.dataSource=self;
    pvcTV.delegate=self;
    [self.view addSubview:pvcTV];
}

-(void)initData{
    dataSource=@[@[@"隐私设置"],@[@"已屏蔽消息的人",@"已屏蔽微博的人"],@[@"黑名单"]];
    
    
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
