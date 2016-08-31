//
//  ContantViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/22.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "ContantViewController.h"
#import <WeiboSDK.h>
#import <UIImageView+YYWebImage.h>

@interface ContantViewController ()<UITableViewDelegate,UITableViewDataSource,WBHttpRequestDelegate,UISearchBarDelegate,UISearchResultsUpdating>
{
    NSMutableArray *dataSource;
    NSMutableArray *imageData;
    NSMutableArray *searchData;
    NSArray *nameArr;
    UITableView *CVCtableView;
    
    NSDictionary *nameArr1;
    
    UISearchController*sc;
    
    
}

@end

@implementation ContantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self initData];
    dataSource=[NSMutableArray array];
    searchData=[NSMutableArray array];
    imageData=[NSMutableArray array];
    CVCtableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    sc=[[UISearchController alloc]initWithSearchResultsController:nil];
    
    sc.searchResultsUpdater=self;
    sc.dimsBackgroundDuringPresentation=NO;
//    sc.hidesNavigationBarDuringPresentation=NO;
    sc.searchBar.frame=CGRectMake(0,0, sc.searchBar.frame.size.width, 44) ;
    CVCtableView.tableHeaderView=sc.searchBar;
    
    CVCtableView.delegate=self;
    CVCtableView.dataSource=self;
    [self.view addSubview:CVCtableView];
//    UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 30)];
//    
//    testLabel.backgroundColor = [UIColor lightGrayColor];
//    
//    testLabel.textAlignment = NSTextAlignmentCenter;
//    
//    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"今天天气不错呀"];
//    
//    [AttributedStr addAttribute:NSFontAttributeName
//     
//                          value:[UIFont systemFontOfSize:16.0]
//     
//                          range:NSMakeRange(2, 2)];
//    
//    [AttributedStr addAttribute:NSForegroundColorAttributeName
//     
//                          value:[UIColor redColor]
//     
//                          range:NSMakeRange(2, 2)];
//    
//    testLabel.attributedText = AttributedStr;
//    
//    [self.view addSubview:testLabel];
    
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *searchString=[searchController.searchBar text];
    NSLog(@"searchstring = %@",searchString);
    NSPredicate *preicate=[NSPredicate predicateWithFormat:@"self contains[cd] %@",searchString];
    
//    if(searchData!=nil){
//        [searchData removeAllObjects];
//    }
    searchData=[NSMutableArray arrayWithArray:[dataSource filteredArrayUsingPredicate:preicate]];
    NSLog(@"searchData = %@",searchData);
    dispatch_async(dispatch_get_main_queue(), ^{
        [CVCtableView reloadData];

    });
    
}

-(void)setUI{
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)initData{
    NSString *acceces=[[NSUserDefaults standardUserDefaults]valueForKey:@"ACCESS_TOKEN"];
    NSString *uid=[[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"];
    [WBHttpRequest requestWithAccessToken:acceces url:@"https://api.weibo.com/2/friendships/friends.json" httpMethod:@"GET" params:@{@"uid":uid} delegate:self withTag:@"110"];
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name1=dataSource[indexPath.row];
    NSLog(@"name=%@",name1);
    NSString *a=@"@";
    NSString *name2=[a stringByAppendingString:name1];
    NSString *name3=[name2 stringByAppendingString:@" "];
    NSLog(@"name2=%@",name3);
    
    [self.navigationController popViewControllerAnimated:YES];

    self.block(name3);
    
}

-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error=%@",error);
}

-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    
    
}

-(void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    NSError *error;
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    nameArr=dic[@"users"];
    for(nameArr1 in nameArr){
        [dataSource addObject:nameArr1[@"name"]];
        [imageData addObject:nameArr1[@"avatar_large"]];
        
    }
    
    NSLog(@"count=%ld",nameArr.count);
    
    [CVCtableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(sc.active){
        return searchData.count;
    }else{
        return dataSource.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cc"];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cc"];
    }
    
    
    if(sc.active){
        NSUInteger index=[dataSource indexOfObject:searchData[indexPath.row]];
        
        [cell.imageView setImageWithURL:[NSURL URLWithString:imageData[index]] placeholder:[UIImage imageNamed:@"head"]];
        cell.textLabel.text=searchData[indexPath.row];
 
    }else{
        
    [cell.imageView setImageWithURL:[NSURL URLWithString:imageData[indexPath.row]] placeholder:[UIImage imageNamed:@"head"]];
    cell.textLabel.text=dataSource[indexPath.row];
    }
    
    return cell;
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
