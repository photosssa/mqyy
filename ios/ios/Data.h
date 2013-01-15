//
//  Controls.h
//  ios
//
//  Created by Tsukasa on 12-12-31.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface mqyyData : NSObject
{
@protected
    NSArray* _categories;
}
@property(retain,readonly) NSArray* categories;
@end

@interface mqyyCategory : NSObject
@property(retain, readonly) NSString* name;
@property(readonly)int popular;
@property(retain, readonly) NSArray* programs;

-(mqyyCategory*)initWithName:(NSString*)name popular:(int)popular programs:(NSArray*)programs;
@end



@interface mqyyProgram : NSObject
@property(retain, readonly) NSString* name;
@property(readonly)int popular;
@property(retain, readonly) mqyyUser* reader;

-(mqyyProgram*)initWithName:(NSString*)name popular:(int)popular reader:(mqyyUser*)reader;
@end


