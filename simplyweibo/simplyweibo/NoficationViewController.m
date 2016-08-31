//
//  NoficationViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "NoficationViewController.h"

@interface NoficationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataSource;
    UITableView *nvcTV;
    
}
@end

@implementation NoficationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self initData];
}

-(void)initData{
    dataSource=@[@[@"@我的",@"评论",@"赞",@"消息",@"群通知",@"未关注人消息",@"新粉丝"],@[@"好友圈微博",@"特别关注微博",@"群微博",@"微博热点"],@[@"免打扰设置",@"获取新信息"]];
    
    
}

-(void)setUI{
    self.title=@"通知";
    nvcTV=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    nvcTV.dataSource=self;
    nvcTV.delegate=self;
    [self.view addSubview:nvcTV];
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
    if(indexPath.section==0){
        if(indexPath.row==3||indexPath.row==4)
        {
            cell.accessoryView=[UISwitch new];
        }if(indexPath.row==0||indexPath.row==1||indexPath.row==6){
            cell.detailTextLabel.text=@"所有人";
        }else if (indexPath.row==5){
            cell.detailTextLabel.text=@"我关注的人";
        }
    }else if (indexPath.section==1){
        if(indexPath.row==0||indexPath.row==2||indexPath.row==3){
            cell.accessoryView=[UISwitch new];
        }else if (indexPath.row==1){
            cell.detailTextLabel.text=@"智能通知";
        }
    }else{
        if(indexPath.row==1){
           cell.detailTextLabel.text=@"每2分钟";
        }
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
