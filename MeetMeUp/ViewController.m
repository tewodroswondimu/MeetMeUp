//
//  ViewController.m
//  MeetMeUp
//
//  Created by Tewodros Wondimu on 1/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "EventDetailViewController.h"
#import "Meetup.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> 
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSDictionary *resultsDictionary;
@property NSArray *resultsMeetUpArray;

@property NSMutableArray *meetUpsArray;

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property UIActivityIndicatorView *navbarActivityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.meetUpsArray = [[NSMutableArray alloc] init];
    self.tableView.delegate = self;

    // Create a navbar activity indicator, insert it into a UIBarButtonItem and set it right of the nav item
    self.navbarActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *navSpinnerBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navbarActivityIndicator];
    [self.navItem setRightBarButtonItem:navSpinnerBarButtonItem];

    // Start animating the spinner on view load
    [self.navbarActivityIndicator startAnimating];
    
    // create a url with the json file
    NSString *url = @"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=2e1c3c2a7c6f1b196936174260122143";
    NSURL *jsonUrl = [NSURL URLWithString:url];

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:jsonUrl];

    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        // Creates a dictionary of the results
        self.resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.resultsMeetUpArray = self.resultsDictionary[@"results"];

        // Loops through the results array of meetups
        for (NSDictionary *resultsMeetupDictionary in self.resultsMeetUpArray) {
            // Create a temporary meetup object to store the
            Meetup *meetUp = [[Meetup alloc] init];
                meetUp.name = resultsMeetupDictionary[@"name"];
                meetUp.headcount = resultsMeetupDictionary[@"headcount"];
                meetUp.status = resultsMeetupDictionary[@"status"];
                meetUp.visibility = resultsMeetupDictionary[@"visibility"];
                meetUp.maybe_rsvp_count = resultsMeetupDictionary[@"maybe_rsvp_count"];
                meetUp.venue = resultsMeetupDictionary[@"venue"];
                meetUp.meetupId = resultsMeetupDictionary[@"id"];
                meetUp.utc_offset = resultsMeetupDictionary[@"utc_offset"];
                meetUp.distance = resultsMeetupDictionary[@"distance"];
                meetUp.duration = resultsMeetupDictionary[@"duration"];
                meetUp.time = resultsMeetupDictionary[@"time"];
                meetUp.waitlist_count = resultsMeetupDictionary[@"waitlist_count"];
                meetUp.updated = resultsMeetupDictionary[@"updated"];
                meetUp.yes_rsvp_count = resultsMeetupDictionary[@"yes_rsvp_count"];
                meetUp.created = resultsMeetupDictionary[@"created"];
                meetUp.event_url = resultsMeetupDictionary[@"event_url"];
                meetUp.event_description = resultsMeetupDictionary[@"description"];
                meetUp.group = resultsMeetupDictionary[@"group"];

            // Add your meetup object inside a mutable array
            [self.meetUpsArray addObject:meetUp];
            [self.tableView reloadData];
        }
        [self.navbarActivityIndicator stopAnimating];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeetupCell"];
    Meetup *meetup = [self.meetUpsArray objectAtIndex:indexPath.row];

    cell.detailTextLabel.numberOfLines = 2;

    cell.textLabel.text = meetup.name;
    cell.detailTextLabel.text = meetup.venue[@"address_1"];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.meetUpsArray.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender
{
    EventDetailViewController *eventDVC = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Meetup *meetUpToSend = [self.meetUpsArray objectAtIndex:indexPath.row];
    eventDVC.meetup = meetUpToSend; 
}

@end
