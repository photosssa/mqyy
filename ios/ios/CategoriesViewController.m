//
//  ViewController.m
//  ios
//
//  Created by Tsukasa on 12-12-31.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#import "CategoriesViewController.h"
#import "UITestData.h"

@interface CategoriesViewController ()
{
    mqyyData* _data;
}
@end

@implementation CategoriesViewController
@synthesize data=_data;

-(void) fillData:(mqyyData*)data
{
    _data = data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fillData: [[UITestData alloc]init]];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    NSString *seg1 = @"热门排行";
    NSString *seg2 = @"分类浏览";
    NSString *seg3 = @"我的历史";
    NSArray *segs = [[NSArray alloc] initWithObjects:seg1,seg2,seg3,nil];
    _categoriesSegmentBtn = [[UISegmentedControl alloc] initWithItems:segs];
    self.navigationItem.titleView = _categoriesSegmentBtn;
    CGRect navItemFrame = self.navigationController.navigationBar.frame;
    float segBtnOffset = 5;
    [_categoriesSegmentBtn setFrame:CGRectMake(navItemFrame.origin.x - segBtnOffset, navItemFrame.origin.y - segBtnOffset, navItemFrame.size.width - 2 * segBtnOffset, navItemFrame.size.height - 2 * segBtnOffset)];
    _categoriesSegmentBtn.segmentedControlStyle = UISegmentedControlStyleBar;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//for table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
    [(CategoryTableViewCell*)cell fillData:[self.data.categories objectAtIndex: indexPath.item]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
     */
}



@end


@implementation CategoryTableViewCell

@synthesize contentLabel, titleLabel, popularLabel;

-(void)fillData:(mqyyCategory*) category
{
    titleLabel.text = category.name;
    popularLabel.text = [NSString stringWithFormat:@"%d", category.popular] ;
}

@end




