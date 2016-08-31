//
//  AccountManagementViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/12.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "AccountManagementViewController.h"
#import "User.h"
#import "DefaultUser.h"
#import <UIImageView+YYWebImage.h>
#import <WeiboSDK.h>
#import "AppDelegate.h"
@interface AccountManagementViewController ()<UITableViewDelegate,UITableViewDataSource,WBHttpRequestDelegate>
{
    NSMutableArray *dataSource;
    UITableView *amTV;
    User*user;
    DefaultUser *dUser;
}
@end

@implementation AccountManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    amTV=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:amTV];
    amTV.dataSource=self;
    amTV.delegate=self;
    [self setUI];
    [self initData];
    
}

-(void)setUI{
    self.title=@"账号管理";
    
}

-(void)initData{
    dUser=[DefaultUser new];
    dataSource=[NSMutableArray arrayWithObject:dUser];
    user=[User shareUser];
    NSLog(@"%@",user);
    [dataSource insertObject:user atIndex:dataSource.count-1];
    NSLog(@"%@",dataSource);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        NSLog(@"dataSource.count=%ld",dataSource.count);
        return dataSource.count;
    }
    if(section==1){
        return 1;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"am"];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"am"];
        
    }
    if(indexPath.section==0){
        if(indexPath.row==dataSource.count-1){
            dUser=dataSource[indexPath.row];
            cell.imageView.image=[UIImage imageNamed:@"add"];
            cell.textLabel.text=@"添加账号";
        }else{
            user=dataSource[indexPath.row];
            [cell.imageView setImageWithURL:[NSURL URLWithString:user.avatar_large] placeholder:[UIImage imageNamed:@"head"]];
            
            cell.textLabel.text=user.name;
        }
    }
    if(indexPath.section==1){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"below"];
        cell.textLabel.text=@"退出当前账号";
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.textColor=[UIColor redColor];
        
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        NSString*access=[[NSUserDefaults standardUserDefaults]valueForKey:@"ACCESS_TOKEN"];
        
        [WBHttpRequest requestWithAccessToken:access url:@"https://api.weibo.com/oauth2/revokeoauth2" httpMethod:@"GET" params:nil delegate:self withTag:@"101"];
        
    
        
        
    }
}

-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error=%@",error);
}

-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"result=%@",result);
    if([result containsString:@"true"]){
        [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"ACCESS_TOKEN"];
        [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"USERID"];
        AppDelegate *d=(AppDelegate*)[UIApplication sharedApplication].delegate;
        
        self.tabBarController.viewControllers=@[d.homeNAVC,d.issueNAVC,d.myNAVC];
        
        self.tabBarController.viewControllers[2].tabBarItem.image=[UIImage imageNamed:@"user"];
        
    }
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
