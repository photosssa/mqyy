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
}

@end

@implementation mqyyCategory

@synthesize name=_name, popular=_popular;

-(mqyyCategory*)initWithName:(NSString*)name popular:(int)popular
{
    _name = name;
    _popular = popular;
    
    return self;
}

@end
