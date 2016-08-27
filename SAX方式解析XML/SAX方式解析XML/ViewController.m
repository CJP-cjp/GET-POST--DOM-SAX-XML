//
//  ViewController.m
//  SAX方式解析XML
//
//  Created by mac on 16/8/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "VideoModel.h"
@interface ViewController ()<NSXMLParserDelegate>
{
    //用于做节点之间内荣的拼接
    NSMutableString *_stringM;
    //用于全局的模型
    VideoModel * _VideoM;
    NSMutableArray *_vArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _stringM = [NSMutableString string ];
    [self loadXMLData];
    // Do any additional setup after loading the view, typically from a nib.
    //http://localhost/videos.xml
}
-(void)loadXMLData
{
    NSURL *url =[NSURL URLWithString:@"http://localhost/videos.xml"];
    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data != nil) {
            //1.创建XML解析器
            NSXMLParser *XMLParser = [[NSXMLParser alloc]initWithData:data];
            //2.遵守解析器的代理
            XMLParser.delegate = self;
            //3.开始解析
            [XMLParser parse];
            
        }else
        {
            NSLog(@"%@",error);
        }
    }]resume];
}
// SAX :原理：一行一行的扫描，
#pragma mark - NSXML
//开始解析XML文档
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"1.开始解析XML文档");
}
//找开始节点
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    //elementName:开始节点
    //attributeDict：节点属性
    NSLog(@"2.找开始节点=%@ -- %@",elementName,attributeDict);
    //如果开始节点是<video>就创建模型对象
    if ([elementName isEqualToString:@"video"]) {
        //创建模型对象
//        VideoModel *model = [[VideoModel alloc]init];
        _VideoM =  [[VideoModel alloc]init];
        //
        [_vArray addObject:_VideoM];
        //给模型对象的videoId赋值，因为只有在这个方法里面可以拿到'attributeDict'所以只能在这个了赋值
         _VideoM.videoId = attributeDict[@"videoId"];
        
    }
}
//找节点之间内容
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //string :节点之间的内容
    NSLog(@"找节点之间内容%@",string);
    //拼接每次找到的节点之间的内容
    [_stringM appendString:string];
}
//找结束节点
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //elementName :结束节点
    NSLog(@"找结束节点:%@",elementName);
    if (![elementName isEqualToString:@"videos"] && ![elementName isEqualToString:@"video"]) {
        [_VideoM setValue:_stringM forKey:elementName];
    }
    //再给一个模型的属性赋值完成之后，需要再清空一次
    //绝对不能这么清空，如果这么写，_stringM 就没有了
    //正确的做法
    //@""是空字符窜，不是nil
    [_stringM setString:@""];
    //
    //_stringM.string = @"";
    
}
// 结束解析XML文档
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"结束解析XML文档");
    //_VideoM 里面的元素都是模型
    NSLog(@"%@",_VideoM);
    //下一步：自定义cell ,刷新列表
}
//监听解析是否出错
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    //parseError:解析出错的信息
    NSLog(@"解析出错的d%@",parseError);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
