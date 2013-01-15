//
//  Controls.m
//  ios
//
//  Created by Tsukasa on 12-12-31.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#import "Data.h"

@interface mqyyCategory ()

@end

@implementation mqyyData
@synthesize categories = _categories;

@end



@interface mqyyCategory ()
{
@private
    NSString* _name;
    int _popular;
    NSArray* _programs;
}

@end

@implementation mqyyCategory

@synthesize name=_name, popular=_popular, programs=_programs;

-(mqyyCategory*)initWithName:(NSString*)name popular:(int)popular programs:(NSArray*)programs
{
    _name = name;
    _popular = popular;
    _programs = programs;
    return self;
}

@end

@interface mqyyProgram()
{
@private
    NSString* _name;
    int _popular;
    mqyyUser* _reader;
}
@end

@implementation mqyyProgram
@synthesize name=_name,popular=_popular,reader=_reader;
-(mqyyProgram*)initWithName:(NSString*)name popular:(int)popular reader:(mqyyUser*)reader
{
    _name = name;
    _popular = popular;
    _reader = reader;
    return self;
}
@end
