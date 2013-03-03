//
//  User.m
//  ios
//
//  Created by Tsukasa on 13-1-15.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import "User.h"

@implementation mqyyUser
{
    @private
    NSString* _id;
}
@synthesize name, uid=_id;
-(mqyyUser*)initWithName:(NSString*)_name
{
    self.name = _name;
    return self;
}

-(mqyyUser*)initWithId:(NSString*)uid
{
    _id = uid;
    return self;
}
@end
