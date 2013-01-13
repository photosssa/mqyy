//
//  UITestData.m
//  ios
//
//  Created by Tsukasa on 13-1-13.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import "UITestData.h"

@interface UITestData()
{
@private
    
}
@end

@implementation UITestData
-(UITestData*)init
{
    NSMutableArray* cates = [[NSMutableArray alloc] init];
    for(int ix=0;ix < 20; ++ix)
    {
        NSString* name = [NSString stringWithFormat:@"测试数据%d", ix];
        mqyyCategory* newCate = [[mqyyCategory alloc] initWithName:name popular:ix * 100000];
        [cates addObject:newCate];
    }
    _categories = cates;
    return self;
}
@end
