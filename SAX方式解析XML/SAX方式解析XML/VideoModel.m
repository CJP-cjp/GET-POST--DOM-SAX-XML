//
//  VideoModel.m
//  SAX方式解析XML
//
//  Created by mac on 16/8/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel
//重写description
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@",self.videoId,self.name,self.length,self.videoURL,self.imageURL,self.desc,self.teacher];
}
/*
 @property(copy,nonatomic)NSString *videoId;
 @property(copy,nonatomic)NSString *name;
 @property(copy,nonatomic)NSString *length;
 @property(copy,nonatomic)NSString *videoURL;
 @property(copy,nonatomic)NSString *imageURL;
 @property(copy,nonatomic)NSString *desc;
 @property(copy,nonatomic)NSString *teacher;
 */
@end
