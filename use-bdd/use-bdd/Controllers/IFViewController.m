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
#import "IFQuestionTableDelegate.h"

NSString *questionsUrlString = @"http://api.stackoverflow.com/1.1/search?tagged=iphone&pagesize=2";


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
    self.questionTableDelegate = [IFQuestionTableDelegate new];
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
}

- (void)receivedJSON: (NSDictionary *)json
{
    [self spinerAnimation:NO];
}

#pragma mark - Util
-(void)spinerAnimation:(BOOL)animation
{
    self.spinerView.hidden = !animation;
}

@end
