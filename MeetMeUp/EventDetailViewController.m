//
//  EventDetailViewController.m
//  MeetMeUp
//
//  Created by Tewodros Wondimu on 1/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "EventDetailViewController.h"
#import "CommentsViewController.h"
#import "WebViewController.h"

@interface EventDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *rsvp_count;
@property (weak, nonatomic) IBOutlet UITextView *eventDescription;
@property (weak, nonatomic) IBOutlet UILabel *eventGroup;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //
    self.eventName.text = [NSString stringWithFormat:@"%@", self.meetup.name];
    self.rsvp_count.text = [NSString stringWithFormat:@"%@ %@", self.meetup.yes_rsvp_count, self.meetup.group[@"who"]];
    self.eventGroup.text = [NSString stringWithFormat:@"%@", self.meetup.group[@"name"]];

    // Display the spinner until the html is formated
    [self.spinner startAnimating];

    // Displays the html with a formated style
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *htmlString = [NSString stringWithFormat:@"%@", self.meetup.event_description];
        
        NSAttributedString *formatedHtml = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
        self.eventDescription.attributedText = formatedHtml;

        // Stop animating as soon as the html has been converted into annotated text
        [self.spinner stopAnimating];
        self.spinner.hidden = YES; 
    });
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"WebViewSegue"]) {
        WebViewController *webVC = segue.destinationViewController;
        webVC.url = self.meetup.event_url;
        webVC.title = self.meetup.name;
    }
    else if ([segue.identifier  isEqualToString:@"CommentSegue"])
    {
        CommentsViewController *commentVC = segue.destinationViewController;
        commentVC.event_id = self.meetup.event_id;
    }
}

@end
