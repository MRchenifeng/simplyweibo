//
//  MyViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/9.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyViewController.h"
#import <WeiboSDK.h>
#import <MBProgressHUD.h>
#import "SettingViewController.h"
#import "OptionViewController.h"
@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}


-(void)setUI{
    self.title=@"我";
    self.view.backgroundColor=RGB(227, 227, 227);
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(pushSetting:)];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64,[UIScreen mainScreen].bounds.size.width ,([UIScreen mainScreen].bounds.size.width)/2)];
    
    imageView.image=[UIImage imageNamed:@"my_background"];
    [self.view addSubview:imageView];
    
    UIView *gzview=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), UISCREENWIDTH, 44)];
    gzview.backgroundColor=[UIColor whiteColor];
    UILabel *gzLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 44)];
    gzLabel.text=@"关注";
    
    gzLabel.font=[UIFont systemFontOfSize:20];
    
    [gzview addSubview:gzLabel];
    
    UILabel *checkoutLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 0, 180, 44)];
    checkoutLabel.text=@"快来看看大家都在关注谁";
    checkoutLabel.font=[UIFont systemFontOfSize:15];
    checkoutLabel.textColor=[UIColor grayColor];
    
    [gzview addSubview:checkoutLabel];
    
    UIImageView *rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH-50, 7, 30, 30)];
    rightImageView.image=[UIImage imageNamed:@"cut"];
    
    [gzview addSubview:rightImageView];
    //为视图添加单击手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkoutGz:)];
    [gzview addGestureRecognizer:tap];
    
    [self.view addSubview:gzview];
    
    UILabel *jieshaoLabel=[[UILabel alloc]initWithFrame:CGRectMake(60,CGRectGetMaxY(gzview.frame)+ (UISCREENHEIGHT-CGRectGetMaxY(gzview.frame))/2-60, UISCREENWIDTH-120, 60)];
    jieshaoLabel.text=@"登录后，你的微博、相册、个人资料会显示在这里。展示给他人";
    
    jieshaoLabel.textColor=[UIColor grayColor];
    jieshaoLabel.numberOfLines=0;
    jieshaoLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:jieshaoLabel];
    
    UIButton *loginButton=[UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame=CGRectMake(UISCREENWIDTH/2-40, CGRectGetMaxY(gzview.frame)+ (UISCREENHEIGHT-CGRectGetMaxY(gzview.frame))/2, 120, 44   );
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    loginButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    loginButton.layer.borderWidth=2.0;
    
    [self.view addSubview:loginButton];
    
    
    
}

-(void)loginButtonAction:(UIButton *)sender{
    WBAuthorizeRequest *request=[WBAuthorizeRequest request];
    request.redirectURI=kRedirectURI;
    request.scope=@"all";
    request.userInfo=@{@"SSO_From":@"ViewController",@"Other_Info_1":[NSNumber numberWithInteger:123]};
    [WeiboSDK sendRequest:request];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
}


-(void)checkoutGz:(UITapGestureRecognizer *)tap{
    NSLog(@"单击关注");
}


-(void)pushSetting:(UIBarButtonItem *)sender{
    OptionViewController *ovc=[[OptionViewController alloc]initWithNibName:@"OptionViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:ovc animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
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
