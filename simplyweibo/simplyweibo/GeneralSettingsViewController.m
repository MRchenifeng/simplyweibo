//
//  GeneralSettingsViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "GeneralSettingsViewController.h"

@interface GeneralSettingsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *gsvTV;
    NSArray *dataSource;
    
}
@end

@implementation GeneralSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self initData];
}

-(void)setUI{
    self.title=@"通用设置";
    gsvTV=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    gsvTV.dataSource=self;
    gsvTV.delegate=self;
    [self.view addSubview:gsvTV];
}

-(void)initData{
    dataSource=@[@[@"阅读模式",@"字号设置",@"显示备注信息"],@[@"开启快速拖动"],@[@"横竖屏自动切换"],@[@"图片浏览设置",@"视频自动播放设置"],@[@"WiFi下自动下载微博安装包"],@[@"声音与震动",@"多语言环境"]];
    
    
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
        if (indexPath.row==0) {
            cell.detailTextLabel.text=@"有图模式";
        }else if (indexPath.row==1){
            cell.detailTextLabel.text=@"中";
        }else{
            cell.accessoryView=[UISwitch new];
        }
    }else if (indexPath.section==1){
        cell.accessoryView=[UISwitch new];
        
    }else if (indexPath.section==2){
        cell.accessoryView=[UISwitch new];
        
    }else if (indexPath.section==3){
        if(indexPath.row==0){
            cell.detailTextLabel.text=@"自适应";
        }else{
            cell.detailTextLabel.text=@"关闭";
        }
        
    }else if (indexPath.section==4){
        cell.accessoryView=[UISwitch new];
        
    }else if (indexPath.section==5){
        if(indexPath.row==1){
           cell.detailTextLabel.text=@"简体中文";
        }
    }

    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text=dataSource[indexPath.section][indexPath.row];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
