//
//  MoreSelectionViewController.m
//  Fetch
//
//  Created by Nathan Spaun on 3/1/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "MoreSelectionViewController.h"
#import "UIExpandableTableView.h"
#import "GHCollapsingAndSpinningTableViewCell.h"
#import "Genome.h"
#import "FetchTrait.h"
#import "Fetch.h"

@interface MoreSelectionViewController ()

@end

@implementation MoreSelectionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (id)initWithGenomes:(NSArray*)genomes withCallback:(void(^) (FetchTrait* trait))callback withMoreTrait:(FetchTrait*)moreTrait
{
    self = [super initWithNibName:@"MoreSelectionViewController" bundle:nil];
    if (self) {
        _genomes = genomes;
        _morePillCallback = callback;
        _moreTrait = moreTrait;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearTraits:)] ;
         self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_next"] landscapeImagePhone:[UIImage imageNamed:@"nav_next"] style:nil target:self action:@selector(popVC:)];
    self.tableView = [[UIExpandableTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)popVC:(id)sender
{
    [FetchAppDelegate.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

#pragma mark - UIExpandableTableViewDatasource

- (BOOL)tableView:(UIExpandableTableView *)tableView canExpandSection:(NSInteger)section {
    return YES;
}

- (BOOL)tableView:(UIExpandableTableView *)tableView needsToDownloadDataForExpandableSection:(NSInteger)section {
    return NO;
}

- (UITableViewCell<UIExpandingTableViewCell> *)tableView:(UIExpandableTableView *)tableView expandingCellForSection:(NSInteger)section {
    
    Genome *g = [_genomes objectAtIndex:section];
    
    NSString *CellIdientifier = @"GHCollapsingAndSpinningTableViewCell";
    
    GHCollapsingAndSpinningTableViewCell *cell = (GHCollapsingAndSpinningTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdientifier];
    
    if (cell == nil) {
        cell = [[GHCollapsingAndSpinningTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdientifier];
    }
    
    cell.textLabel.text = g.name;
    
    if ( [g containsTrait:_moreTrait] ) {
        [cell setBackgroundColor:[Genome colorForFamily:g.family]];
    }
    
    return cell;
    // this cell will be displayed at IndexPath with section: section and row 0
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [_genomes count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    Genome *g = [_genomes objectAtIndex:section];
    return [g.traits count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = nil;
    Genome *g = [_genomes objectAtIndex:indexPath.section];
    FetchTrait *f = [g.traits objectAtIndex:indexPath.row-1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        cell.backgroundView = backgroundView;
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = f.name;
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if ( [f isEqual:_moreTrait] ) {
        [cell setHighlighted:YES];
    }
    
//    if ( indexPath.row == 0 ) {
//        cell.textLabel.text = g.name;
//    } else {
//        FetchTrait *f = [g.traits objectAtIndex:indexPath.row];
//        cell.textLabel.text = f.name;
//    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Genome *g = [_genomes objectAtIndex:indexPath.section];
    FetchTrait *f = [g.traits objectAtIndex:indexPath.row-1];
    
    _morePillCallback(f);
    [FetchAppDelegate.navigationController popViewControllerAnimated:NO];
    
}

- (void)clearTraits:(id)sender {
    _morePillCallback(nil);
    [FetchAppDelegate.navigationController popViewControllerAnimated:NO];
    
}

@end
