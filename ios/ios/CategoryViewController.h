//
//  CategoryViewController.h
//  ios
//
//  Created by Tsukasa on 13-1-15.
//  Copyright (c) 2013年 Tsukasa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"

@interface CategoryViewController : UITableViewController
-(void) fillData:(mqyyCategory*)category;
@property(retain, readonly) mqyyCategory* category;
@end


@interface ContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *popularLabel;
@property (weak, nonatomic) IBOutlet UILabel *readerLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

-(void) fillData:(mqyyProgram*)program;

@end
