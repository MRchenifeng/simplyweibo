//
//  AboutWBViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/9.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "AboutWBViewController.h"
#import "AboutWBTableViewCell.h"

@interface AboutWBViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray*arr;
    UITableView *aboutTV;
}
@end

@implementation AboutWBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"关于微博";
    arr=@[@"给我评分",@"官方微博",@"常见问题",@"版本更新"];
    aboutTV=[[UITableView alloc]initWithFrame:CGRectMake(0, 200, UISCREENWIDTH, 400) style:UITableViewStyleGrouped];
    aboutTV.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:aboutTV];
    
    aboutTV.dataSource=self;
    aboutTV.delegate=self;
    aboutTV.scrollEnabled=NO;
    
    [aboutTV registerNib:[UINib nibWithNibName:@"AboutWBTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"wbtvc"];
    
    self.view.backgroundColor=RGB(227, 227, 227);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AboutWBTableViewCell *cell=[aboutTV dequeueReusableCellWithIdentifier:@"wbtvc"];
    cell.nameLabel.text=arr[indexPath.row];
    return cell;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr.count;
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
