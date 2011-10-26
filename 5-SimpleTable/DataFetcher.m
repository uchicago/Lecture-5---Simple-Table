//
//  DataFetcher.m
//  5-SimpleTable
//
//  Created by T. Andrew Binkowski on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DataFetcher.h"

@implementation DataFetcher
@synthesize connection;
@synthesize xmlData;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.xmlData = [[NSMutableData alloc] init];
    }
    return self;
}
- (void)dealloc {
    [self.xmlData release];
}

- (void)fetchData {
    NSURL *url = [NSURL URLWithString:@"http://www.apple.com/pr/feeds/pr.rss"];
    
    // Put that URL into an NSURLRequest 
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    // Connection that will exchange this request for data from the URL 
    connection = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
}

// This method will be called several times as the data arrives 
- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data {
    // Add the incoming chunk of data to the container we are keeping 
    // The data always comes in the correct order 
    [xmlData appendData:data];
    NSLog(@"Getting data");
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn {
    // We are just checking to make sure we are getting the XML 
    NSString *xmlCheck = [[[NSString alloc] initWithData:xmlData 
                                                encoding:NSUTF8StringEncoding] 
                          autorelease];
    NSLog(@"Done: xmlCheck = %@", xmlCheck);
}
- (void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error {
    // Release the connection object, we're done with it 
    [connection release]; 
    connection = nil;
    
    // Release the xmlData object, we're done with it 
    [xmlData release]; 
    xmlData = nil;
    
    // Grab the description of the error object passed to us 
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@",
                             [error localizedDescription]];
    NSLog(@"Error:%@",errorString);
    
}
@end
