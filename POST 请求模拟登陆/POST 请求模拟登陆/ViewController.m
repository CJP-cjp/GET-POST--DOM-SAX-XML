//
//  ViewController.m
//  POST 请求模拟登陆
//
//  Created by mac on 16/8/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *pwdText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //显示界面时，自动填充账号和密码
    [self readUserInfo];
    //如果要实现自动登陆，
    //首先先判断输入框里面有没有值
    //若有值，就直接调用登陆的方法
    //若没有值，直接手动的输入用户名和密码
    // Do any additional setup after loading the view, typically from a nib.
    //http://localhost/php/login/login.php?username=zhangsan&password=zhang
}
- (IBAction)loginClick:(UIButton*)sender {
    NSString *username = self.nameText.text;
    NSString *password = self.pwdText.text;
    NSURL *url = [NSURL URLWithString:@"http://localhost/php/login/login.php"];
    NSMutableURLRequest *requesM = [NSMutableURLRequest  requestWithURL:url];
    //修改请求方法
    requesM.HTTPMethod =@"POST";
    //POST的请求信息在请求体里面
    //POST 请求不需要转义
    NSString *body = [NSString stringWithFormat:@"username=%@&password=%@",username,password];
    requesM.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    [[[NSURLSession sharedSession]dataTaskWithRequest:requesM completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data != nil) {
            id result =   [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"%@",result[@"userId"]);
            if ([result[@"userId"]intValue] == 1) {
                NSLog(@"登陆成功");
                //用户登陆成功后，就保存到用户的信息
                [self saveUserInfo];
            }else
            {
                NSLog(@"登陆失败");
            }
        }else
        {
            NSLog(@" %@",error);
        }

        
    }]resume];
//    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error == nil && data != nil) {
//          id result =   [[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL] lastObject];
//            NSLog(@"%@",result[@"userId"]);
//            if ([result[@"userId"]intValue] == 1) {
//                NSLog(@"登陆成功");
//                //用户登陆成功后，就保存到用户的信息
//                [self saveUserInfo];
//            }else
//            {
//                NSLog(@"登陆失败");
//            }
//        }else
//        {
//            NSLog(@" %@",error);
//        }
//    }]resume];
    
}
//保存数据到偏好设置
-(void)saveUserInfo
{
    [[NSUserDefaults standardUserDefaults]setObject:self.nameText.text forKey:@"username"];
    [[NSUserDefaults standardUserDefaults]setObject:self.pwdText.text forKey:@"passward"];
}
//从偏好设置读取保存的数据
-(void)readUserInfo
{
   self.nameText.text =  [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    self.pwdText.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"passward"];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
