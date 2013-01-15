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
        NSMutableArray* programs = [[NSMutableArray alloc] init];
        for(int iy=0;iy < (ix + 1)* 4; ++iy)
        {
            NSString* progName = [NSString stringWithFormat:@"节目%d－%d", ix,iy];
            NSString* readerName = [NSString stringWithFormat:@"读者%d－%d", ix,iy];
            mqyyProgram* newProg = [[mqyyProgram alloc]initWithName:progName popular:iy * 1000 reader:[[mqyyUser alloc] initWithName:readerName]];
            [programs addObject:newProg];
        }
        mqyyCategory* newCate = [[mqyyCategory alloc] initWithName:name popular:ix * 100000 programs:programs];
        [cates addObject:newCate];
        
        
        
    }
    _categories = cates;
    return self;
}
@end
