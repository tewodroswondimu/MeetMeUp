//
//  CommentsViewController.m
//  MeetMeUp
//
//  Created by Tewodros Wondimu on 1/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentDetailViewController.h"
#import "Comment.h"

@interface CommentsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *commentsArray;

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property UIActivityIndicatorView *navbarActivityIndicator;
@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.commentsArray = [[NSMutableArray alloc] init];
    self.tableView.delegate = self;

    // Create a navbar activity indicator, insert it into a UIBarButtonItem and set it right of the nav item
    self.navbarActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    UIBarButtonItem *navSpinnerBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navbarActivityIndicator];
    [self.navItem setRightBarButtonItem:navSpinnerBarButtonItem];

    // Start animating the spinner on view load
    [self.navbarActivityIndicator startAnimating];

    NSString *jsonURLString = [NSString stringWithFormat:@"https://api.meetup.com/2/event_comments?&sign=true&photo-host=public&event_id=%@&key=2e1c3c2a7c6f1b196936174260122143", self.event_id];
    [self getCommentsFromJSONURLString:jsonURLString];
}

- (void)getCommentsFromJSONURLString:(NSString *)url
{
    [self.commentsArray removeAllObjects];

    // Create a url from the string
    NSURL *jsonURL = [NSURL URLWithString:url];

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:jsonURL];

    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        // Create a dictionary of the results
        NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

        NSArray *resultsCommentsArray = resultsDictionary[@"results"];

        // Loops through the results array of comments
        for (NSDictionary *resultCommentDictionary in resultsCommentsArray) {
            Comment *comment = [Comment new];
            comment.member_name = resultCommentDictionary[@"member_name"];
            comment.comment = resultCommentDictionary[@"comment"];
            comment.comment = resultCommentDictionary[@"comment"];

            comment.time = resultCommentDictionary[@"time"];
            comment.group_id = resultCommentDictionary[@"group_id"];
            comment.event_id = resultCommentDictionary[@"event_id"];
            comment.member_id = resultCommentDictionary[@"member_id"];
            comment.event_comment_id = resultCommentDictionary[@"event_comment_id"];


            // Add the comment to the comment array
            [self.commentsArray addObject:comment];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark TABLEVIEW

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.commentsArray.count)
    {
        self.tableView.backgroundView = nil;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return self.commentsArray.count;
    }
    else if (self.commentsArray.count == 0)
    {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];

        messageLabel.text = @"No comments is currently available. Please check again later.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
        [messageLabel sizeToFit];

        if(self.navbarActivityIndicator.isAnimating != false)
        {
            self.tableView.backgroundView = messageLabel;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
    }
    return self.commentsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    Comment *comment = [self.commentsArray objectAtIndex:indexPath.row];

    cell.detailTextLabel.numberOfLines = 3;

    cell.textLabel.text = comment.member_name;
    cell.detailTextLabel.text = comment.comment;
    return cell;
}

#pragma mark SEGUE

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender
{
    CommentDetailViewController *commentDetailVC = segue.destinationViewController;

    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Comment *comment = [self.commentsArray objectAtIndex:indexPath.row];

    commentDetailVC.comment = comment;
}

@end
