//
//  ViewController.h
//  ios
//
//  Created by Tsukasa on 12-12-31.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"

@interface CategoriesViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *categoriesTable;
-(void) fillData:(mqyyData*)data;
@property(retain) UISegmentedControl* categoriesSegmentBtn;
@property(strong, readonly) mqyyData* data;

@end


@interface CategoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *enterBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *popularLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (retain) mqyyCategory* category;
-(void)fillData:(mqyyCategory*)category;


@end
