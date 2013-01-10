//
//  IFViewController.m
//  use-bdd
//
//  Created by Igor on 26.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFViewController.h"
#import "IFStackOverflowRequest.h"
#import "AFJSONRequestOperation.h"
#import "IFQuestionBuilder.h"

NSString *questionsUrlString = @"http://api.stackoverflow.com/1.1/search?tagged=iphone&pagesize=20";


@interface IFViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *spinerView;
@property (nonatomic, strong) IFQuestionTableDelegate *questionTableDelegate;

@end

@implementation IFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Iphone tag";
    self.questionTableDelegate = [[IFQuestionTableDelegate alloc] initWithDelegate:self];
    self.tableView.dataSource = self.questionTableDelegate;
    self.tableView.delegate = self.questionTableDelegate;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];    
    IFStackOverflowRequest *request = [[IFStackOverflowRequest alloc] initWithDelegate:self urlString:questionsUrlString];
    [[request fetchQestions] start];
    [self spinerAnimation:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - StackOverflowRequestDelegate
- (void)fetchFailedWithError: (NSError *)error
{
    [self spinerAnimation:NO];
    [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Request is failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)receivedJSON: (NSDictionary *)json
{
    [self spinerAnimation:NO];
    IFQuestionBuilder *questionBuilder = [IFQuestionBuilder new];
    NSArray *questions = [questionBuilder questionsFromJSON:json];
    [self.questionTableDelegate addQuestions:questions];
    [self.tableView reloadData];
}

#pragma mark - QuestionTableDelegate
- (void)needMoreQuestions
{
    
}

#pragma mark - Util
-(void)spinerAnimation:(BOOL)animation
{
    self.spinerView.hidden = !animation;
}

@end
