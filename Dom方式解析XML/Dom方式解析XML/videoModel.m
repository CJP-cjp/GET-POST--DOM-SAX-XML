



//
//  videoModel.m
//  Dom方式解析XML
//
//  Created by mac on 16/8/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "videoModel.h"

@implementation videoModel
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@",self.videoId,self.name,self.length,self.videoURL,self.imageURL,self.desc,self.teacher];
}

@end
