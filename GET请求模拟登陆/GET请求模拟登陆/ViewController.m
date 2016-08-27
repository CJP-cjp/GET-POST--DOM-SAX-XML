//
//  ViewController.m
//  GET请求模拟登陆
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
//    // Do any additional setup after loading the view, typically from a nib.
}

//登陆主方法
- (IBAction)loginClictBtn:(id)sender {
    NSString *nameStr = self.nameText.text;
    NSString *pwdStr = self.pwdText.text;
    NSString *urlSting = [NSString stringWithFormat:@"http://localhost/php/login/login.php?username=%@&password=%@",nameStr,pwdStr];
    NSString *urlSt = [urlSting stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet ] ];
    
    //URL
   // NSURL *url = [NSURL URLWithString:@"http://localhost/php/login/login.php?username=zhangsan&password=zhang"];
    NSURL *url = [NSURL URLWithString:urlSt];
    
//    //反序列化
//    id resurlt = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:0 error:nil];
    //发起和启动任务
    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data != nil) {
            //反序列化
            id resurlt = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:0 error:nil];
            //判断是否登陆成功
            NSLog(@"%@",resurlt[@"userId"]);
            
            if ([resurlt[@"userId"]intValue] == 1) {
                NSLog(@"登陆成功");
                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//                    self.nameText.text = @"zhangsan";
//                    self.pwdText.text = @"zhang";

                }];
                           }else{
                NSLog(@"登陆失败");
            }
        }else
        {
            NSLog(@"%@",error);
        }
    }]resume];
}

/*





 */

@end
