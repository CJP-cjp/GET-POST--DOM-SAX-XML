//
//  ViewController.m
//  Dom方式解析XML
//
//  Created by mac on 16/8/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "GDataXMLNode.h"
#import "videoModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadXMLData];
}
-(void)loadXMLData
{
    //http://localhost/videos.xml
    NSURL *url = [NSURL URLWithString:@"http://localhost/videos.xml"];
    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data != nil) {
            
            //Dom方法解析XML
            [self DOM:data];
            
        }else
        {
            NSLog(@"%@",error);
        }
    }]resume];
}
-(void)DOM:(NSData*)data
{
    //获取XML文档
    GDataXMLDocument *XMLDocument = [[GDataXMLDocument alloc ]initWithData:data error:NULL];
    //获取XML文档的根节点
    GDataXMLElement *rootElement = XMLDocument.rootElement;
    NSMutableArray *arr = [NSMutableArray array];
    //遍历根节点，取出<video>节点  (有几层，内嵌几层for)
    for (GDataXMLElement *videoElement in rootElement.children ) {
        //创建模型对象
        videoModel *model = [[videoModel alloc]init];
        [arr addObject:model];
        //4遍历<video>节点，取出子节点<name>
        for (GDataXMLElement *subElement  in videoElement.children) {
            //kvc 的模型赋值
            [model setValue:subElement.stringValue forKey:subElement.name];
            
            
        }
        //5遍历<video>节点，取出属性videoId
        for (GDataXMLNode *arrtr in videoElement.children) {
            [model setValue:arrtr.stringValue  forKey:arrtr.name];
                    }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
