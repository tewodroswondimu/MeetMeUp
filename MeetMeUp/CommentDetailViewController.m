//
//  CommentDetailViewController.m
//  MeetMeUp
//
//  Created by Tewodros Wondimu on 1/20/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "CommentDetailViewController.h"

@interface CommentDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *memberLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation CommentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSTimeInterval time = [self.comment.time doubleValue] / 1000;
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];

    NSString *dateString = [dateFormatter stringFromDate:date];

    self.memberLabel.text = self.comment.member_name;
    self.commentTextView.text = self.comment.comment;
    self.dateLabel.text = dateString;
}

@end
