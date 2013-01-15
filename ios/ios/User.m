//
//  User.m
//  ios
//
//  Created by Tsukasa on 13-1-15.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import "User.h"

@implementation mqyyUser
@synthesize name;
-(mqyyUser*)initWithName:(NSString*)name
{
    self.name = name;
    return self;
}
@end
