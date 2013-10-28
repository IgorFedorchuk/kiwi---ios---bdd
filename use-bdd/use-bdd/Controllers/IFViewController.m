//
//  IFViewController.m
//  use-bdd
//
//  Created by Igor on 26.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFViewController.h"
#import "IFStackOverflowRequest.h"
#import "AFNetworking.h"
#import "IFQuestionBuilder.h"

NSString *questionsUrlStringFormat = @"http://api.stackoverflow.com/1.1/search?tagged=iphone&page=%d&pagesize=20&sort=creation";


@interface IFViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *spinerView;
@property (nonatomic, strong) IFQuestionTableDelegate *questionTableDelegate;
@property (nonatomic, strong) IFStackOverflowRequest *request;
@property (nonatomic, assign) NSInteger currentPageRequest;

@end

@implementation IFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Iphone tag";
    self.questionTableDelegate = [[IFQuestionTableDelegate alloc] initWithDelegate:self];
    self.tableView.dataSource = self.questionTableDelegate;
    self.tableView.delegate = self.questionTableDelegate;
    self.currentPageRequest = 1;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startQuestionsRequest];
    [self spinerAnimation:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.tableView = nil;
    self.spinerView = nil;
    self.questionTableDelegate = nil;
    self.request = nil;
}

#pragma mark - StackOverflowRequestDelegate
- (void)fetchFailedWithError: (NSError *)error
{
    [self spinerAnimation:NO];
    [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Request is failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)receivedJSON: (NSDictionary *)json
{
    self.currentPageRequest++;
    [self spinerAnimation:NO];
    IFQuestionBuilder *questionBuilder = [IFQuestionBuilder new];
    NSArray *questions = [questionBuilder questionsFromJSON:json];
    [self.questionTableDelegate addQuestions:questions];
    [self.tableView reloadData];
}

#pragma mark - QuestionTableDelegate
- (void)needMoreQuestions
{
    [self startQuestionsRequest];
}

#pragma mark - Util
-(void)spinerAnimation:(BOOL)animation
{
    self.spinerView.hidden = !animation;
}

-(void)startQuestionsRequest
{
    self.request = [[IFStackOverflowRequest alloc] initWithDelegate:self urlString:[self urlString]];
    [[self.request fetchQestions] start];
}

-(NSString *)urlString
{
    return [NSString stringWithFormat:questionsUrlStringFormat,self.currentPageRequest];
}

@end
