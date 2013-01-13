//
//  Controls.h
//  ios
//
//  Created by Tsukasa on 12-12-31.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#import <UIKit/UIKit.h>

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


-(mqyyCategory*)initWithName:(NSString*)name popular:(int)popular;
@end


