//
//  MyTableViewController_iPhone.h
//  5-SimpleTable
//
//  Created by T. Andrew Binkowski on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewController_iPhone : UITableViewController
@property (nonatomic, retain) NSMutableArray *animals;
@property (nonatomic, retain) NSMutableArray *headers;
@property (nonatomic, retain) NSMutableArray *footers;
- (void)loadData;
- (void)loadDataWithOperation;

@end
