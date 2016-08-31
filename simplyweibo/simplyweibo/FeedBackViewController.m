//
//  FeedBackViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "FeedBackViewController.h"
#import "SPViewController.h"
#import "ContantViewController.h"
#import "User.h"
#import "ViewController.h"
@interface FeedBackViewController ()<UITextViewDelegate>
{
    int k;
    int j;
    NSMutableArray *rangArr;
    User *user;
}
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
    rangArr=[NSMutableArray array];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showNotification:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideNotification:) name:UIKeyboardDidHideNotification object:nil];
}

-(void)showNotification:(NSNotification *)noti{
    CGFloat offset=UISCREENHEIGHT-(myView.frame.origin.y+myView.frame.size.height+266);
    if(offset<=0){
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame=myView.frame;
            frame.origin.y=frame.origin.y+offset;
            myView.frame=frame;
            
        }];
    }
}

-(void)hideNotification:(NSNotification *)noti{
    //注销第一响应者
}


-(void)setUI{
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    
//    ViewController *vc=[ViewController new];
//    NSLog(@"enum=%ld",vc.change1);
    if(self.change1==0){
    label1.text=@"意见反馈";
        _textView.text=@"想说些什么啊你";
    }
    if(self.change1==1){
        label1.text=@"发微博";
        _textView.text=@"分享新鲜事";
    }
    label1.textAlignment=NSTextAlignmentCenter;
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 100, 20)];
    user=[User shareUser];
    label2.text=user.name;
    label2.font=[UIFont systemFontOfSize:12];
    label2.textColor=[UIColor grayColor];
    label2.textAlignment=NSTextAlignmentCenter;UIView* titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
    [titleView addSubview:label1];
    [titleView addSubview:label2];
    
    self.navigationItem.titleView=titleView;
    
    
    _locationView.layer.masksToBounds = YES;
    _locationView.layer.cornerRadius=20;
    _publicView.layer.masksToBounds=YES;
    _publicView.layer.cornerRadius=20;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendAction:)];
//    self.navigationController.toolbarHidden=NO;
    
    
    
    myView=[[UIView alloc]initWithFrame:CGRectMake(0,UISCREENHEIGHT-80,UISCREENWIDTH,80 )];
    [self.view addSubview:myView];
    
    
    UIView *publicV=[[UIView alloc]initWithFrame:CGRectMake(UISCREENWIDTH-80, 0,60, 36)];
    publicV.layer.masksToBounds=YES;
    publicV.layer.cornerRadius=15;
    publicV.backgroundColor=RGB(249, 249, 249);
    [myView addSubview:publicV];
    UIImageView *publicIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 8, 20, 20)];
    publicIV.image=[UIImage imageNamed:@"global"];
    [publicV addSubview:publicIV];
    
    UILabel *publicL=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 40, 36)];
    publicL.text=@"公开";
    publicL.textColor=RGB(141, 174, 200);
    [publicV addSubview:publicL];
    
    UIView *locationView=[[UIView alloc]initWithFrame:CGRectMake(20, 0,90,36)];
    locationView.layer.masksToBounds=YES;
    locationView.layer.cornerRadius=15;
    [myView addSubview:locationView];
    locationView.backgroundColor=RGB(249, 249, 249);
    
    UIImageView *locationIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 8, 20, 20)];
    locationIV.image=[UIImage imageNamed:@"location"];
    [locationView addSubview:locationIV];
    
    UILabel *locationL=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 70, 36)];
    locationL.text=@"显示位置";
    locationL.textColor=[UIColor darkGrayColor];
    [locationView addSubview:locationL];
    
    
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, myView.frame.size.height-44, UISCREENWIDTH, 44)];
    [myView addSubview:toolBar];
    toolBar.backgroundColor=[UIColor yellowColor];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIBarButtonItem *bb1=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"picture"] style:UIBarButtonItemStyleDone target:self action:@selector(bb1Action:)];
    bb1.tintColor=[UIColor blackColor];
    
    UIBarButtonItem *bb2=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"@"] style:UIBarButtonItemStyleDone target:self action:@selector(bb2Action:)];
    bb2.tintColor=[UIColor blackColor];
    
    UIBarButtonItem *bb3=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"topic"] style:UIBarButtonItemStyleDone target:self action:@selector(bb3Action:)];
    bb3.tintColor=[UIColor blackColor];
    
    UIBarButtonItem *bb4=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"emoji"] style:UIBarButtonItemStyleDone target:self action:@selector(bb4Action:)];
    bb4.tintColor=[UIColor blackColor];
    
    UIBarButtonItem *bb5=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStyleDone target:self action:@selector(bb5Action:)];
    
    bb5.tintColor=[UIColor blackColor];
    [toolBar setItems:@[bb1,space,bb2,space,bb3,space,bb4,space,bb5]];
    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
}

-(void)sendAction:(UIBarButtonItem *)sender{
    
}


-(void)bb1Action:(UIBarButtonItem *)sender{
    SPViewController *spvc=[SPViewController new];
    [self.navigationController pushViewController:spvc animated:YES];
}

-(void)bb2Action:(UIBarButtonItem *)sender{
    ContantViewController *cvc=[ContantViewController new];
    cvc.block=^(NSString *value){
        self.toName=value;
        
        if(_textView.text==nil){
            _textView.text=self.toName;
        }else{
        _textView.text=[_textView.text stringByAppendingString:self.toName];
        NSLog(@"text长度=%ld",_textView.text.length);
        }
        
        NSString *temp=nil;
            
        for (int i=0; i<_textView.text.length; i++){
            temp=[_textView.text substringWithRange:NSMakeRange(i, 1)];
            if([temp isEqualToString:@"@"]){
                k=i;
                NSLog(@"第%d个字是%@",i,temp);
            }
            if([temp isEqualToString:@" "]){
                NSLog(@"第%d个字是%@空格",i,temp);
                j=i;
                NSLog(@"k=%d,j=%d",k,j);
                NSLog(@"rangArr=%@",rangArr);
            }
        }
        NSRange range3=NSMakeRange(k, j-k);
        [rangArr addObject:[NSValue valueWithRange:range3]];
        NSLog(@"rangArr000=%@",rangArr);
        
        NSMutableAttributedString *abs=[[NSMutableAttributedString alloc]initWithString:_textView.text];

        for (NSValue *rangeValue in rangArr) {
            [abs addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:[rangeValue rangeValue]];

        }
        
        _textView.attributedText=abs;

    };
    
   [self.navigationController pushViewController:cvc animated:YES];
}



-(void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"22");
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
