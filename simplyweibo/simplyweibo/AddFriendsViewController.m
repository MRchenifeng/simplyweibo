//
//  AddFriendsViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/15.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "AddTableViewCell.h"

@interface AddFriendsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *imageArr;
    NSArray *nameArr;
    NSArray *aboutArr;
    
}

@end

@implementation AddFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self initData];
}

-(void)initData{
                            imageArr=@[[UIImage imageNamed:@"sweep"],      [UIImage imageNamed:@"addressbook"]];
    
    nameArr=@[@"扫一扫",@"通讯录好友"];
    
    aboutArr=@[@"扫描二维码图片",@"添加和邀请通讯录中的好友"];
}




-(void)setUI{
    self.view.backgroundColor=RGB(227, 227, 227);
    self.sb.placeholder=@"搜索昵称";
    UITableView *sweepTV=[[UITableView alloc]initWithFrame:CGRectMake(0,self.sb.frame.origin.y+self.sb.frame.size.height,UISCREENWIDTH, UISCREENHEIGHT-self.sb.frame.origin.y+self.sb.frame.size.height) style:UITableViewStylePlain];
    sweepTV.delegate=self;
    sweepTV.dataSource=self;
    [sweepTV registerNib:[UINib nibWithNibName:@"AddTableViewCell" bundle:[NSBundle mainBundle] ]forCellReuseIdentifier:NSStringFromClass([AddTableViewCell class])];
    sweepTV.rowHeight=80;
    
    [self.view addSubview:sweepTV];
    sweepTV.backgroundColor=[UIColor clearColor];
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddTableViewCell class])];
    cell.nameImage.image=imageArr[indexPath.row];
    cell.name.text=nameArr[indexPath.row];
    cell.about.text=aboutArr[indexPath.row];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
