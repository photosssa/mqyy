//
//  BriefViewController.h
//  ios
//
//  Created by Tsukasa on 13-1-26.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"

@interface BriefViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *statLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *popularLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *readerLabel;
@property (weak, nonatomic) IBOutlet UILabel *briefLabel;

-(void)fillData:(mqyyProgram*)program;
@end


