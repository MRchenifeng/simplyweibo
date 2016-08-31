//
//  LoginViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/9.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginSetViewController.h"
#import <WeiboSDK.h>
#import "User.h"
#import "MyTableViewCell.h"
#import <NSObject+YYModel.h>
#import <UIImageView+YYWebImage.h>
#import "AddFriendsViewController.h"

@interface LoginViewController ()<WBHttpRequestDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataSource;
    NSArray *imageArr;
    User *user;
    UITableView *tableView;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self initData];
}

-(void)setUI{
    self.title=@"我";
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStyleDone target:self action:@selector(addFriendsButtonAction:)];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(settingButtonAction:)];
    
    tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    tableView.dataSource=self;
    tableView.delegate=self;
    [self.view addSubview:tableView];
    
    [tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([MyTableViewCell class])];
    
//    tableView.rowHeight=80;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }
    
    NSArray *array=dataSource[section-1];
    return array.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count+1;
}


-(void)addFriendsButtonAction:(UIBarButtonItem *)sender{
    AddFriendsViewController *afvc=[[AddFriendsViewController alloc]initWithNibName:@"AddFriendsViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:afvc animated:YES];
    
    
}

-(void)settingButtonAction:(UIBarButtonItem *)sender{
    LoginSetViewController *svc=[[LoginSetViewController alloc]initWithNibName:@"LoginSetViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)initData{
    dataSource=@[@[@"新的好友",@"微博等级"],@[@"我的相册",@"我的点评",@"我的赞"],@[@"微博支付",@"微博运动"],@[@"粉丝头条",@"粉丝服务"],@[@"草稿箱"],@[@"更多"]];
    
    imageArr = @[
                   @[[UIImage imageNamed:@"new_friend"],[UIImage imageNamed:@"weibo_level"]],
                   @[[UIImage imageNamed:@"my_photo"],[UIImage imageNamed:@"my_comment"],[UIImage imageNamed:@"my_zan"]],
                   @[[UIImage imageNamed:@"weibo_pay"],[UIImage imageNamed:@"weibo_exercise"]],
                   @[[UIImage imageNamed:@"fans_topline"],[UIImage imageNamed:@"fans_serve"]],
                   @[[UIImage imageNamed:@"draft"]],
                   @[[UIImage imageNamed:@"more"]]];
    
    
    
    NSString *access=[[NSUserDefaults standardUserDefaults]objectForKey:@"ACCESS_TOKEN"];
    NSString *uid=[[NSUserDefaults standardUserDefaults]objectForKey:@"USERID"];
    [WBHttpRequest requestWithAccessToken:access url:@"https://api.weibo.com/2/users/show.json" httpMethod:@"GET" params:@{@"uid":uid} delegate:self withTag:@"100"];
                                                                                                                           
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 110;
    }else{
        return 44;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section>=1){
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"reuse"];
        if(!cell){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
        }
        cell.textLabel.text=dataSource[indexPath.section-1][indexPath.row];
        cell.imageView.image=imageArr[indexPath.section-1][indexPath.row];
       cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        MyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyTableViewCell class])];
        
        [cell.headImageView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholder:[UIImage imageNamed:@"head"]];
        cell.nameLabel.text=user.name;
        if([user.userDescription isEqualToString:@""]){
            cell.introduceLabel.text=[NSString stringWithFormat:@"简介:暂无介绍"];
        }else{
            cell.introduceLabel.text=[NSString stringWithFormat:@"简介:%@",user.userDescription];
        }
        [cell.weiboButton setTitle:[NSString stringWithFormat:@"%@\n微博",user.statuses_count] forState:UIControlStateNormal];
        [cell.attentionButton setTitle:[NSString stringWithFormat:@"%@\n关注",user.friends_count] forState:UIControlStateNormal];
        [cell.fansButton setTitle:[NSString stringWithFormat:@"%@\n粉丝",user.followers_count] forState:UIControlStateNormal];
        [cell.weiboButton addTarget:self action:@selector(weiboButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.fansButton addTarget:self action:@selector(fansButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.attentionButton addTarget:self action:@selector(attentionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}


-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    
}

-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error=%@",error);
}

-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"result=%@",result);
}

-(void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    NSError *error;
     NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if(error){
        NSLog(@"error=%@",error);
    }else{
        user=[User shareUser];
        [user modelSetWithJSON:dic];
        [tableView reloadData];
        
        
//        [user setValuesForKeysWithDictionary:dic];
//        NSLog(@"user=%@",user);
//        User *user=[User shareUser];
//        [user setValuesForKeysWithDictionary:dic];
        
    
}
}




-(void)didReceiveMemoryWarning {
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
