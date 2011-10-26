//
//  MyTableViewController_iPhone.m
//  5-SimpleTable
//
//  Created by T. Andrew Binkowski on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MyTableViewController_iPhone.h"
#import "DetailViewController.h"

@implementation MyTableViewController_iPhone
@synthesize animals;
@synthesize headers;
@synthesize footers;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.animals = [[NSMutableArray alloc] initWithObjects:@"cow",@"zebra",@"deer",@"bat",nil];
        self.headers = [[NSMutableArray alloc] initWithObjects:@"Animals",nil];
        self.footers = [[NSMutableArray alloc] initWithObjects:@"Animals Footer",nil];
        [self loadData];
    }
    return self;
}

- (void)loadData {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // Operation Queue init (autorelease)
    NSOperationQueue *queue = [NSOperationQueue new];
	
    // Create our NSInvocationOperation to call loadDataWithOperation, passing in nil 
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(loadDataWithOperation)
                                                                              object:nil];
    // Add the operation to the queue 
    [queue addOperation:operation];
    [operation release];
    [queue release];
}

- (void)loadDataWithOperation {
    NSURL *plistUrl = [[[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://gist.github.com/raw/01be7563ed651de1fa80/c7ce9bed135ceb90433715478cdb22c7be5c92f8/NumberData.plist"]]autorelease];
    NSMutableArray *tmpData = [[NSMutableArray alloc] initWithContentsOfURL:plistUrl];
    animals = tmpData;
    sleep(3);
    
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];	
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
    NSLog(@"Data:%@",tmpData);
}

- (void)dealloc
{
    [animals release];
    [headers release];
    [footers release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *headerBox = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
    headerBox.backgroundColor = [UIColor blueColor];
    self.tableView.tableHeaderView = headerBox;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)sender titleForHeaderInSection:(NSInteger)section
{
    return [headers objectAtIndex:section];
}
- (NSString *)tableView:(UITableView *)sender titleForFooterInSection:(NSInteger)section
{
    return [footers objectAtIndex:section];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [animals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [animals objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

#pragma mark - Table Editing

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.animals removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSString *oldAnimal = [NSString stringWithString:[animals objectAtIndex:fromIndexPath.row]];
    [self.animals removeObjectAtIndex:fromIndexPath.row];
    [self.animals insertObject:oldAnimal atIndex:toIndexPath.row];
    NSLog(@"Animal:%@",animals);
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"accessoryButtonTappedForRowWithIndexPath: row=%d", indexPath.row);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Touch Row:%d",indexPath.row);
    
    // Navigation logic may go here. Create and push another view controller.
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];

     // Pass the selected object to the new view controller.
    detailViewController.indexData = [NSString stringWithFormat:@"Row %d - %@",indexPath.row,[self.animals objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithWhite:0.7 alpha:0.1];
        cell.backgroundColor = altCellColor;
    }
}

@end
