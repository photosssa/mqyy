//
//  mqyyServerStub.h
//  ios
//
//  Created by Tsukasa on 13-2-4.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data.h"

@interface mqyyServerStub : NSObject
-(mqyyData*)syncGetData;
-(mqyyCategory*)syncFillCategory:(mqyyCategory*)category;
-(mqyyProgram*)syncFillProgram:(mqyyProgram*)program;
-(mqyyUser*)syncFillUser:(mqyyUser*)user;
-(mqyyUserConforms*)syncFillConforms:(mqyyUserConforms*)conforms;
-(mqyyUserConform*)syncFillConform:(mqyyUserConform*)conform;

-(mqyySection*)syncNewSection:(mqyySection*)section;
@end