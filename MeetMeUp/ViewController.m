//
//  ViewController.m
//  MeetMeUp
//
//  Created by Tewodros Wondimu on 1/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> 

@property NSDictionary *resultsDictionary;
@property NSArray *meetupsArray;
@property NSDictionary *meetupDictionary;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    NSURL *jsonUrl = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=2e1c3c2a7c6f1b196936174260122143"];

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:jsonUrl];

    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        // Creates a dictionary of the results
        self.resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.meetupsArray = self.resultsDictionary[@"results"];
        self.meetupDictionary = self.meetupsArray[0];

        NSLog(@"%@", self.meetupDictionary);

    }];
}

@end
