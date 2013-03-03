//
//  ViewController.m
//  ios
//
//  Created by Tsukasa on 12-12-31.
//  Copyright (c) 2012年 Tsukasa. All rights reserved.
//

#import "CategoriesViewController.h"
#import "UITestData.h"
#import "CategoryViewController.h"
#import "mqyyClient.h"


@interface CategoriesViewController ()
{
    mqyyData* _data;
//    mqyyAudio* _audio;
}
@end

@implementation CategoriesViewController
@synthesize data=_data,categoriesTable;

-(void) fillData:(mqyyData*)data
{
    _data = data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //[self fillData: [[UITestData alloc]init]];
    [self fillData: [[[mqyyClient clientInstance] svrstub] syncGetData]];
    
	// Do any additional setup after loading the view, typically from a nib.
   
    _categoriesSegmentBtn = [[CategoriesSegmentControl alloc] initWithController:self seg:CategoriesSegmentControlSegCategories];
    self.navigationItem.hidesBackButton = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[mqyyClient clientInstance] showRecodeToolbar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"ShowCategory"])
    {
        CategoryViewController* destCtrl = (CategoryViewController*)[segue destinationViewController];
        
        mqyyCategory* category = [self.data.categories objectAtIndex:[categoriesTable indexPathForSelectedRow].row];
        [[[mqyyClient clientInstance] svrstub] syncFillCategory:category];
        [destCtrl fillData:category];
        
        UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
        temporaryBarButtonItem.title=@"分类";
        self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    }
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
    [(CategoryTableViewCell*)cell fillData:[self.data.categories objectAtIndex: indexPath.row]];
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
    //CategoryTableViewCell* cell = (CategoryTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //CategoryTableViewCell* cell = (CategoryTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
}


@end


@implementation CategoryTableViewCell

@synthesize contentLabel, titleLabel, popularLabel,enterBtn,category;

-(void)fillData:(mqyyCategory*)_category;
{
    titleLabel.text = _category.name;
    popularLabel.text = [NSString stringWithFormat:@"%d", _category.popular] ;
    contentLabel.text = [NSString stringWithFormat:@"%d", _category.programs.count] ;
    self.category = _category;
}



@end


@implementation CategoriesSegmentControl
{
    @private
    UIViewController* _controller;
}
-(CategoriesSegmentControl*)initWithController:(UIViewController*)controller  seg:(enum CategoriesSegmentControlSeg)seg
{
    NSString *seg1 = @"热门排行";
    NSString *seg2 = @"分类浏览";
    NSString *seg3 = @"我的历史";
    NSArray *segs = [[NSArray alloc] initWithObjects:seg1,seg2,seg3,nil];
    self = [self initWithItems:segs];
    controller.navigationItem.titleView = self;
    CGRect navItemFrame = controller.navigationController.navigationBar.frame;
    float segBtnOffset = 5;
    [self setFrame:CGRectMake(navItemFrame.origin.x - segBtnOffset, navItemFrame.origin.y - segBtnOffset, navItemFrame.size.width - 2 * segBtnOffset, navItemFrame.size.height - 2 * segBtnOffset)];
    self.segmentedControlStyle = UISegmentedControlStyleBar;
    self.selectedSegmentIndex = seg;
    [self addTarget:self action:@selector(segChanged) forControlEvents:UIControlEventValueChanged];
    _controller = controller;
    return self;
}

-(void)segChanged
{
    if(self.selectedSegmentIndex == CategoriesSegmentControlSegHistory)
    {
        UIStoryboard* storyBoard = _controller.storyboard;
        UIViewController* dest = [storyBoard instantiateViewControllerWithIdentifier:@"HistoryView"];
        [_controller.navigationController pushViewController:dest animated:YES];
    }
    else if(self.selectedSegmentIndex == CategoriesSegmentControlSegCategories)
    {
        UIStoryboard* storyBoard = _controller.storyboard;
        UIViewController* dest = [storyBoard instantiateViewControllerWithIdentifier:@"CategoriesView"];
        [_controller.navigationController pushViewController:dest animated:YES];
    }
}
@end


