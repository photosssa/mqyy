//
//  UITestData.h
//  ios
//
//  Created by Tsukasa on 13-1-13.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data.h"
#import "mqyyServerStub.h"

@interface UITestData : mqyyData
-(UITestData*)init;
@end

@interface UITestDataStub : mqyyServerStub
-(mqyyData*)syncGetData;
-(mqyyCategory*)syncFillCategory:(mqyyCategory*)category;
-(mqyyProgram*)syncFillProgram:(mqyyProgram *)program;
@end
