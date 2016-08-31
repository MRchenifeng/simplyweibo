//
//  ViewController.m
//  simplyweibo
//
//  Created by administrator on 16/8/8.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "ViewController.h"
#import <WeiboSDK.h>
#import "AppDelegate.h"
@interface ViewController ()<WBHttpRequestDelegate>
@property (weak, nonatomic) IBOutlet UILabel *accessLabel;
@property (weak, nonatomic) IBOutlet UITextField *sendMessage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"111");
    
    AppDelegate *d=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [d addObserver:self forKeyPath:@"access_token" options:NSKeyValueObservingOptionNew context:nil];
    
    self.accessLabel.text=[(AppDelegate *)[UIApplication sharedApplication].delegate access_token];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"access_token"]){
        self.accessLabel.text=change[NSKeyValueChangeNewKey];
    }
}

- (IBAction)loginAction:(id)sender {
    WBAuthorizeRequest *request=[WBAuthorizeRequest request];
    request.redirectURI=kRedirectURI;
    request.scope=@"all";
    request.userInfo=@{@"SSO_From":@"ViewController",@"Other_Info_1":[NSNumber numberWithInteger:123]
                       };
    [WeiboSDK sendRequest:request];
}

-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response=%@",response);
}

-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error=%@",error);
}

-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"读取结果=%@",result);
}

-(void)dealloc{
    [(AppDelegate *)[UIApplication sharedApplication].delegate removeObserver:self forKeyPath:@"access_token"];
}

- (IBAction)sendMessageAction:(id)sender {
    //方法2，通过 WBSendMessageToWeiboRequest 向微博客户端发微博
//    WBAuthorizeRequest *autherrequest=[WBAuthorizeRequest request];
//    autherrequest.redirectURI=kRedirectURI;
//    autherrequest.scope=@"all";
//    
//    WBSendMessageToWeiboRequest *request=[WBSendMessageToWeiboRequest requestWithMessage:[self messageObject] authInfo:autherrequest access_token:self.accessLabel.text];
//    
//    [WeiboSDK sendRequest:request];
    //调用 openAPI
    //方法1
       NSString *text=self.sendMessage.text;
//       text=[text stringByTrimmingCharactersInSet:[NSCharacterSet URLQueryAllowedCharacterSet]];
   
    [WBHttpRequest requestWithAccessToken:self.accessLabel.text url:@"https://api.weibo.com/2/statuses/friends_timeline.json" httpMethod:@"GET" params:nil delegate:self withTag:@"101"];
    
    
//    [WBHttpRequest requestWithAccessToken:self.accessLabel.text url:@"https://api.weibo.com/2/statuses/update.json" httpMethod:@"POST" params:@{@"status":text} queue:[NSOperationQueue mainQueue] withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
//        NSLog(@"result =%@",result);
//        NSLog(@"ERROR=%@",error);
//    }];
}

-(WBMessageObject *)messageObject{
    WBMessageObject *message=[WBMessageObject message];
    message.text=self.sendMessage.text;
    return message;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
