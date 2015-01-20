//
//  EventDetailViewController.m
//  MeetMeUp
//
//  Created by Tewodros Wondimu on 1/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *rsvp_count;
@property (weak, nonatomic) IBOutlet UITextView *eventDescription;
@property (weak, nonatomic) IBOutlet UILabel *eventGroup;

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //
    self.eventName.text = [NSString stringWithFormat:@"%@", self.meetup.name];
    self.rsvp_count.text = [NSString stringWithFormat:@"%@ %@", self.meetup.yes_rsvp_count, self.meetup.group[@"who"]];
    self.eventGroup.text = [NSString stringWithFormat:@"%@", self.meetup.group[@"name"]];

    // Displays the html with a formated style
    NSString *htmlString = [NSString stringWithFormat:@"%@", self.meetup.event_description];
    NSAttributedString *formatedHtml = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
    self.eventDescription.attributedText = formatedHtml;
    

}

@end
