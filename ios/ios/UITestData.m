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
    
    NSString* comments[] = {
        @"毛球真淫荡",
        @"小夏真2",
        @"李光真胖",
        @"ayu真瘦",
        @"小司真纯洁",
    };
    
    mqyyUser* users[5];
    users[0] = [[mqyyUser alloc] initWithName:@"毛球"];
    users[1] = [[mqyyUser alloc] initWithName:@"小夏"];
    users[2] = [[mqyyUser alloc] initWithName:@"李光"];
    users[3] = [[mqyyUser alloc] initWithName:@"ayu"];
    users[4] = [[mqyyUser alloc] initWithName:@"小司"];
    
    for(int ix=0;ix < 20; ++ix)
    {
        NSString* name = [NSString stringWithFormat:@"测试数据%d", ix];
        NSMutableArray* programs = [[NSMutableArray alloc] init];
        for(int iy=0;iy < (ix + 1)* 4; ++iy)
        {
            NSString* progName = [NSString stringWithFormat:@"节目%d－%d", ix,iy];
            NSMutableArray* sections = [[NSMutableArray alloc] init];
            for(int iz=0;iz < (iy + 1); ++iz)
            {
                NSString* sectionName = [NSString stringWithFormat:@"章节%d", iz];
                mqyySection* newSection = [[mqyySection alloc] initWithName:sectionName url:@"http://forum.ea3w.com/coll_ea3w/attach/2008_08/12195495450.mp3" index:iz];
                [sections addObject:newSection];
            }
            
            NSMutableArray* conforms = [[NSMutableArray alloc] init];
            for (int iz=0; iz < 10 + iy; ++iz) {
                NSString* comment = comments[iz % 5];
                NSInteger rate = (ix + iy + iz) % 5;
                mqyyUserConform* conform = [[mqyyUserConform alloc]initWithUser:users[(ix + iz + 2) % 5] rate:rate comment:comment];
                
                [conforms addObject:conform];
            }
            
            mqyyProgram* newProg = [[mqyyProgram alloc]initWithName:progName popular:iy * 1000 reader:users[(ix + iy) % 5] sections:sections conforms:[[mqyyUserConforms alloc] initWithConforms:conforms] state:mqyyProgramStateOver brief:@"一师是个好学校"];
            [programs addObject:newProg];
        }
        mqyyCategory* newCate = [[mqyyCategory alloc] initWithName:name popular:ix * 100000 programs:programs];
        [cates addObject:newCate];
        
        
        
    }
    return [self initWithCategories:cates];
}
@end


@implementation UITestDataStub
{
    @private
    UITestData* _data;
}

-(mqyyServerStub*)init
{
    _data = [[UITestData alloc]init];
    return self;
}

-(mqyyData*)syncGetData
{
    return _data;
}

-(mqyyCategory*)syncFillCategory:(mqyyCategory*)category
{
    return category;
}

-(mqyyProgram*)syncFillProgram:(mqyyProgram *)program
{
    return program;
}


@end
