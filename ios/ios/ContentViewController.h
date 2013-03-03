//
//  ContentViewController.h
//  ios
//
//  Created by Tsukasa on 13-1-15.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"

@interface ContentViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *sectionNumLabel;

- (IBAction)SectionNavNext:(id)sender;
- (IBAction)SectionNavPre:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SectionNavNextBtn;
@property (weak, nonatomic) IBOutlet UIButton *SectionNavPreBtn;
-(void)fillData:(mqyyProgram*)program;
@property(readonly,retain) mqyyProgram* program;
@end


@interface SectionTableViewCell : UITableViewCell
- (IBAction)onCache:(id)sender;
- (void)setSelected:(BOOL)selected;
- (void)didSelected;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *cacheStateBtn;
@property (retain, readonly) mqyySection* section;
-(void)fillData:(mqyySection*)section;
@end

@interface SectionNavTableViewCell : UITableViewCell

@end

@interface SectionSelTableViewCell : UITableViewCell

@end




