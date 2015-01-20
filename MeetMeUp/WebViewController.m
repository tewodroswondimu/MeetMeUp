//
//  WebViewController.m
//  MeetMeUp
//
//  Created by Tewodros Wondimu on 1/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navItem.title = self.title;

    self.webView.delegate = self;
    [self loadNewWebPage:self.url];
}

- (IBAction)backButtonPressed:(id)sender
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

- (IBAction)onForwardButtonPressed:(id)sender
{
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (buttonIndex == 1)
    {
        [self loadNewWebPage:self.url];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.title = @"Loding Failed";
    alertView.delegate = self;
    alertView.message = error.localizedDescription;
    [alertView addButtonWithTitle:@"Dismiss"];
    [alertView addButtonWithTitle:@"Retry"];
    [alertView show];
}

-(void)loadNewWebPage:(NSString *)string
{
    NSString *addressString = string;
    NSURL *addressURL = [NSURL URLWithString:addressString];
    NSURLRequest *addressRequest = [NSURLRequest requestWithURL:addressURL];
    [self.webView loadRequest:addressRequest];
}

// Removes the web view controller
- (IBAction)onCloseButtonTapped:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
