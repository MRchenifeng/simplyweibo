	//
//  IssueViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/9.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "IssueViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <WeiboSDK.h>
#import "FeedBackViewController.h"

@interface IssueViewController ()<CLLocationManagerDelegate,WBHttpRequestDelegate>
{
    NSArray *imageArr;
    NSString *longitudeString;
    NSString *latitudeString;
    CLLocation *cll;
    UILabel *label4;
}

@property(nonatomic,strong)CLLocationManager *clM;
@end

@implementation IssueViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    [self initData];
    [self setUI];
    
    if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied||[CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [self.clM requestWhenInUseAuthorization];
        
    }else{
        [self.clM startUpdatingLocation];
        
        [label4 addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
        
           }
//    NSString *access=[[NSUserDefaults standardUserDefaults]valueForKey:@"ACCESS_TOKEN"];
//    [WBHttpRequest requestWithAccessToken:access url:@"http://op.juhe.cn/onebox/weather/query" httpMethod:@"GET" params:@{@"cityname":label4.text,@"key":@"ee7a6c6c824d84b9d5ce137ec60686b9"} delegate:self withTag:@"104"];
    
    
    
    
    
    
    

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    label4.text=change[NSKeyValueChangeNewKey];
    NSLog(@"change=%@",change);
    if([keyPath isEqualToString:@"text"]){
        NSLog(@"111");
        NSString *str=@"http://v.juhe.cn/weather/index?cityname=guangzhou&key=ee7a6c6c824d84b9d5ce137ec60686b9";
        
        
//        NSLog(@"LABEL=%@",label4.text);
        NSURL *url=[NSURL URLWithString:str];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSURLSessionDataTask *datatask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"dict=%@",dict);
        }];
        [datatask resume];
    }

    }





-(void)initData{
    imageArr=@[[UIImage imageNamed:@"word"],
               [UIImage imageNamed:@"image"],
               [UIImage imageNamed:@"topline"],
               [UIImage imageNamed:@"checkin"],
               [UIImage imageNamed:@"checkin"],
               [UIImage imageNamed:@"checkin"]];
}

-(void)setUI{
    self.view.backgroundColor=[UIColor whiteColor];
    CGFloat space=40;
    CGFloat btnwidth=(UISCREENWIDTH-4*40)/3;
    for (int i=0; i<2; i++) {
        for (int j=0;j<3;j++) {
            NSInteger index=101;
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(space*(j+1)+btnwidth*j, UISCREENHEIGHT/2+150*i, btnwidth, btnwidth);
            [btn setImage:imageArr[j+3*i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(postAction:) forControlEvents:UIControlEventTouchDown];
            btn.tag=index;
            index++;
            
            
            [self.view addSubview:btn];
        }
    }
    NSDate *date=[NSDate date];
    NSDateFormatter *f=[[NSDateFormatter alloc]init];
    [f setDateFormat:@"EEEE"];
    
    NSDateFormatter *f1=[[NSDateFormatter alloc]init];
    [f1 setDateFormat:@"dd"];
    
    NSDateFormatter *f2=[[NSDateFormatter alloc]init];
    [f2 setDateFormat:@"MM/yyyy"];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(40, 100, 80, 80)];
    label1.font=[UIFont systemFontOfSize:50];
    label1.text=[f1 stringFromDate:date];
    [self.view addSubview:label1];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(100, 90,60 ,60)];
    label2.text=[f stringFromDate:date];
    [self.view addSubview:label2];
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(100, 120,70 ,70)];
    label3.text=[f2 stringFromDate:date];
    [self.view addSubview:label3];
    
    label4=[[UILabel alloc]initWithFrame:CGRectMake(40, 150,60 ,60)];
    
    [self.view addSubview:label4];
    
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(100, 150,60 ,60)];
    label5.text=@"阴31℃";
    [self.view addSubview:label5];

}

-(void)setLocation{
    
    CLLocationDegrees longtitude=[longitudeString doubleValue];
    CLLocationDegrees latitude=[latitudeString doubleValue];
    CLGeocoder *geo=[CLGeocoder new];
    [geo reverseGeocodeLocation:cll completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error||placemarks.count==0){
            dispatch_async(dispatch_get_main_queue(), ^{
                label4.text=[NSString stringWithFormat:@"140%@",error];
                
            });
        }else{
            CLPlacemark *pl=placemarks.lastObject;
            dispatch_async(dispatch_get_main_queue(), ^{
                label4.text=[NSString stringWithFormat:@"%@",pl.locality];
            });
        }
    }];
}

-(CLLocationManager *)clM{
    if(!_clM){
        _clM=[CLLocationManager new];
        _clM.delegate=self;
        _clM.distanceFilter=kCLHeadingFilterNone;
        _clM.desiredAccuracy=kCLLocationAccuracyHundredMeters;
    }
    return _clM;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    cll=locations.lastObject;
    
    [self setLocation];

    
}

-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error=%@",error);
}

-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"result=%@",result);
}

-(void)postAction:(UIButton *)sender{
    switch (sender.tag) {
        case 101:{
            FeedBackViewController*bvc=[[FeedBackViewController alloc]initWithNibName:@"FeedBackViewController" bundle:[NSBundle mainBundle]];
            bvc.change1=1;
            [self.navigationController pushViewController:bvc animated:YES];
        }
            
            break;
            
        default:
            break;
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
