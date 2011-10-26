//
//  DataFetcher.h
//  5-SimpleTable
//
//  Created by T. Andrew Binkowski on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataFetcher : NSObject <NSURLConnectionDelegate>

@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *xmlData;

- (void) fetchData;

@end
