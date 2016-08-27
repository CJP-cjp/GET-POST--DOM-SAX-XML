//
//  VideoModel.h
//  SAX方式解析XML
//
//  Created by mac on 16/8/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
@property(copy,nonatomic)NSString *videoId;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *length;
@property(copy,nonatomic)NSString *videoURL;
@property(copy,nonatomic)NSString *imageURL;
@property(copy,nonatomic)NSString *desc;
@property(copy,nonatomic)NSString *teacher;

@end
